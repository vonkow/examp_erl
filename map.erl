-module(map).
-export([map/2]).

% A simple example of how to write a map function
% Don't use this in the real world, the internal
% lists:map() function is highly optimized.

map(F, [H|T]) -> [F(H)|map(F, T)];
map(_, []) -> [].
