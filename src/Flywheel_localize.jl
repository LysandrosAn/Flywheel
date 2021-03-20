# ============= Generate localization matrix ============= #
# Author: Lysandros Anastasopoulos
function Flywheel_localize(k,n,r)
  Q= zeros(Int64,r,(n+1)*4)  
  for i=1:r
    Q[i,4*(k-1)+i]=1
  end
 return Q
end    # Flywheel_localize(k,n,r)