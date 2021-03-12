# ======================== Calculate gravity force  ======================== #

function Flywheel_gravity(RotorSpreadsheet, gi,K)
  t1=println("Calculating gravity force vector...")

  N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,adro,adri,adle,adrho,adma,adjp,adjt,DiscThick,DiscRad =Flywheel_load(RotorSpreadsheet)
  
  GravForce= zeros(Float64,4*(N+1),1)
  BeamLine= zeros(Float64,20)

  for ii=1:N-1  
    GravForce[2*(N+1)+1+2*ii,1]=-(mu[ii]*len[ii]/2 + mu[ii+1]*len[ii+1]/2)'*gi
  end
  GravForce[2*(N+1)+1+0  ,1]=-mu[1].*len[1]/2*gi
  GravForce[2*(N+1)+1+2*N,1]=-mu[N].*len[N]/2*gi
   for iii=1:NNN
     GravForce[2*(N+1)+2*(PosNNN[iii]-1)+1]=GravForce[2*(N+1)+2*(PosNNN[iii]-1)+1]-adma[iii]*gi
   end
   
   gravFy=inv(K)*GravForce
  
   nodes_trX= zeros(Int64,N+1,1)
   nodes_trY= zeros(Int64,N+1,1)
   
   for ii=1:N+1
    nodes_trX[ii]=2*(ii-1)+1
    nodes_trY[ii]=2*(ii-1)+1+2*(N+1)
   end
  
   ScaleFac=1/2*maximum(DiscRad)/maximum(abs.(gravFy[nodes_trY]))
   p=0
   #plot()
   #p=plot!([0.0; cumsum(len)], ScaleFac*gravFy[nodes_trY], label="Deformation due to gravity",  linewidth = 1.75, linecolor = :indianred4)
   #p=plot!([0.0; cumsum(len)], ScaleFac*gravFy[nodes_trY], marker = ([:circle :d], 2, 0.4, Plots.stroke(2, :gray)), legend=:false)

   s = Sym("s")  
   for ii=1:N
    l=len[ii]
    stR=sum(len[1:ii])
    stL=sum(len[1:ii])-l
    psi1= 1-3*(s/l)^2+2*(s/l)^3#; psi1p= -6*(s/l^2)+6*(s^2/l^3); psi1pp= -6/l^2+12*s/l^3;
    psi2= s*(1-2*(s/l)+(s/l)^2)#; psi2p= 1-4*(s/l)+3*(s^2/l^2);  psi2pp= -4/l+6*s/l^2;
    psi3= 3*(s/l)^2-2*(s/l)^3  #;   psi3p= +6*(s/l^2)-6*(s^2/l^3); psi3pp= +6/l^2-12*s/l^3;
    psi4= l*(-(s/l)^2+(s/l)^3) #;  psi4p= -2*(s/l)+3*(s^2/l^2);   psi4pp= -2/l+6*s/l^2;
   
    TransL= gravFy[2*(ii-1)+1+2*(N+1)]
    RotL=   gravFy[2*(ii-1)+2+2*(N+1)]
    TransR= gravFy[2*(ii-1)+3+2*(N+1)]
    RotR=   gravFy[2*(ii-1)+4+2*(N+1)]
    for k=0:19
      BeamLine[k+1]=subs(TransL*psi1+TransR*psi3+RotL*psi2+RotR*psi4,s,k*l/20)
    end
    deltaN=l/20.0
    stations=collect(stL:deltaN:stR-deltaN)
   p=plot!(stations,ScaleFac*BeamLine,  linewidth = 1.75, linecolor = :indianred4, legend=:false)
   end 

   return p

 end    # Flywheel_gravity()