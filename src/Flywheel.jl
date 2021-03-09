# ======================== 1-D Finite Element Rotating Machinery Code ======================== #
module Flywheel
 export Flywheel_blueprint, Flywheel_fematrices, Flywheel_statespace, Flywheel_gravity, Flywheel_waterfall, Flywheel_modes
 using LinearAlgebra
 using Plots 
 using DelimitedFiles
 using SymPy
 include("Flywheel_load.jl")
 include("Flywheel_blueprint.jl")
 include("Flywheel_discrete.jl")
 include("Flywheel_localize.jl")
 include("Flywheel_statespace.jl")
 include("Flywheel_rearrange.jl")
 include("Flywheel_fematrices.jl")
 include("Flywheel_gravity.jl")
 include("Flywheel_waterfall.jl")
 include("Flywheel_modes.jl")
end # Module Flywheel