# ======================== Calculate gravity force  ======================== #

function Flywheel_gravity(RotorSpreadsheet, gi)
  t1=println("Calculating gravity force vector...")
 
  N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,adro,adri,adle,adrho,adma,adjp,adjt,DiscThick,DiscRad =Flywheel_load(RotorSpreadsheet)
  
  GravForce= zeros(Float64,4*(N+1),1)    zeros(6*(N+1),1);
  
   for ii=1:N-1  
    GravForce[2*(N+1)+1+2*ii,1]= -[mu[ii]*len[ii]/2 + mu[ii+1].*len[ii+1]/2]'*gi
   end
   GravForce[2*(N+1)+1+0  ,1]=-mu[1].*len[1]/2*gi
   GravForce[2*(N+1)+1+2*N,1]=-mu[N].*len[N]/2*gi
#   for iii=1:NNN
#     GravForce[2*(N+1)+2*PosNN[iii]-2]=GravForce[2*(N+1)+2*PosNN[iii]-2]-adma[iii]*gi                % Nodes with added discs receive the respective mass
#   end



#p=Flywheel_blueprint(RotorSpreadsheet)
   return GravForce
 end    # Flywheel_gravity()