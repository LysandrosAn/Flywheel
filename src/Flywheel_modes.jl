# ======================== Visualize vibration modes  ======================== #
function Flywheel_modes(RotorSpreadsheet,AA)
  t1=println("Showing vibration mode...")
  N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,adro,adri,adle,adrho,adma,adjp,adjt,DiscThick,DiscRad =Flywheel_load(RotorSpreadsheet)
  nodes_trX= zeros(Int64,N+1,1)
  nodes_trY= zeros(Int64,N+1,1)
  
  dDynMa=eigvals(AA)
  vDynMa=eigvecs(AA)

  d=(abs.(imag(dDynMa)))
  dind=sortperm(abs.(imag(dDynMa)))

  println(string("1st Eigenvalue:",d[dind[1]]))
  println(string("2nd Eigenvalue:",d[dind[2]]))
  println(string("3rd Eigenvalue:",d[dind[3]]))
  println(string("4th Eigenvalue:",d[dind[4]]))

  for ii=1:N+1
   nodes_trX[ii]=2*(ii-1)+1
   nodes_trY[ii]=2*(ii-1)+1+2*(N+1)
  end

  mode_1=vDynMa[:,dind[1]]
  println(imag.(mode_1))
  p=0
#  plot()
  p=plot!([0.0; cumsum(len)], 1e4*real.(mode_1[nodes_trY]), label="Modal shape, real",       linewidth = 1.75)
  p=plot!([0.0; cumsum(len)], 1e4*imag.(mode_1[nodes_trY]), label="Modal shape, imaginary",  linewidth = 1.75)
   return p

end    # Flywheel_modes()