data Tree ch v = Vazia | No ch v (Tree ch v) (Tree ch v)

insereAbb :: (Ord ch) => ch -> v -> Tree ch v -> Tree ch v

insereAbb ch v Vazia = No ch v Vazia Vazia
insereAbb ch v (No ch1 v1 ae ad)  = if ch1 == ch
	then (No ch v ae ad)
	else if ch < ch1
		then if ae == Vazia
			then (No ch1 v1 (No ch v Vazia Vazia) ad))
			else (No ch1 v1 (insereAbb ch v ae) ad)
		else if ad == Vazia
			then (No ch1 v1 ae (No ch v Vazia Vazia))
			else (No ch1 v1 ae (insereAbb ch v ad))
