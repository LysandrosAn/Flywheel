# ======================== Create Waterfall diagram  ======================== #
# Author: Lysandros Anastasopoulos
function Flywheel_waterfall(M,G,D,K,OmStart,OmEnd)
  t1=println("Generating Campbell diagram...")
  N=Int64(size(M)[1]/4-1)
  OmVec=  zeros(Float64,8*(N+1));

  p2=0
  plot()

  Omega= collect(OmStart:1000:OmEnd)
  for (Omindex, Omvalue) in enumerate(Omega)
     A,B=Flywheel_statespace(M,G,D,K,Omvalue)
     v=sort(abs.(imag(eigvals(A)*60/2/pi)))
    for k=1:8*(N+1)
      OmVec[k]=Omvalue
    end  
    p2=plot!(OmVec,v, marker = ([:circle],  2, 0.8),linealpha=0.0, legend=:false,xlims = (OmStart*0.75, OmEnd*1.25), yscale = :log, ylims = (1e2, +1e5), markercolor = :blue, xlabel= "Rotational speed, rev/min", ylabel = "Eigenfrequeny, rev/min")
  end
  return p2
end    # Flywheel_waterfall()