# ======================== Plot blueprint ======================== #
function Flywheel_blueprint(RotorSpreadsheet)
  t1=println("Generating blueprint of system...")
  N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,adro,adri,adle,adrho,adma,adjp,adjt,DiscThick,DiscRad =Flywheel_load(RotorSpreadsheet)
  SumL=sum(len);
  Pos=0.0
  p=0
  plot()
  for i=1:N
   p=plot!( [Pos, Pos], [-ro[i], +ro[i]],      linewidth= 2.0, color= :grey, label= false)
   p=plot!( [Pos, Pos+len[i]],+[ro[i], ro[i]], linewidth= 2.0, color= :grey, label= false)
   p=plot!( [Pos, Pos+len[i]],-[ro[i], ro[i]], linewidth= 2.0, color= :grey, label= false)
   Pos=len[i]+Pos;
  end

  p=plot!( [Pos, Pos], [-ro[N], +ro[N]], xlabel = "Axial dimension, m", ylabel = "Radial dimension, m", linewidth = 2.0, color = :grey,label=false, xlims = (-SumL*1/10, +SumL*11/10), ylims = (-6*SumL/10, +SumL*6/10))
  CumLen=cumsum(len)  
  for i=1:NN
   if PosNN[i]>N
    Pos=CumLen[Int64[N]]
   else
    Pos=CumLen[Int64(PosNN[i])]-len[1]
   end
   p=plot!( [Pos], [-ro[i]*4], markershape = :utriangle, markersize =14, markercolor = :black, label=false)
  end 

  for i=1:NNN
   if PosNNN[i]>N
    Pos=CumLen[N]
   else
    Pos=CumLen[(PosNNN[i]-1)]
   end
   p=plot!( [Pos-DiscThick[PosNNN[i]]/2, Pos-DiscThick[PosNNN[i]]/2], [-DiscRad[PosNNN[i]], +DiscRad[PosNNN[i]]],color = :black, label=false)
   p=plot!( [Pos+DiscThick[PosNNN[i]]/2, Pos+DiscThick[PosNNN[i]]/2], [-DiscRad[PosNNN[i]], +DiscRad[PosNNN[i]]],color = :black, label=false)
   p=plot!( [Pos-DiscThick[PosNNN[i]]/2, Pos+DiscThick[PosNNN[i]]/2], [-DiscRad[PosNNN[i]], -DiscRad[PosNNN[i]]],color = :black, label=false)
   p=plot!( [Pos-DiscThick[PosNNN[i]]/2, Pos+DiscThick[PosNNN[i]]/2], [+DiscRad[PosNNN[i]], +DiscRad[PosNNN[i]]],color = :black, label=false)
   p=plot!( [Pos-DiscThick[PosNNN[i]]/2, Pos+DiscThick[PosNNN[i]]/2], [+DiscRad[PosNNN[i]], +DiscRad[PosNNN[i]]], fillrange = [-DiscRad[PosNNN[i]] -DiscRad[PosNNN[i]]], colour=:grey, label=false)
  end
  
  annotate!(0.0, -maximum(adro)*1.0, text(string("Overall length: ", round(sum(len); digits=2), " m"), :black, :left, 10))
  annotate!(0.0, -maximum(adro)*1.5, text(string("Total system mass: ", round(sum(mu.*len)+sum(adma); digits=2), " kg"), :black, :left, 10))
  annotate!(0.0, -maximum(adro)*2.0, text(string("Total polal moment of inertia: ", round(sum(jp.*len)+sum(adjp); digits=2), " kg m^2"), :black, :left, 10))
  return p
end    # Flywheel_blueprint()