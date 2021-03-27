# ================ Calculate harmonic unbalance response  ================ #
# Author: Lysandros Anastasopoulos
function Flywheel_harmonic(M,G,D,K,Omega)
    t1=println("Calculating harmonic unbalance reponse...")
  
    N=Int64(size(M)[1]/4-1)
  
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
  end    # Flywheel_harmonic()