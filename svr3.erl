-module(svr3).
-export([start/0, msg/2, multi/2]).

% A more robust factorial loop server and messager.
% Invalid arguments are ignored, the server may be remotely stopped
% and the messager will time-out after 60 seconds with no reply.
% A multi message function was added to simulate many concurrent calls.
% Usage:
%   P = svr3:start().
%   svr3:msg(P, 100).
%   svr3:multi(P, 1000).
%   Total = svr3:msg(P, stop).

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
