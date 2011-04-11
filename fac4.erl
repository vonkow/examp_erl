-module(fac4).
-export([fac/1]).

% Final factorial example, using tail-call recursion.
% We still only export the single argument factorial,
% but it calls the internal 2 argument function.
% By accumulating the result in an accumulator var,
% we can tail-call recurse and not grow the call stack.
% If you're feeling lucky, try calculating the factorial of 100000 :)

fac(N) when is_integer(N), N >= 0 -> fac(N, 1);
fac(_) -> {error, badarg}.

fac(0, Tot) -> Tot;
fac(N, Acc) -> fac(N-1, Acc*N).
