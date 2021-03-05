# ======================== Plot blueprint ======================== #
function Flywheel_blueprint(RotorSpreadsheet)
  t1=println("Generating blueprint of system")
  N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,DiscThick,DiscRad =Flywheel_load(RotorSpreadsheet)
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
    p=plot!( [Pos], [-ro[i]], markershape = :utriangle, markersize =17, markercolor = :black, label=false)
  end
 
  for i=1:NNN
    if PosNNN[i]>N
     Pos=CumLen[N]
    else
     Pos=CumLen[(PosNNN[i]-1)]
    end
    p=plot!( [Pos-DiscThick[PosNNN[i]]/2, Pos-DiscThick[PosNNN[i]]/2], [-DiscRad[PosNNN[i]]/2, +DiscRad[PosNNN[i]]/2],color = :black, label=false)
    p=plot!( [Pos+DiscThick[PosNNN[i]]/2, Pos+DiscThick[PosNNN[i]]/2], [-DiscRad[PosNNN[i]]/2, +DiscRad[PosNNN[i]]/2],color = :black, label=false)
    p=plot!( [Pos-DiscThick[PosNNN[i]]/2, Pos+DiscThick[PosNNN[i]]/2], [-DiscRad[PosNNN[i]]/2, -DiscRad[PosNNN[i]]/2],color = :black, label=false)
    p=plot!( [Pos-DiscThick[PosNNN[i]]/2, Pos+DiscThick[PosNNN[i]]/2], [+DiscRad[PosNNN[i]]/2, +DiscRad[PosNNN[i]]/2],color = :black, label=false)
    p=plot!( [Pos-DiscThick[PosNNN[i]]/2, Pos+DiscThick[PosNNN[i]]/2], [+DiscRad[PosNNN[i]]/2, +DiscRad[PosNNN[i]]/2], fillrange = [-DiscRad[PosNNN[i]]/2 -DiscRad[PosNNN[i]]/2], colour=:grey, label=false)
  end
 
  return p
 end    # Flywheel_blueprint()
 