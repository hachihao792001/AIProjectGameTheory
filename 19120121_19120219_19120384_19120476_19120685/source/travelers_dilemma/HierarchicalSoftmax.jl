# ----------------------------- HierarchicalSoftmax --------------------------------
function softmax_response(饾挮::SimpleGame, 蟺, i, 位)
      饾挏i = 饾挮.饾挏[i]
      U(ai) = utility(饾挮, joint(蟺, SimpleGamePolicy(ai), i), i)
      return SimpleGamePolicy(ai => exp(位 * U(ai)) for ai in 饾挏i)
end

struct HierarchicalSoftmax
      位 # precision parameter
      k # level
      蟺 # initial policy
end
function HierarchicalSoftmax(饾挮::SimpleGame, 位, k)
      # 蟺 m峄檛 danh s谩ch c谩c danh s谩ch SimpleGamePolicy c峄 m峄梚 joint action trong joint action space c峄 饾挮
      蟺 = [SimpleGamePolicy(ai => 1.0 for ai in 饾挏i) for 饾挏i in 饾挮.饾挏]
      return HierarchicalSoftmax(位, k, 蟺)
end
function solve(M::HierarchicalSoftmax, 饾挮)
      蟺 = M.蟺
      for k in 1:M.k
            蟺 = [softmax_response(饾挮, 蟺, i, M.位) for i in 饾挮.鈩怾
      end
      return 蟺
end