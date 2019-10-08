conta it l = conta' it l 0
	where
		conta' it [] acc = acc
		conta' it (x:xs) acc = if x == it
			then conta' it xs (acc+1)
			else conta' it xs acc
