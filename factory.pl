
	/* Factory domain */

/* Universal situations and fluents based planner  */
:- dynamic free/2.
/* This is necessary if rules with the same predicate in the head are not
   consecutive in your program.
*/

% We are looking for a list of actions represented by a variable Plan
% such that executing actions in Plan leads from the initial state
% to a reachable state where a goal condition is true.

solve_problem(Bound,Plan)  :-  C0 is cputime,     % C0 is time when program starts %
          max_length(Plan,Bound),          % Bound is the maximal length of Plan   %
          reachable(S,Plan),
        goal_state(S),           % A situation S must be a solution of the problem %
          Cf is cputime, D is Cf - C0, nl,     % Cf is time when program finishes  %
          write('Elapsed time (sec): '), write(D), nl.

max_length([],N) :- N >= 0.
max_length([First | L],N1) :- N1 > 0, N is N1 - 1, max_length(L,N).

reachable(S,[]) :- initial_state(S).

/* This rule is for the initial parts of the factory domain.
   Use it when you debug your precondition and other rules and
   when you test whether your program can solve easy planning problems. 
   Comment it out, when answering the last question about heuristics
   in the factory domain. Instead, use the other rule provided below.
*/
%% reachable(S2, [M|List]) :- reachable(S1,List), legal_move(S2,M,S1).

/*The following rule uses declarative heuristics to cut search: remove comments
   and write your rules to implement the predicate useless(M,List) (see below).
   You use this only when answering the last question in the factory domain,
   for solving a planning problem that requires 7 steps.
*/

reachable(S2, [M | ListOfActions]) :- reachable(S1,ListOfActions),
	legal_move(S2,M,S1),
	not useless(M,ListOfActions).

legal_move([A|S], A, S) :- poss(A,S).
initial_state([]).


        	/* Precondition axioms */
% write your precondition rules here: you have to provide brief comments %

poss(drill(X), S) :- free(X, S).

poss(shape(X), S).

poss(bolt(X, Y), S) :-
	free(X, S),
	free(Y, S),
	drilled(X, S),
	drilled(Y, S).
	
poss(paint(X, Colour), S) :-
	free(X, S),
	available(Colour).

        	/* Successor state axioms */
% write your successor state rules here: you have to include brief comments %

drilled(X, [A | S]) :- A = drill(X).
drilled(X, [A | S]) :-
	drilled(X, S),
	A \= shape(X).
	
connected(X, Y, [A | S]) :- A = bolt(X, Y).
connected(X, Y, [A | S]) :-
	connected(X, Y, S),
	A \= shape(X),
	A \= shape(Y).

painted(X, C, [A | S]) :- A = paint(X, C).
painted(X, C, [A | S]) :-
	painted(X, C, S),
	A \= shape(X),
	A \= drill(X),
	not(( A = paint(X, C2), C2 \= C )).
	
shaped(X, [A | S]) :- A = shape(X).
shaped(X, [A | S]) :- shaped(X, S).

free(X, [A | S]) :-
	free(X, S),
	A \= bolt(X, Y).

		/* ---------- Heuristics To Cut Search ------------- */
% write your rules implementing the predicate  useless(Action,History) here. %

useless(paint(X, C), S) :- painted(X, C2, S).

useless(drill(X), S) :- drilled(X, S).

useless(drill(X), S) :- painted(X, C, S).

useless(shape(X), S) :- painted(X, C, S).

useless(shape(X), S) :- drilled(X, S).

:- [initFactory].
/* This last line compiles also the file initFactory.pl  that should be in same
   directory as this file. Do NOT insert this file here because your program 
   will be tested by a TA using different initial and goal states.      */
