-module(path_normalizer_tests).

-include_lib("eunit/include/eunit.hrl").

path_normalizer_test_() ->
	% https://github.com/vlm/programming-exercise-c-1#exercise
	TestPaths = [
		{"../bar", "/bar"},
		{"/foo/bar", "/foo/bar"},
		{"/foo/bar/../baz", "/foo/baz"},
		{"/foo/bar/./baz/", "/foo/bar/baz/"},
		{"/foo/../../baz", "/baz"}
	],

	[
		{
			lists:flatten(io_lib:format("Path: [~s]. Normalized: [~s].", [Path, Normalized])),
			fun() -> ?assertEqual(Normalized, path_normalizer:normalize(Path)) end
		} || {Path, Normalized} <- TestPaths
	].
