# ======================== Calculate gravity force  ======================== #

function Flywheel_gravity(RotorSpreadsheet, gi,K)
  t1=println("Calculating gravity force vector...")

  N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,adro,adri,adle,adrho,adma,adjp,adjt,DiscThick,DiscRad =Flywheel_load(RotorSpreadsheet)
  
  GravForce= zeros(Float64,4*(N+1),1)
  
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
  
   ScaleFac=maximum(DiscRad)/maximum(abs.(gravFy[nodes_trY]))
   p=0
   #plot()
   p=plot!([0.0; cumsum(len)], ScaleFac*gravFy[nodes_trY], label="Deformation due to gravity",  linewidth = 1.75, linecolor = :blue)
   p=plot!([0.0; cumsum(len)], ScaleFac*gravFy[nodes_trY], marker = ([:circle :d], 4, 0.4, Plots.stroke(2, :gray)), legend=:false)
   return p

 end    # Flywheel_gravity()