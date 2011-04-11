-module(fac1).
-export([fac/1]).

% Very simple factorial example
% Called using fac1:fac(integer).
% Note how closely it resembles the mathematical definition.

fac(0) -> 1;
fac(N) -> N * fac(N-1).
