-module(fac2).
-export([fac/1]).

% Slightly more secure version of the factorial function.
% A guard is used, allowing us to re-order the function clauses
% and prevent negative numbers and floats as arguments.

fac(N) when is_integer(N), N > 0 ->
    N * fac(N-1);
fac(0) -> 1.
