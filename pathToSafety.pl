% AI  -  Assignment 1  -  Part 2 (2019 - 2020)
% 		    Path to Safety - Game

:- use_module(test).

play(Moves, Stars):-
	start([X,Y]),
	end([E,F]),
	path(state(X,Y), state(E,F), Moves, [], Stars, 0, [state(X,Y)]).

path(End, End, Moves, Moves, Stars, Stars, _):-
	Stars > 0.

path(State, End, Moves, MovesList, Stars, StarsCount, Visited):-
	move(State, NextState, Direction, StarsCount, NewStars),
	safeState(NextState),
	\+ member(NextState, Visited),
	append(MovesList, [Direction], NewMoves),
	path(NextState, End, Moves, NewMoves, Stars, NewStars, [NextState | Visited]).

safeState(state(X, Y)):-
	dim(A, B),
	X < A, X >= 0,
	Y < B, Y >= 0,
	not(bomb([X,Y])).

% move rules, each for a move: Left, Right, Up, Down.
% Using X, Y
% Left -> A = X	    ,	B = Y - 1.
% Right-> A = X	    ,	B = Y + 1.
% Up   -> A = X - 1 ,	B = Y.
% Down -> A = X + 1 ,	B = Y.

% Left
move(state(X, Y), state(NewX, NewY), Direction, StarsCount, NewStars):-
	NewX = X, NewY is (Y - 1), Direction = left,
	((star([NewX, NewY]) -> NewStars is (StarsCount + 1)) ; NewStars = StarsCount).
% Right
move(state(X, Y), state(NewX, NewY), Direction, StarsCount, NewStars):-
	NewX = X, NewY is (Y + 1), Direction = right,
	((star([NewX, NewY]) -> NewStars is (StarsCount + 1)) ; NewStars = StarsCount).
% Up
move(state(X, Y), state(NewX, NewY), Direction, StarsCount, NewStars):-
	NewX is (X - 1), NewY = Y, Direction = up,
	((star([NewX, NewY]) -> NewStars is (StarsCount + 1)) ; NewStars = StarsCount).
% Down
move(state(X, Y), state(NewX, NewY), Direction, StarsCount, NewStars):-
	NewX is (X + 1), NewY = Y, Direction = down,
	((star([NewX, NewY]) -> NewStars is (StarsCount + 1)) ; NewStars = StarsCount).
