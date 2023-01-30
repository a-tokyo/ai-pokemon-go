at(0,0,0,T,s0):-
T =<0.
%at(_,_,0,0,s0):-
%write(so).
height(2). 
width(2). 
%query(1,0,2,1,P).
hasPokemon(0,0,0,T,s0):-
	T =<0.
hasPokemon(1,1,0,T,s0):-
	T =<0.
cellOpen(0,0,right). 
cellOpen(0,1,left). 
cellOpen(1,0,right). 
cellOpen(1,1,left).
cellOpen(0,1,back). 
cellOpen(1,1,forward).
cellOpen(0,0,back). 
cellOpen(1,0,forward).
cellOpen(1,1,left). 

hasPokemon(X,Y,P,T,result(A,S)):-
	A=f,
	hasPokemon(X,Y,P,T,S),
	X2 is X+1,
	\+ at(X2,Y,P,T,S);
	
	A=b,
	hasPokemon(X,Y,P,T,S),
	X2 is X-1,
	\+ at(X2,Y,P,T,S);
	
	A=r,
	hasPokemon(X,Y,P,T,S),
	Y2 is Y+1,
	\+ at(X,Y2,P,T,S);
	
	A=l,
	hasPokemon(X,Y,P,T,S),
	Y2 is Y-1,
	\+ at(X,Y2,P,T,S).
	
	

	

at(X,Y,Pokemons,T,result(f,S)):-%here i shoud have 8 cases
	%has a pokemon
	 X<2,X2 is X+1,
	cellOpen(X,Y,back),
	Pokemons2 is Pokemons -1,
	T2 is T-1,
	hasPokemon(X,Y,Pokemons,T,S),
	at(X2,Y,Pokemons2,T2,S).

at(X,Y,Pokemons,T,result(f,S)):-	%no pokemon
	T2 is T-1,
	X<2,X2 is X+1,
	cellOpen(X,Y,back),
	\+ hasPokemon(X,Y,Pokemons,T,S),
	at(X2,Y,Pokemons,T2,S)	
   .

at(X,Y,Pokemons,T,result(b,S)):-	
	%has a pokemon
	X>0,
	X2 is X-1,
	cellOpen(X,Y,forward),
	Pokemons2 is Pokemons -1,
	T2 is T-1,
	hasPokemon(X,Y,Pokemons,T,S),
	at(X2,Y,Pokemons2,T2,S)
	
	.

at(X,Y,Pokemons,T,result(b,S)):-
	%no pokemon
	cellOpen(X,Y,forward),
	T2 is T-1,
	\+ hasPokemon(X,Y,Pokemons,T,S),
	X>0,
	X2 is X-1,
	at(X2,Y,Pokemons,T2,S).



at(X,Y,Pokemons,T,result(r,S)):-	
	%has pokemons
	cellOpen(X,Y,left),
	Pokemons2 is Pokemons -1,
	T2 is T-1,
	hasPokemon(X,Y,Pokemons,T,S),
	Y>0 ,Y2 is Y-1,
	at(X,Y2,Pokemons2,T2,S).
	
	

at(X,Y,Pokemons,T,result(r,S)):-
	%no pokemons
	cellOpen(X,Y,left),
	T2 is T-1,
	\+ hasPokemon(X,Y,Pokemons,T,S),
	Y>0 ,Y2 is Y-1,
	at(X,Y2,Pokemons,T2,S).

at(X,Y,Pokemons,T,result(l,S)):-	
	%has pokemons
	cellOpen(X,Y,right),
	Pokemons2 is Pokemons -1,
	T2 is T-1,
	hasPokemon(X,Y,Pokemons,T,S),
	Y <2 ,Y2 is Y+1,
	at(X,Y2,Pokemons2,T2,S).
	
at(X,Y,Pokemons,T,result(l,S)):-	
	%no pokemons
	Y <2 ,Y2 is Y+1,
	T2 is T-1,
	cellOpen(X,Y,right),
	\+ hasPokemon(X,Y,Pokemons,T,S),
	at(X,Y2,Pokemons,T2,S).




%failing
at(X,Y,Pokemons,T,result(A,S)):-%sell not open 4 cases
	
	A = f,
	\+ cellOpen(X,Y,forward),
	at(X,Y,Pokemons,T,result(A,S))
	.

at(X,Y,Pokemons,T,result(A,S)):-
	A= b,
	\+ cellOpen(X,Y,back),
	at(X,Y,Pokemons,T,result(A,S))
	.


at(X,Y,Pokemons,T,result(A,S)):-	
	A=r,
	\+ cellOpen(X,Y,right),
	at(X,Y,Pokemons,T,result(A,S)).

at(X,Y,Pokemons,T,result(A,S)):-	
	A=l,
	\+ cellOpen(X,Y,left),
	at(X,Y,Pokemons,T,result(A,S))
	.

%loop for ever handling
query(X,Y,Pokemons,TimeHatch,P):-
	query1(X,Y,Pokemons,TimeHatch,P,17).

query1(X,Y,Pokemons,TimeHatch,P,C):-
findSolution(X,Y,Pokemons,TimeHatch,P,C,R),
\+ R = depth_limit_exceeded.
query1(X,Y,Pokemons,TimeHatch,P,C):-
	findSolution(X,Y,Pokemons,TimeHatch,P,C,R),
	R = depth_limit_exceeded,
	C2 is C+1,
	query1(X,Y,Pokemons,TimeHatch,P,C2).
	


findSolution(X,Y,Pokemons,TimeHatch,P,Limit,Result):-
	call_with_depth_limit(at(X,Y,Pokemons,TimeHatch,P), Limit, Result).
