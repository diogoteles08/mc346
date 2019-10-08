-- É basicamente o codigo que a gente precisa pra calcular a distancia entre todos os pontos, mas ao inves de concatenar as listas vc vai usar sua funcao dist
-- Codigo:
func tupla1 tupla2  = ((snd tupla1) ++ (snd tupla2), (fst tupla1,fst tupla2))

-- Ai rodei isso aqui no ghci: 
func <$> [("p1",[1,2]),("p2",[4,2])] <*> [("p3",[4,1]),("p4",[42,4])]

-- resultado
[([1,2,4,1],("p1","p3")),([1,2,42,4],("p1","p4")),([4,2,4,1],("p2","p3")),([4,2,42,4],("p2","p4"))]
