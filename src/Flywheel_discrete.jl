# ======================== Create matrices  ======================== #
function Flywheel_discrete(RotorSpreadsheet)
  t1=println("Creating finite elment method matrices")

 N,NN,NNN,len,ro,ri,rho,E,nu,It,A,mu,jp,jt,PosNN,BearX,BearY,PosNNN,DiscThick,DiscRad =Flywheel_load(RotorSpreadsheet)
 
 # Allocate arrays
 K_b=  zeros(Float64,4,4,NN);
 C_b=  zeros(Float64,4,4,NN);

 for ii=1:NN
  if PosNN[ii]>N
    K_b[:,:,ii]= [ BearX[N] 0 0 0;  0 BearY[N] 0 0;  0 0 0 0;  0 0 0 0]
    C_b[:,:,ii]= [ 0        0 0 0;  0        0 0 0;  0 0 0 0;  0 0 0 0]  
  else
    K_b[:,:,ii]= [ BearX[PosNN[ii]] 0 0 0;  0 BearY[PosNN[ii]] 0 0;  0 0 0 0;  0 0 0 0]
    C_b[:,:,ii]= [ 0                0 0 0;  0                0 0 0;  0 0 0 0;  0 0 0 0]  
  end
 end

 # Allocate arrays
 adro=  zeros(Float64,NNN);adri=  zeros(Float64,NNN);
 adle=  zeros(Float64,NNN);adrho= zeros(Float64,NNN);
 adma=  zeros(Float64,NNN);adjp=  zeros(Float64,NNN);  adjt=  zeros(Float64,NNN);
 M_d=  zeros(Float64,4,4,NNN); G_d=  zeros(Float64,4,4,NNN);

 for iii=1:NNN
  adro[iii]=DiscRad[PosNNN[iii]];   # Disc outer radius
  adri[iii]=0.0;                    # Disc inner radius
  adle[iii]=DiscThick[PosNNN[iii]]; # Disc axial length
  adrho[iii]=7840.0;                # Disc material density
  adma[iii]=pi * (adro[iii]^2-adri[iii]^2)  * adle[iii]*adrho[iii]; # Disc mass
  adjp[iii]=adma[iii]*(adro[iii]^2+adri[iii]^2)/2;                  # Disc polar moment of inertia
  adjt[iii]=adjp[iii]/2+adma[iii]*adle[iii]^2/12;                   # Disc transversal moment of inertia
 end

 for iii=1:NNN
  M_d[:,:,iii]=  [ adma[iii] 0 0 0;  0 adma[iii] 0 0;  0 0 adjt[iii] 0;  0 0 0 adjt[iii]  ];
  G_d[:,:,iii]=  [ 0         0 0 0;  0 0         0 0;  0 0 0 adjp[iii];  0 0 -adjp[iii] 0 ];
 end

 return K_b, C_b, M_d, G_d
end    # Flywheel_discrete()
