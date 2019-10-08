contal x l = foldl (\ac y -> if x == y then ac+1 else ac) 0 l
contar x l = foldr (\y res -> if x == y then res+1 else res) 0 l
