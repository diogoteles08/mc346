data Tree a = Vazia | No a (Tree a) (Tree a)

isAbb :: (Ord a) => Tree a -> Bool
isAbb Vazia = True
isAbb (No _ Vazia Vazia) = True
isAbb (No root Vazia tr) = isAbb tr && root < (menor tr)
isAbb (No root tl Vazia) = isAbb tl && root > (maior tl)
isAbb (No root tl tr) = isAbb tl && isAbb tr
	&& root > (maior tl) && root < (menor tr)


maior :: Tree a -> a
maior (No root _ Vazia) = root
maior (No _ _ t) = maior t

menor :: Tree a -> a
menor (No root Vazia _) = root
menor (No _ t _) = menor t
