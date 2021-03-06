include("multicaregiver.jl")
include("nashequilibrium.jl")
include("dynamicprogramming.jl")

baby=MultiCaregiverCryingBaby()
pomg=POMG(baby)

# NashEquilibrium
nash = POMGNashEquilibrium(rand(Float64, 3),2)
solve(nash,pomg)

# #dynamicprogramming
dyn = POMGDynamicProgramming(rand(Float64, 3),2)
solveDP(dyn,pomg)