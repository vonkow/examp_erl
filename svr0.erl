-module(svr0).
-export([remote/0]).

remote() ->
	receive
		Msg ->
			io:format("Received: ~w~n", [Msg])
	end.
