maior (x:[]) = x
maior (x:xs) = if x >= maior xs
	then x
	else maior xs
