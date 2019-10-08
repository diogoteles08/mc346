tira1 _ [] = []
tira1 x (a:as) = if x == a
	then as
	else (a:tira1 x as)
