# ======================== Visualize vibration modes  ======================== #
function Flywheel_modes(A)
  t1=println("Showing vibration mode...")
  N=Int64(size(A)[1]/8-1)
  dDynMa=eigvals(A)
  vDynMa=eigvecs(A)

  d=sort(abs.(imag(dDynMa)))
  #for i=1:8*(N+1)
  # println(string("Eigenvalue ",i,", ",((d[i])*60/(2*pi)), "rev/min, in rad/s:"))
  #end
  dind=sortperm(abs.(imag(dDynMa))
  #for i=1:8*(N+1)
  #  println(string("Eigenvalue ",dind[i]))
  #end

#   ScaleFac=maximum(DiscRad)/maximum(abs.(gravFy[nodes_trY]))
   p=0
   #plot()
#   p=plot!([0.0; cumsum(len)], ScaleFac*gravFy[nodes_trY], label="Deformation due to gravity",  linewidth = 1.75, linecolor = :blue)
#   p=plot!([0.0; cumsum(len)], ScaleFac*gravFy[nodes_trY], marker = ([:circle :d], 4, 0.4, Plots.stroke(2, :gray)), legend=:false)
   return p

end    # Flywheel_modes()