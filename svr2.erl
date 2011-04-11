-module(svr2).
-export([start/0, msg/2]).

% A more concurrent version of a loop server with a state.
% Calls to the server will now spawn independent reply processes,
% freeing up the server to deal with more responses.
% We can also get the total number of calls to the server
% by sending it the atom 'total'.
% Usage:
%   P = svr2:start().
%   svr2:msg(P, 100).
%   svr2:msg(P, total).

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
