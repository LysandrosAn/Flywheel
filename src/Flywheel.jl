# ======================== 1-D Finite Element Rotating Machinery Code ======================== #
module Flywheel
export Flywheel_blueprint, Flywheel_formulation

using LinearAlgebra
using Plots 
using DelimitedFiles
using SymPy
include("Flywheel_load.jl")
include("Flywheel_blueprint.jl")
include("Flywheel_discrete.jl")
include("Flywheel_localize.jl")



function Flywheel_formulation(RotorSpreadsheet)
 t1=println("Creating shape functions")

 N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,DiscThick,DiscRad =Flywheel_load(RotorSpreadsheet)
 K_b,C_b,M_d,G_d =Flywheel_discrete(RotorSpreadsheet)
 
 # Allocate arrays
 Kbend_s= zeros(Float64,8,8,N)  
 MassT_s= zeros(Float64,8,8,N)
 MassR_s= zeros(Float64,8,8,N)
 Mass_s= zeros(Float64,8,8,N)
 Na_s= zeros(Float64,8,8,N)
 Nb_s= zeros(Float64,8,8,N)
 N_s= zeros(Float64,8,8,N)
 Gyro_s= zeros(Float64,8,8,N)
 Kstiff_b= zeros(Float64,4,4,N)
 Cdamp_b= zeros(Float64,4,4,N)
 Mass_d= zeros(Float64,4,4,N)
 Gyro_d= zeros(Float64,4,4,N)
 Om=120.0

  # Shaft element stiffness, mass and gyroscopy matrix
  s = Sym("s")
  for i=1:1
    l=len[i]
    psi1= 1-3*(s/l)^2+2*(s/l)^3; psi1p= -6*(s/l^2)+6*(s^2/l^3); psi1pp= -6/l^2+12*s/l^3;
    psi2= s*(1-2*(s/l)+(s/l)^2); psi2p= 1-4*(s/l)+3*(s^2/l^2);  psi2pp= -4/l+6*s/l^2;
    psi3= 3*(s/l)^2-2*(s/l)^3;   psi3p= +6*(s/l^2)-6*(s^2/l^3); psi3pp= +6/l^2-12*s/l^3;
    psi4= l*(-(s/l)^2+(s/l)^3);  psi4p= -2*(s/l)+3*(s^2/l^2);   psi4pp= -2/l+6*s/l^2;
      
    Psi= [ +psi1 0 0 +psi2 +psi3 0 0 +psi4;       0 +psi1 -psi2 0 0 +psi3 -psi4 0 ]
    Psi_pp= [ +psi1pp 0 0 +psi2pp +psi3pp 0 0 +psi4pp;          0 +psi1pp -psi2pp 0 0 +psi3pp -psi4pp 0 ]
    PhiX= [ 0 -psi1p +psi2p 0 0 -psi3p +psi4p 0 ]
    PhiY= [ +psi1p 0 0 +psi2p +psi3p 0 0 +psi4p ]
    Phi=[PhiX;PhiY] 
    for k=1:8
     for j=1:8
      Kbend_s[k,j,i]=integrate(  (E[i]*It[i]*Psi_pp'*Psi_pp)[k,j],(s,0,l)  )
      MassT_s[k,j,i]=integrate(  (mu[i]*Psi'*Psi)[k,j],(s,0,l)  )
      MassR_s[k,j,i]=integrate(  (jt[i]*Phi'*Phi)[k,j],(s,0,l)  )
      Na_s[k,j,i]=   integrate(  (jp[i]*PhiX'*PhiY)[k,j],(s,0,l)  )
      Nb_s[k,j,i]=   integrate(  (jp[i]*PhiY'*PhiX)[k,j],(s,0,l)  )
     end
    end

  Mass_s[:,:,i]=  MassT_s[:,:,i]+MassR_s[:,:,i]  
  N_s[:,:,i]=Na_s[:,:,i]-Nb_s[:,:,i]
  Gyro_s[:,:,i]=   1/2*Om*(N_s[:,:,i]-N_s[:,:,i]') 
 end
  
  # Bearing element stiffness matrix
  for ii=1:NN
    Kstiff_b[:,:,ii]= K_b[:,:,ii]
    Cdamp_b[:,:,ii]= 0*K_b[:,:,ii]
  end

   # Disc element mass and gyroscopic matrix
  for iii=1:NNN
   Mass_d[:,:,iii]= M_d[:,:,iii]
   Gyro_d[:,:,iii]= G_d[:,:,iii]
  end


  # Component matrices (p.337)
  M= zeros(Float64,4*(N+1),4*(N+1))
  MS= zeros(Float64,4*(N+1),4*(N+1))
  MD= zeros(Float64,4*(N+1),4*(N+1))
  G= zeros(Float64,4*(N+1),4*(N+1))
  GS= zeros(Float64,4*(N+1),4*(N+1))
  GD= zeros(Float64,4*(N+1),4*(N+1))
  C= zeros(Float64,4*(N+1),4*(N+1))
  CB= zeros(Float64,4*(N+1),4*(N+1))
  K= zeros(Float64,4*(N+1),4*(N+1))
  KS= zeros(Float64,4*(N+1),4*(N+1))
  KB= zeros(Float64,4*(N+1),4*(N+1))
  Qs= zeros(Int64,8,(N+1)*4,N)
  Qb= zeros(Int64,4,(N+1)*4,NN)
  Qd= zeros(Int64,4,(N+1)*4,NNN)

  # Create localization matrix for each shaft element
  for elem=1:N
   Qs[:,:,elem]=Flywheel_localize(elem,N,8)
  end

  # Compose overall shaft element matrices
  for i=1:N
    MS=MS+Qs[:,:,i]'*Mass_s[:,:,i]*Qs[:,:,i]
    KS=KS+Qs[:,:,i]'*Kbend_s[:,:,i]*Qs[:,:,i]
    GS=GS+Qs[:,:,i]'*Gyro_s[:,:,i]*Qs[:,:,i]
  end


  # Create localization matrix for each bearing
  for bear=1:NN
    Qb[:,:,bear]=Flywheel_localize(PosNN[bear],N,4)
  end
  
  # Compose overall bearings matrices
  for ii=1:NN
    KB=KB+Qb[:,:,ii]'*Kstiff_b[:,:,ii]*Qb[:,:,ii]
    CB=CB+Qb[:,:,ii]'*Cdamp_b[:,:,ii]*Qb[:,:,ii]
  end


  # Create localization matrix for each disc
  for disc=1:NNN
    Qd[:,:,disc]=Flywheel_localize(PosNNN[disc],N,4)
  end

  # Compose overall disc matrices
  for iii=1:NNN
    MD=MD+Qd[:,:,iii]'*Mass_d[:,:,iii]*Qd[:,:,iii]
    GD=GD+Qd[:,:,iii]'*Gyro_d[:,:,iii]*Qd[:,:,iii]
  end

  # System matrices
  M=MS+MD  # Mass matrix: sum of "S"haft and "D"isc contributions
  G=GS+GD  # Gyroscopy matrix: sum of "S"haft and "D"isc contributions
  C=CB     # Damping matrix: "B"earing contribution only (linear bearings, connected to ground are deactivated, since pedestals are required)
  K=KS+KB  # Stiffness matrix: sum of "S"haft and "B"earing contributions (linear bearings, connected to ground are deactivated, since pedestals are required)
  
  return eigvals(K)
end    # Flywheel_formulation()

end # Module Flywheel