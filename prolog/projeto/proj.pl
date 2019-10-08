:- dynamic circ/4.
:- dynamic quad/4.

topo() :- read(Entrada), processInput(Entrada), 
		findall([N1, M1], intersec(quad(N1,_,_,_), quad(M1,_,_,_)), L1),
		findall([N2, M2], intersec(circ(N2,_,_,_), circ(M2,_,_,_)), L2),
		append([L1,L2], L),
		listSize(L, Size), 
		prettyPrint([Size|L]).

processInput([X|R]) :- assertz(X), !, processInput(R).

intersec(quad(N, X1, Y1, L1), quad(M, X2, Y2, L2)) :- N@<M, %% Comparison used to set that one pair of squares will be considered only once. Avoids the case of getting both (A,B) and (B,A)
		(X2 > X1 -> X2-X1 < (L2/2)+(L1/2); X1-X2 < (L1/2)+(L2/2)), (Y2 > Y1 -> Y2-Y1 < (L2/2)+(L1/2); Y1-Y2 < (L1/2)+(L2/2)).

intersec(circ(N, X1, Y1, R1), circ(M, X2, Y2, R2)) :- N@<M, Dist = ((X2-X1)**2 + (Y2-Y1)**2)**0.5, Dist < R1+R2.

%% TODO
%% intersec(quad(N, X1, Y1, L), circ(M, X2, Y2, R))

listSize([], 0).
listSize([_|R], S) :- listSize(R, SS), S = SS+1.

prettyPrint([X|R]) :- print(X), !, prettyPrint(R).
