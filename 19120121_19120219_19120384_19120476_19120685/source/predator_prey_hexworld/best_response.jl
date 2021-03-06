include("./simplegame.jl")

function best_response(ð«::MG, Ï, i)
	ð®, ð, R, T, Î³ = ð«.ð®, ð«.ð, ð«.R, ð«.T, ð«.Î³
	Tâ²(s,ai,sâ²) = transition(ð«, s, joint(Ï, SimpleGamePolicy(ai), i), sâ²)
	Râ²(s,ai) = reward(ð«, s, joint(Ï, SimpleGamePolicy(ai), i), i)
	Ïi = solve(MDP(Î³, ð®, ð[i], Tâ², Râ²))
	return MGPolicy(s => SimpleGamePolicy(Ïi(s)) for s in ð®)
end