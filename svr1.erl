-module(svr1).
-export([ping1/0, ping2/0, pong2/1]).

ping1() ->
    spawn(fun() -> pong1() end),
    io:format("~w~n",[ping]).

pong1() ->
    io:format("~w~n",[pinged]).

ping2() ->
    spawn(?MODULE, pong2, [self()]),
    io:format("~w~n",[ping]),
    receive
        Pong -> io:format("~w~n",[Pong])
    end.

pong2(From) ->
    io:format("~w~n",[pinged]),
    From ! ponged.
