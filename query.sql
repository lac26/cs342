/*
Queries — Build a set of queries for your system that 
would serve the users/stakeholders you identified in 
your vision statement and test those queries on your representative data. 
The nature and complexity of your queries is up to you, 
but they should satisfy the following requirements.

Include at least three significant queries, 
with comments on what the query returns (one sentence) 
and who would care about the results (another sentence).

Include at least one view, with comments on what the view provides (one sentence)
and who would use it (another sentence).
 Implement it as either a materialized or non-materialized view 
 and justify your choice (one sentence).
Demonstrate your ability to use the following SQL features 
somewhere in your queries/view.

a join of at least four tables
proper comparisons of NULL values
a self-join using tuple variables
a combination of inner and outer joins
a nested select statement
aggregate statistics on grouped data
If appropriate, list the other ways you might have designed each query and justify why your chose your approach (one to two sentences per query).
You may need to modify your schema (and ERD) or your database instance to support these queries. The information “value” of your queries matters here, so don’t just pick simple queries; pick queries that would matter to your stakeholders. Talk to me if you have any questions about the appropriate nature and/or complexity of your queries.

Submit your solution as a commented SQL command file in queries.sql by the end of unit 8. We’ll grade on the utility, complexity and correctness of your queries.
*/

--select all books for a given user, including their quanity and condition 
-- this example, since no user is specified, will do it for all users
SELECT P.ID, P.firstName, P.lastName, B.title, C.cond AS Condition
FROM Person P, Book B, Condition C
WHERE P.ID = B.ID 
AND B.ID = C.ID;



