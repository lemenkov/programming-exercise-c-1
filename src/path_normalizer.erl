-module(path_normalizer).

%% path_normalizer: path_normalizer library's entry point.

-export([normalize/1]).

%% API

normalize(Path) ->
    walk(path_split(Path)).

%% Internals

walk(List) ->
    walk(List, []).

walk([], Ret) -> string:join(lists:reverse(Ret), "/");
walk([ "." | Rest ], Ret) -> walk(Rest, Ret);
% Cannot jump higher than "/". E.g. "../bar" == "/bar".
walk([ ".." | Rest ], []) -> walk(Rest, [[]]);
% Jumped up to the "/". Cannot jump any higher.
walk([ ".." | Rest ], [[]]) -> walk(Rest, [[]]);
walk([ ".." | Rest ], [ _Current | Ret ] ) -> walk(Rest, Ret);
walk([ Current | Rest ], Ret) -> walk(Rest, [Current | Ret]).

path_split(Path) ->
	path_split(Path, [], []).

path_split([], Curr, Ret) -> lists:reverse([ lists:reverse(Curr) | Ret]);
path_split([ $/ | Rest ], Curr, Ret) -> path_split(Rest, [], [ lists:reverse(Curr) | Ret ]);
path_split([ Char | Rest ], Curr, Ret) -> path_split(Rest, [Char | Curr], Ret).

%% End of Module.
