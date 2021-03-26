[# ======================== Visualize vibration modes  ======================== #
# Author: Lysandros Anastasopoulos
function Flywheel_modes(RotorSpreadsheet,AA,modeno)
  t1=println("Showing vibration mode...")
  N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,adro,adri,adle,adrho,adma,adjp,adjt,DiscThick,DiscRad =Flywheel_load(RotorSpreadsheet)
  Flywheel_blueprint(RotorSpreadsheet)
  nodes_trX= zeros(Int64,N+1,1)
  nodes_trY= zeros(Int64,N+1,1)
  BeamLine= zeros(Float64,20)

  dDynMa=eigvals(AA)
  vDynMa=eigvecs(AA)

  d=(abs.(imag(dDynMa)))
  dind=sortperm(abs.(imag(dDynMa)))
  for ii=1:N+1
   nodes_trX[ii]=2*(ii-1)+1
   nodes_trY[ii]=2*(ii-1)+1+2*(N+1)
  end
 
  println(string("Eigenvalue No:",modeno,", at:",round(d[dind[modeno]],digits=2),"rad/s"))
  annotate!(0.15, 0.3, text(string("Normal mode #",modeno,", at: ",round(d[dind[modeno]],digits=2),"rad/s"), :black, :left, 10))
  mode_sel=vDynMa[:,dind[modeno]]

  p=0
  #plot()
  ScaleFacRe=maximum(DiscRad)/maximum(abs.(real.(mode_sel[nodes_trY])))
  ScaleFacIm=maximum(DiscRad)/maximum(abs.(imag.(mode_sel[nodes_trY])))
  
  s = Sym("s")  
  for ii=1:N
   l=len[ii]
   stR=sum(len[1:ii])
   stL=sum(len[1:ii])-l
   psi1= 1-3*(s/l)^2+2*(s/l)^3
   psi2= s*(1-2*(s/l)+(s/l)^2)
   psi3= 3*(s/l)^2-2*(s/l)^3
   psi4= l*(-(s/l)^2+(s/l)^3)

   TransL= real(mode_sel[2*(ii-1)+1+2*(N+1)])
   RotL=   real(mode_sel[2*(ii-1)+2+2*(N+1)])
   TransR= real(mode_sel[2*(ii-1)+3+2*(N+1)])
   RotR=   real(mode_sel[2*(ii-1)+4+2*(N+1)])
   for k=0:19
      BeamLine[k+1]=subs(TransL*psi1+TransR*psi3+RotL*psi2+RotR*psi4,s,k*l/20)
   end
   deltaN=l/20.0
   stations=collect(stL:deltaN:stR-deltaN)
   p=plot!(stations,ScaleFacRe*BeamLine,  linewidth = 1.75, linecolor = :indianred2, legend=:false)
  end 
  
  return p

end    # Flywheel_modes()