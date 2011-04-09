-module(svr2).
-export([start/0, msg/2]).

start() -> spawn(fun() -> loop(0) end).

loop(Count) ->
    receive
        {From, total} ->
            From ! {total, Count},
            loop(Count);
        {From, Num} ->
            spawn(fun() -> From ! {Num, fac4:fac(Num)} end),
            loop(Count+1)
    end.

msg(To, Msg) ->
    To ! {self(), Msg},
    receive
        Reply -> Reply
    end.
