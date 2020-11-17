:- dynamic(contains/2).

capacity(bucket1, 4).
capacity(bucket2, 3).

contains(_AnyBucket, Content) :-
	Content >= 0.
contains(bucket1, 0).
contains(bucket2, 0).



operation(empty, SomeBucket, _OtherBucket) :-
	retract(contains(SomeBucket, _AnyAmount)),
	assert(contains(SomeBucket, 0)).

operation(fillCompletely, SomeBucket, _OtherBucket) :-
	retract(contains(SomeBucket, _AnyAmount)),
	capacity(SomeBucket, Capacity),
	assert(contains(SomeBucket, Capacity)).

operation(fillOtherFromSome, SomeBucket, OtherBucket) :-
	retract(contains(OtherBucket, _AnyAmount)),
	capacity(OtherBucket, OtherCapacity),
	assert(contains(OtherBucket, OtherCapacity)),
	content(SomeBucket, SomeContent),
	NewSomeContent is SomeContent - OtherCapacity,
	retract(contains(SomeBucket, _AnyAmount)),
	assert(contains(SomeBucket, NewSomeContent)).

operation(emptySomeIntoOther, SomeBucket, OtherBucket) :-
	retract(contains(SomeBucket, SomeContent)),
	assert(contains(SomeBucket, 0)),
	content(OtherBucket, OtherContent),
	NewOtherContent is SomeContent + OtherContent,
	retract(contains(OtherBucket, _AnyAmount)),
	assert(contains(OtherBucket, NewOtherContent)).



solve(bucket1, FinalContent1, bucket2, _FinalContent2) :-
	content(bucket1, FinalContent1).

solve(bucket1, FinalContent1, bucket2, FinalContent2) :-
	operation(_AnyOperation, _SomeBucket, _OtherBucket),
	solve(bucket1, FinalContent1, bucket2, FinalContent2).
