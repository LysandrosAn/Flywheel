# ======================== Visualize vibration modes  ======================== #
function Flywheel_modes(RotorSpreadsheet,AA,modeno)
  t1=println("Showing vibration mode...")
  N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,adro,adri,adle,adrho,adma,adjp,adjt,DiscThick,DiscRad =Flywheel_load(RotorSpreadsheet)
  Flywheel_blueprint(RotorSpreadsheet)
  nodes_trX= zeros(Int64,N+1,1)
  nodes_trY= zeros(Int64,N+1,1)
  
  dDynMa=eigvals(AA)
  vDynMa=eigvecs(AA)

  d=(abs.(imag(dDynMa)))
  dind=sortperm(abs.(imag(dDynMa)))

  for ii=1:N+1
   nodes_trX[ii]=2*(ii-1)+1
   nodes_trY[ii]=2*(ii-1)+1+2*(N+1)
  end

  println(string("Eigenvalue No:",modeno,", at: ",round(d[dind[4]],digits=2),"rad/s"))
  mode_1=vDynMa[:,dind[modeno]]
  p=0
#  plot()
  ScaleFacRe=maximum(DiscRad)/maximum(abs.(real.(mode_1[nodes_trY])))
  ScaleFacIm=maximum(DiscRad)/maximum(abs.(imag.(mode_1[nodes_trY])))

  p=plot!([0.0; cumsum(len)], ScaleFacRe*real.(mode_1[nodes_trY]), label="Normal modal, real part",       linewidth = 1.75)
  p=plot!([0.0; cumsum(len)], ScaleFacRe*imag.(mode_1[nodes_trY]), label="Normal modal, imaginary part",       linewidth = 1.75)
   return p

end    # Flywheel_modes()