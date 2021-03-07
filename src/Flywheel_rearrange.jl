# ======================== Create matrices  ======================== #
function Flywheel_rearrange(M,G,D,K,N)
  t1=println("Rearranging elements...")

  M_xx=  zeros(Float64,2*(N+1),2*(N+1))
  M_yy=  zeros(Float64,2*(N+1),2*(N+1))
  M_xy=  zeros(Float64,2*(N+1),2*(N+1))
  M_yx=  zeros(Float64,2*(N+1),2*(N+1))
  G_xx=  zeros(Float64,2*(N+1),2*(N+1))
  G_yy=  zeros(Float64,2*(N+1),2*(N+1))
  G_xy=  zeros(Float64,2*(N+1),2*(N+1))
  G_yx=  zeros(Float64,2*(N+1),2*(N+1))
  D_xx=  zeros(Float64,2*(N+1),2*(N+1))
  D_yy=  zeros(Float64,2*(N+1),2*(N+1))
  D_xy=  zeros(Float64,2*(N+1),2*(N+1))
  D_yx=  zeros(Float64,2*(N+1),2*(N+1))
  K_xx=  zeros(Float64,2*(N+1),2*(N+1))
  K_yy=  zeros(Float64,2*(N+1),2*(N+1))
  K_xy=  zeros(Float64,2*(N+1),2*(N+1))
  K_yx=  zeros(Float64,2*(N+1),2*(N+1))
  Ms=  zeros(Float64,4*(N+1),4*(N+1))
  Gs=  zeros(Float64,4*(N+1),4*(N+1))
  Ds=  zeros(Float64,4*(N+1),4*(N+1))
  Ks=  zeros(Float64,4*(N+1),4*(N+1))
  for ii=1:N+1 # Reorder rows and columns
    for jj=1:N+1
      M_xx[2*(ii-1)+1,2*(jj-1)+1]=  M[4*(ii-1)+1,4*(jj-1)+1]   # odd rows get x translations, odd columns get m
      M_xx[2*(ii-1)+1,2*(jj-1)+2]=  M[4*(ii-1)+1,4*(jj-1)+4]   # odd rows get x translations, even columns get rad
      M_xx[2*(ii-1)+2,2*(jj-1)+1]=  M[4*(ii-1)+4,4*(jj-1)+1]   # even rows get x rotations, odd columns get m
      M_xx[2*(ii-1)+2,2*(jj-1)+2]=  M[4*(ii-1)+4,4*(jj-1)+4]   # even rows get x rotations, even columns get rad
      M_yy[2*(ii-1)+1,2*(jj-1)+1]=  M[4*(ii-1)+2,4*(jj-1)+2]   # odd rows get y translations, odd columns get m
      M_yy[2*(ii-1)+1,2*(jj-1)+2]= -M[4*(ii-1)+2,4*(jj-1)+3]  # odd rows get y translations, even columns get rad
      M_yy[2*(ii-1)+2,2*(jj-1)+1]= -M[4*(ii-1)+3,4*(jj-1)+2]  # even rows get y rotations, odd columns get m
      M_yy[2*(ii-1)+2,2*(jj-1)+2]=  M[4*(ii-1)+3,4*(jj-1)+3]   # even rows get y rotations, even columns get rad
      G_xy[2*(ii-1)+1,2*(jj-1)+1]=  G[4*(ii-1)+1,4*(jj-1)+2]   # odd rows get x translations, odd columns get m
      G_xy[2*(ii-1)+1,2*(jj-1)+2]=  G[4*(ii-1)+1,4*(jj-1)+3]   # odd rows get x translations, odd columns get rad
      G_xy[2*(ii-1)+2,2*(jj-1)+1]=  G[4*(ii-1)+4,4*(jj-1)+2]   # even rows get x rotations, odd columns get m
      G_xy[2*(ii-1)+2,2*(jj-1)+2]=  G[4*(ii-1)+4,4*(jj-1)+3]   # even rows get x rotations, odd columns get rad
      G_yx[2*(ii-1)+1,2*(jj-1)+1]=  G[4*(ii-1)+2,4*(jj-1)+1]   # odd rows get y translations, odd columns get m
      G_yx[2*(ii-1)+1,2*(jj-1)+2]= -G[4*(ii-1)+2,4*(jj-1)+4]  # odd rows get y translations, odd columns get rad
      G_yx[2*(ii-1)+2,2*(jj-1)+1]= -G[4*(ii-1)+3,4*(jj-1)+1]  # even rows get y rotations, odd columns get m
      G_yx[2*(ii-1)+2,2*(jj-1)+2]=  G[4*(ii-1)+3,4*(jj-1)+4]   # even rows get y rotations, odd columns get rad
      D_xx[2*(ii-1)+1,2*(jj-1)+1]=  D[4*(ii-1)+1,4*(jj-1)+1]   # odd rows get x translations, odd columns get m
      D_xx[2*(ii-1)+1,2*(jj-1)+2]=  D[4*(ii-1)+1,4*(jj-1)+4]   # odd rows get x translations, even columns get rad
      D_xx[2*(ii-1)+2,2*(jj-1)+1]=  D[4*(ii-1)+4,4*(jj-1)+1]   # even rows get x rotations, odd columns get m
      D_xx[2*(ii-1)+2,2*(jj-1)+2]=  D[4*(ii-1)+4,4*(jj-1)+4]   # even rows get x rotations, even columns get rad
      D_yy[2*(ii-1)+1,2*(jj-1)+1]=  D[4*(ii-1)+2,4*(jj-1)+2]   # odd rows get y translations, odd columns get m
      D_yy[2*(ii-1)+1,2*(jj-1)+2]= -D[4*(ii-1)+2,4*(jj-1)+3]  # odd rows get y translations, even columns get rad
      D_yy[2*(ii-1)+2,2*(jj-1)+1]= -D[4*(ii-1)+3,4*(jj-1)+2]  # even rows get y rotations, odd columns get m
      D_yy[2*(ii-1)+2,2*(jj-1)+2]=  D[4*(ii-1)+3,4*(jj-1)+3]   # even rows get y rotations, even columns get rad
      K_xx[2*(ii-1)+1,2*(jj-1)+1]=  K[4*(ii-1)+1,4*(jj-1)+1]   # odd rows get x translations, odd columns get m
      K_xx[2*(ii-1)+1,2*(jj-1)+2]=  K[4*(ii-1)+1,4*(jj-1)+4]   # odd rows get x translations, even columns get rad
      K_xx[2*(ii-1)+2,2*(jj-1)+1]=  K[4*(ii-1)+4,4*(jj-1)+1]   # even rows get x rotations, odd columns get m
      K_xx[2*(ii-1)+2,2*(jj-1)+2]=  K[4*(ii-1)+4,4*(jj-1)+4]   # even rows get x rotations, even columns get rad
      K_yy[2*(ii-1)+1,2*(jj-1)+1]=  K[4*(ii-1)+2,4*(jj-1)+2]   # odd rows get y translations, odd columns get m
      K_yy[2*(ii-1)+1,2*(jj-1)+2]= -K[4*(ii-1)+2,4*(jj-1)+3]  # odd rows get y translations, even columns get rad
      K_yy[2*(ii-1)+2,2*(jj-1)+1]= -K[4*(ii-1)+3,4*(jj-1)+2]  # even rows get y rotations, odd columns get m
      K_yy[2*(ii-1)+2,2*(jj-1)+2]=  K[4*(ii-1)+3,4*(jj-1)+3]   # even rows get y rotations, even columns get rad
    end
   end

   Ms[1:2*(N+1),1:2*(N+1)]=M_xx
   Ms[2*(N+1)+1:4*(N+1),2*(N+1)+1:4*(N+1)]=M_yy
   Gs[1:2*(N+1),2*(N+1)+1:4*(N+1)]=G_xy
   Gs[2*(N+1)+1:4*(N+1),1:2*(N+1)]=-G_xy
   Ds[1:2*(N+1),1:2*(N+1)]=D_xx
   Ds[2*(N+1)+1:4*(N+1),2*(N+1)+1:4*(N+1)]=D_yy
   Ks[1:2*(N+1),1:2*(N+1)]=K_xx
   Ks[2*(N+1)+1:4*(N+1),2*(N+1)+1:4*(N+1)]=K_yy

  
 return Ms,Gs,Ds,Ks
end    # Flywheel_rearrange()