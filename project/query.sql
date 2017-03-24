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

a join of at least four tables  -- ok
proper comparisons of NULL values
a self-join using tuple variables
a combination of inner and outer joins --ok
a nested select statement -- ok
aggregate statistics on grouped data --ok
If appropriate, list the other ways you might have designed each query and justify why your chose your approach (one to two sentences per query).
You may need to modify your schema (and ERD) or your database instance to support these queries. The information “value” of your queries matters here, so don’t just pick simple queries; pick queries that would matter to your stakeholders. Talk to me if you have any questions about the appropriate nature and/or complexity of your queries.

Submit your solution as a commented SQL command file in queries.sql by the end of unit 8. We’ll grade on the utility, complexity and correctness of your queries.
*/

--select all books for a given user, including their quanity and condition 
-- this example, since no user is specified, will do it for all users
SELECT P.lastName || ', ' ||  P.firstName  || ' has book:  ' || B.title || ' COND:' || C.cond AS Book_Person_Condition
FROM Person P, Book B, PersonBook PB, Condition C
WHERE P.ID = PB.ownerID 
AND PB.bookID = B.ID
AND B.condition = C.cond;

 /*
This query gets the total books shared in each share group.
I first get the name of all groups and the number of books shared directly with that group 
(shared via the BookGroup relationship).
Then, I get the name of all the groups and the number of books shared to the group via a collection
(shared via the CollectionGroup and BookCollection relationships).
I then union both of those results and store the union as an alias SharedBookGroups.
I group all of the results in SharedBookGroups by the name of the group and then add the counts
for each group to get the total number of books (both directly and via collections) shared with a ShareGroup.
 */

 --all share gruops with books in them, show how many books
 SELECT SharedBookGroups.name, Sum(SharedBookGroups.books) AS Total_Books
 From (
 SELECT SG.name AS name, Count(*) AS Books
FROM ShareGroup SG LEFT OUTER JOIN
 (CollectionGroup CG JOIN  
 	(Collection C JOIN
 (BookCollection BC JOIN Book B 
 	ON BC.bookID = B.ID)
 ON C.ID = BC.collectionID)
 	ON CG.collectionID = C.ID)
 ON SG.ID = CG.groupID
 Group By SG.id, SG.name
 Union All
 SELECT SG.name AS name, Count(*) AS Books
FROM ShareGroup SG LEFT OUTER JOIN
 (BookGroup BG JOIN Book B 
 	ON BG.bookID = B.ID)
 	ON SG.ID = BG.groupID
 GROUP BY SG.id, SG.name
 ) SharedBookGroups
 Group By SharedBookGroups.name;

