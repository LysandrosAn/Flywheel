# ======================== Create matrices  ======================== #
function Flywheel_rearrange(RotorSpreadsheet,Omega)
  t1=println("Creating state-space dynamic matrix...")

 M,G,C,K =Flywheel_FEMatrices(RotorSpreadsheet)
 N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,DiscThick,DiscRad =Flywheel_load(RotorSpreadsheet)

 # Allocate arrays
 DynMa=  zeros(Float64,8*(N+1),8*(N+1));
 
 return DynMa
end    # Flywheel_rearrange()
