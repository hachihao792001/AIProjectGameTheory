include("./simplegame.jl")

function softmax_response(ð«::MG, Ï, i, Î»)
	ð®, ð, R, T, Î³ = ð«.ð®, ð«.ð, ð«.R, ð«.T, ð«.Î³
	Tâ²(s,ai,sâ²) = transition(ð«, s, joint(Ï, SimpleGamePolicy(ai), i), sâ²)
	Râ²(s,ai) = reward(ð«, s, joint(Ï, SimpleGamePolicy(ai), i), i)
	mdp = MDP(Î³, ð®, joint(ð), Tâ², Râ²)
	Ïi = solve(mdp)
	Q(s,a) = lookahead(mdp, Ïi.U, s, a)
	p(s) = SimpleGamePolicy(a => exp(Î»*Q(s,a)) for a in ð[i])
	return MGPolicy(s => p(s) for s in ð®)
end