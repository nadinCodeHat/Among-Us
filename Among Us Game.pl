%---------- Among Us ----------
%------Find the imposter-------

%Prolog Database
innocent(charlie).
innocent(sam).
imposter(sam).

votes(sam, innocent(sam)).
votes(charlie, innocent(charlie)).
votes(adam, guilty(sam)).
%Prolog Database

%and rule used to join 2 different statements into 1.
and(L,R) :-
	L,R.

% Vote sam is the imposter:
assume_(sam) :-
	not(and(votes(charlie, innocent(charlie)), votes(adam ,guilty(sam)))).

% Vote charlie is the imposter:
assume_(charlie) :-
	not(and(votes(sam, innocent(sam)), not( votes(adam, guilty(sam))))).

% Vote adam is the imposter:
assume_(adam) :-
	not(and(votes(charlie, innocent(charlie)), votes(sam, innocent(sam)))).


%case statement.
case(Val) :-
	Val == 1, (test(assume_(charlie)));
	Val == 2, (test(assume_(sam)));
	Val == 3, (test(assume_(adam))).

%End of Loop display found imposter
endLoop(Val) :-
	Val == 4, setof(Y,assume_(Y),Y), write(Y), !;
	Val <  4, write('You identified the imposter as Charlie!').


%returns the value of the Term
test(Term) :-
	Term, !;
	not(Term), false, !.

%loop until the answer is correct or user Gives up
voteoff :-
	write('\nThere is an Imposter among us!\n'),
	repeat,
	write('\nWho do you think is the imposter?\n'),
	write('[1] Charlie\n[2] Sam\n[3] Adam\n[4] Give Up?\n'),
	write('Choose a number : '),
	read(Number),
	(case(Number), true, !; Number == 4, !),
        endLoop(Number).
