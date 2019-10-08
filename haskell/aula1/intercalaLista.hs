intercala1 [] _ = []
intercala1 (x:xs) l2 = (x:intercala1 l2 xs)

intercala2 [] l2 = l2
intercala2 (x:xs) l2 = (x:intercala2 l2 xs)
