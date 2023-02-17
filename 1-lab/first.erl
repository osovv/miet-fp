-module(first).
-export([seconds/3, lmin/1, distinct/1, split_all/2, sublist/3]).
-include_lib("eunit/include/eunit.hrl").

%% Variant 22

% Task 1

seconds(Hours, Minutes, Seconds) -> Hours * 3600 + Minutes * 60 + Seconds.

seconds_example_test() -> ?assert(3721 =:= seconds(1,2,1)).
seconds_zero_test() -> ?assert(0 =:= seconds(0,0,0)).
seconds_full_test() -> ?assert(86400 =:= seconds(24,0,0)).

% Task 2

lmin([]) -> throw("list is empty");
lmin(List) ->
  Cmp = fun(A, B) ->
          case A < B of
            true -> A;
            false -> B
          end
        end,
  lists:foldl(Cmp, void, List).

lmin_example_test() -> ?assert(1 =:= lmin([6,1,4])).
lmin_empty_test() -> ?assertThrow("list is empty", lmin([])).
lmin_with_negative_test() -> ?assert(-100000 =:= lmin([6,-100000,4])).

% Task 3

distinct([]) -> true;
distinct(List) -> sets:size(sets:from_list(List)) == length(List).

distinct_example1_test() -> ?assert(true =:= distinct([4,2,a,false])).
distinct_example2_test() -> ?assert(false =:= distinct([1,2,2,3])).
distinct_empty_test() -> ?assert(true =:= distinct([])).

% Task 4
split_all([], _) -> [];
split_all(List, N) when length(List) < N -> [List];
split_all(List, N) ->
  {X, T} = lists:split(N, List),
  lists:append([X], split_all(T, N)).


split_all_empty_test() -> ?assert([] =:= split_all([], 3)).
split_all_small_test() -> ?assert([[1,2,3]] =:= split_all([1,2,3], 100)).
split_example_test() -> ?assert([[1,2,3], [4,5]]  =:= split_all([1, 2, 3, 4, 5], 3)).
split_multiple_test() -> ?assert([[1,2], [3,4], [5]]  =:= split_all([1, 2, 3, 4, 5], 2)).

% Task 5

% sublist(_, N, _) when N < 1 -> throw("start index out of range");
% sublist(List, N, _) when N > length(List)-> throw("start index out of range");
% sublist(_, _, M) when M < 1 -> throw("end index out of range");
% sublist(List, _, M) when M > length(List) -> throw("end index out of range");
% sublist(_, N, M) when N > M -> throw("start index bigger than end index");

sublist(_, N, _) when N < 1 -> [];
sublist(List, N, _) when N > length(List)-> [];
sublist(_, _, M) when M < 1 -> [];
sublist(List, _, M) when M > length(List) -> [];
sublist(_, N, M) when N > M -> [];
sublist(List, 1, M) -> {Res, _ } = lists:split(M, List), Res;
sublist([_ | XS], N, M) -> sublist(XS, N-1, M-1).

sublist_empty_test() -> ?assert([] =:= sublist([], 2, 4)).
sublist_out_of_boundaries_1_test() -> ?assert([] =:= sublist([], 0, 4)).
sublist_out_of_boundaries_2_test() -> ?assert([] =:= sublist([1,2,3], 5, 8)).
sublist_out_of_boundaries_3_test() -> ?assert([] =:= sublist([], 2, 0)).
sublist_out_of_boundaries_4_test() -> ?assert([] =:= sublist([1,2], 1, 4)).
sublist_out_of_boundaries_5_test() -> ?assert([] =:= sublist([1,2,3], 2, 1)).
sublist_example_test() -> ?assert([3, 4, 5] =:= sublist([1, 3, 4, 5, 6], 2, 4)).
sublist_one_test() -> ?assert([1, 3, 4, 5, 6] =:= sublist([1, 3, 4, 5, 6], 1, 5)).
sublist_last_test() -> ?assert([6] =:= sublist([1, 3, 4, 5, 6], 5, 5)).
