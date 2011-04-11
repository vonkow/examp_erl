-module(fac3).
-export([fac/1]).

% Slight improvement over fac2,
% Bad arguments will now return a custom error.
% Note the use of the _ wildcard, or "don't care" symbol
% Errors in erlang are generally structured as {error, Reason}.

fac(N) when is_integer(N), N > 0 ->
    N * fac(N-1);
fac(0) -> 1;
fac(_) -> {error, badarg}.
