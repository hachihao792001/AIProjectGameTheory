include("./simplegame.jl")
include("./mg.jl")

struct MGPolicy
	p # dictionary mapping states to simple game policies
	MGPolicy(p::Base.Generator) = new(Dict(p))
end

(Ïi::MGPolicy)(s, ai) = Ïi.p[s](ai)
(Ïi::SimpleGamePolicy)(s, ai) = Ïi(ai)

probability(ð«::MG, s, Ï, a) = prod(Ïj(s, aj) for (Ïj, aj) in zip(Ï, a))
reward(ð«::MG, s, Ï, i) =
	sum(ð«.R(s,a)[i]*probability(ð«,s,Ï,a) for a in joint(ð«.ð))
transition(ð«::MG, s, Ï, sâ²) =
	sum(ð«.T(s,a,sâ²)*probability(ð«,s,Ï,a) for a in joint(ð«.ð))

function policy_evaluation(ð«::MG, Ï, i)
	ð®, ð, R, T, Î³ = ð«.ð®, ð«.ð, ð«.R, ð«.T, ð«.Î³
	p(s,a) = prod(Ïj(s, aj) for (Ïj, aj) in zip(Ï, a))
	Râ² = [sum(R(s,a)[i]*p(s,a) for a in joint(ð)) for s in ð®]
	Tâ² = [sum(T(s,a,sâ²)*p(s,a) for a in joint(ð)) for s in ð®, sâ² in ð®]
	return (I - Î³*Tâ²)\Râ²
end