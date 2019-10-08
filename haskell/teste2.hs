posicoes:: (Eq a, Num b) => a -> [a] -> [b]
posicoes x l = pos x l 0 []
	where
		pos _ [] _ acc = acc
		pos x (y:ys) i acc = if x == y
			then pos x ys (i+1) (acc ++ [i])
			else pos x ys (i+1) acc
