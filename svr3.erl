-module(svr3).
-export([start/0, msg/2, multi/2]).

start() -> spawn(fun() -> loop(0) end).

loop(Count) ->
	receive
		{From, total} ->
			From ! {total, Count},
			loop(Count);
		{From, stop} ->
			From ! {final_total, Count};
		{From, Num} ->
			spawn(fun() -> From ! {Num, fac4:fac(Num)} end),
			loop(Count+1);
		_ ->
			loop(Count)
	end.

msg(To, Msg) ->
	To ! {self(), Msg},
	receive
		Reply -> Reply
	after
		60000 -> {error, timeout}
	end.

multi(_, 0) -> ok;
multi(To, N) ->
	spawn(fun() -> 
		{N, Reply} = msg(To, N),
		io:format("fac ~w: ~w~n", [N, Reply])
	end),
	multi(To, N-1).
