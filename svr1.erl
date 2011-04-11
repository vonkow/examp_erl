-module(svr1).
-export([start/0, msg/2]).

% A very simple loop server for calculating factorials
% Usage: 
%   P = svr1:start().
%   svr1:msg(P, 100).

start() -> spawn(fun() -> loop() end).

loop() ->
    receive
        {From, Num} ->
            From ! {Num, fac4:fac(Num)},
            loop()
    end.

msg(To, Msg) ->
    To ! {self(), Msg},
    receive
        Reply -> Reply
    end.
