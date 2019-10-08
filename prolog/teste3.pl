soma1(vazio, Chave, arv(Chave, 1, vazio, vazio)).
soma1(arv(Chave, Valor, AE, AD), Chave, arv(Chave, NovoValor, AE, AD)) :- NovoValor is Valor+1.
soma1(arv(Chave, Valor, AE, AD), ChaveBuscada, NovoDic) :- ChaveBuscada > Chave
														-> (NovoDic is arv(Chave, Valor, AE, NewAD), 
															soma1(AD, ChaveBuscada, NewAD))
														; (NovoDic is arv(Chave, Valor, NewAE, AD),
															soma1(AE, ChaveBuscada, NewAE)).
