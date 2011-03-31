-module(examp5).
-export([map/2]).

map(F, L) -> map(F, L, []).

map(_, [], Acc) ->
	lists:reverse(Acc);
map(F, [H|T], Acc) ->
	map(F, T, [F(H) | Acc]).
