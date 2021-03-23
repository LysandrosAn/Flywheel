# ======================== Create Waterfall diagram  ======================== #
# Author: Lysandros Anastasopoulos
function Flywheel_waterfall(M,G,D,K,OmStart,steps,OmEnd)
  t1=println("Generating Campbell diagram...")
  N=Int64(size(M)[1]/4-1)
  OmVec=  zeros(Float64,8*(N+1));

  p2=0
  plot()

  Omega= collect(OmStart:steps:OmEnd)
  for (Omindex, Omvalue) in enumerate(Omega)
     A,B=Flywheel_statespace(M,G,D,K,Omvalue)
     v=sort(abs.(imag(eigvals(A))))
    for k=1:8*(N+1)
      OmVec[k]=Omvalue
    end  
    p2=plot!(OmVec,v, marker = ([:circle],  2, 0.2),linealpha=0.0, legend=:false, xlims = (OmStart*0.75, OmEnd*1.25), yscale = :log, markercolor = :blue, xlabel= "Rotational speed, rev/min", ylabel = "Eigenvalue (imag. part), rad/s", label=:false)
  end
  p2=plot!([OmStart OmEnd]',[OmStart OmEnd]'/60*2*pi, linecolor = :indianred4, legend=:true, label="1x Omega")

  return p2
end    # Flywheel_waterfall()