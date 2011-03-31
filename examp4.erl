-module(examp4).
-export([fac/1]).

fac(N) when is_integer(N), N > 0 ->
	fac(N, 1);
fac(_) ->
	{error, badarg}.

fac(0, Tot) -> Tot;
fac(N, Acc) ->
	fac(N-1, Acc*N).
