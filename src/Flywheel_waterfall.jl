# ======================== Create Campbell diagram  ======================== #

function Flywheel_waterfall(M,G,D,K,OmStart,OmEnd)
  t1=println("Generating Campbell diagram...")
  N=Int64(size(M)[1]/4-1)

  p2=0
  plot()

  for Om=collect(OmStart:100:OmEnd)
    A,B=Flywheel_statespace(M,G,D,K,Om)
    v=sort(abs.(imag(eigvals(A)*60/2/pi)))
    for k=1:Int64(length(v))
      p2=plot!( Om, imag(v[k]), marker = ([:circle :d]), legend=:false)
    end
  end

  return p2

 end    # Flywheel_waterfall()