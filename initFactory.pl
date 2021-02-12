/* In the initial state, both parts are free and have no colour. */
free(a,[]). free(b,[]).
available(green).  available(blue).


/* In each of these goal state, one part only gets shaped and painted. 
  Solving each of these easy planning problems requires 2 actions only.
*/
%% goal_state(S) :-  painted(a,green,S), shaped(a,S).
%% goal_state(S) :-  painted(b,blue,S), shaped(b,S).


/* In this goal state, both parts are shaped, painted and fastened. Solving
   this planning problem requires 7 actions; it takes a few seconds to solve.
*/

goal_state(S) :- connected(a,b,S),
				painted(a,green,S), painted(b,blue,S),
				shaped(a,S), shaped(b,S).


