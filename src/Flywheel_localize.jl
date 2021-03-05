# ============= Generate localization matrix ============= #
function Flywheel_localize(k,n,r)
  Q= zeros(Int64,r,(n+1)*4)  
  for i=1:r
    Q[i,4*(k-1)+i]=1
  end
  # k: node position
  # n: overall amount of nodes
  # r: amount of displacements affected (8 for elements, 4 for translational bearings
 return Q
end    # Flywheel_localize(k,n,r)

