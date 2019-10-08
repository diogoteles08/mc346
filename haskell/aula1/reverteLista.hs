reverte (x:[]) = [x]
reverte (x:xs) = reverte xs ++ [x]

reverteA l = reverteA' l [] where
	reverteA' [] acc = acc
	reverteA' (x:xs) acc = reverteA' xs (x:acc)
