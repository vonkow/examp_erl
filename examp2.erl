-module(examp2).
-export([fac/1]).

fac(N) when is_integer(N), N > 0 ->
	N * fac(N-1);
fac(0) -> 1.