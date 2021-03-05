# ======================== Load rotor file ======================== #
function Flywheel_load(RotorSpreadsheet)
  t1=println("Loading rotor file...")
   ImportFile=readdlm(string(RotorSpreadsheet,".txt"), '\t', Float64, '\n', header=true)
   ImportHeaders=ImportFile[2];
   ImportData=ImportFile[1];
   N=Int64(size(ImportData)[1]);
   
   # Allocate arrays
   len= zeros(Float64,N);  ro=  zeros(Float64,N);  ri=  zeros(Float64,N);  rho= zeros(Float64,N);
   E=   zeros(Float64,N);  nu=  zeros(Float64,N);  It=  zeros(Float64,N);  A=   zeros(Float64,N);
   mu=  zeros(Float64,N);  jp=  zeros(Float64,N);  jt=  zeros(Float64,N);  
   PosNN=  zeros(Int64,0); 
   PosNNN= zeros(Int64,0); 
   BearX=zeros(Float64,N);   BearY=zeros(Float64,N);
   DiscThick= zeros(Float64,N);  DiscRad= zeros(Float64,N);
   NN=0;
   NNN=0;
   for i=1:N
     len[i]=ImportData[i,2];                  # Length of finite element
     ro[i]=ImportData[i,3];                   # Outer radius of finite element
     ri[i]=ImportData[i,4];                   # Inner radius of finite element
     rho[i]=ImportData[i,5];                  # Material density
     E[i]=  ImportData[i,6]*1e12;             # Young modulus
     nu[i]= ImportData[i,7];                  # Poisson ratio
     BearX[i]=  ImportData[i,9];              # Bearing hor. stiffness
     BearY[i]=  ImportData[i,10];             # Bearing ver. stiffness
     DiscThick[i]= ImportData[i,12];          # Disc thickness
     DiscRad[i]= ImportData[i,13];            # Disc outer radius
     It[i]=pi*(ro[i]^4-ri[i]^4)/4;            # Area second moment of inertia
     A[i]=pi*(ro[i]^2-ri[i]^2);               # Cross-section area
     mu[i]=rho[i]*A[i];                       # Mass per unit length
     jp[i]=1/2*rho[i]*A[i]*(ro[i]^2+ri[i]^2); # Polar moment of inertia per unit length
     jt[i]=pi*rho[i]*len[i]/12*(3*(ro[i]^4-ri[i]^4))/len[i]; # Transversal moment of inertia per unit length
   end
   SumL=sum(len);
  
   counter=1;
   for i=1:N
     if ImportData[i,8]==1.0
      append!( PosNN, counter )
     elseif  ImportData[i,8]==2.0
       append!( PosNN, counter+1 )
     end
     counter=counter+1;
   end
   NN=length(PosNN)
  
   counter=1;
   for i=1:N
     if ImportData[i,11]==1.0
       append!( PosNNN, counter )
     elseif  ImportData[i,11]==2.0
       append!( PosNNN, counter+1 )
     end
     counter=counter+1;
   end      
   NNN=length(PosNNN)
  
   return N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,DiscThick,DiscRad
  end    # Flywheel_load()