troca i f n l = foldr (\x (li,nn) -> 
		if nn>0 && x==i then (f:li, nn-1) else (x:li, nn)
	) ([], n) l
