# ======================== Create matrices  ======================== #
function Flywheel_statespace(RotorSpreadsheet,Omega)
  t1=println("Creating state-space dynamic matrix...")

  N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,adro,adri,adle,adrho,adma,adjp,adjt,DiscThick,DiscRad =Flywheel_load(RotorSpreadsheet)
  M,G,D,K =Flywheel_FEMatrices(RotorSpreadsheet)

 # Allocate arrays
 DynMa=  zeros(Float64,8*(N+1),8*(N+1));
 InpMa=  zeros(Float64,8*(N+1),4*(N+1));
 
 DynMa[ 1         : 4*(N+1) , 1         : 4*(N+1) ]=-inv(M)*G*Omega*2*pi/60-inv(M)*D
 DynMa[ 1         : 4*(N+1) , 4*(N+1)+1 : 8*(N+1) ]=-inv(M)*K
 DynMa[ 4*(N+1)+1 : 8*(N+1) , 1         : 4*(N+1) ]= Matrix{Float64}(I, 4*(N+1), 4*(N+1))
 DynMa[ 4*(N+1)+1 : 8*(N+1) , 4*(N+1)+1 : 8*(N+1) ]= zeros(Float64, 4*(N+1), 4*(N+1))

 InpMa[ 1         : 4*(N+1) , 1         : 4*(N+1) ]=-inv(M)
 InpMa[ 4*(N+1)+1 : 8*(N+1) , 1         : 4*(N+1) ]= zeros(Float64, 4*(N+1), 4*(N+1))
return DynMa,InpMa
end    # Flywheel_statespace()
