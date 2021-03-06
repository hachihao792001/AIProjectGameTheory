using JuMP, Ipopt

struct NashEquilibrium end
function tensorform(ð«::SimpleGame)
    â, ð, R = ð«.â, ð«.ð, ð«.R
    ââ² = eachindex(â)
    ðâ² = [eachindex(ð[i]) for i in â]
    Râ² = [R(a) for a in joint(ð)]
    return ââ², ðâ², Râ²
end
function solve(M::NashEquilibrium, ð«::SimpleGame)
    â, ð, R = tensorform(ð«)
    model = Model(Ipopt.Optimizer)
    @variable(model, U[â])
    @variable(model, Ï[i=â, ð[i]] â¥ 0)
    @NLobjective(model, Min,
        sum(U[i] - sum(prod(Ï[j,a[j]] for j in â) * R[y][i]
        for (y,a) in enumerate(joint(ð))) for i in â))
    @NLconstraint(model, [i=â, ai=ð[i]],
        U[i] â¥ sum(
        prod(j==i ? (a[j]==ai ? 1.0 : 0.0) : Ï[j,a[j]] for j in â)
        * R[y][i] for (y,a) in enumerate(joint(ð))))
    @constraint(model, [i=â], sum(Ï[i,ai] for ai in ð[i]) == 1)
    optimize!(model)
    Ïiâ²(i) = SimpleGamePolicy(ð«.ð[i][ai] => value(Ï[i,ai]) for ai in ð[i])
    for i in â
        print("Agent $i: ")
        println(Ïiâ²(i))
    end
    return [Ïiâ²(i) for i in â]
end