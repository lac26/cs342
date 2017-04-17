/* Query 1: selects all books for a given user, including the quantity and condition
For this example, no user is specified so selects this information for all users
This would be useful in order for a user to see all of his/her books and the condition of those books
*/
SELECT P.lastName || ', ' ||  P.firstName  || ' has book:  ' || B.title || ' COND:' || C.cond AS Book_Person_Condition
FROM Person P, Book B, PersonBook PB, Condition C
WHERE P.ID = PB.ownerID 
AND PB.bookID = B.ID
AND B.condition = C.cond;
--why I chose this approach: used a WHERE with AND statements because, since only using 4 tables seemed more intuitive than a join
--I adjusted the SELECT line to make the output easier to read

 /* Query 2: selects all share groups and shows how many books are in them (both books shared directly and books shared via collections)
 This would be relevant to users scrolling through share groups to see waht share groups were available and how many books each of those share groups had 
 further explanation of how this query works:
I first get the name of all groups and the number of books shared directly with that group 
(shared via the BookGroup relationship).
Then, I get the name of all the groups and the number of books shared to the group via a collection
(shared via the CollectionGroup and BookCollection relationships).
I then union both of those results and store the union as an alias SharedBookGroups.
I group all of the results in SharedBookGroups by the name of the group and then add the counts
for each group to get the total number of books (both directly and via collections) shared with a ShareGroup.
*/
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

 
 /* Query 3: Find all books that should have been returned by now.  Print out the borrowers name, title of books, and due date (computed).
 * Useful for finding all books in the system that are overdue and could then potentially be used to send out notifications etc.
 */
 SELECT borrower.firstName || ' ' || borrower.lastName || ' BORROWED ' || B.title || ' WAS DUE AT ' || (LB.loanDate + (7 * LB.loanWeeks)) AS Borrowers 
 FROM Person borrower, Person lender, LoanBook LB, Book B
 WHERE LB.loanWeeks IS NOT NULL 
 AND LB.loanDate + (7*LB.loanWeeks) < sysdate 
 AND LB.borrowerID = borrower.id 
 AND LB.loanerID = lender.ID
 AND B.ID = LB.bookID;
 -- why I chose this approach: I could have used a JOIN instead of WHERE statements however, because I was only joining 3 tables using a join here was simpler
 -- I compare sysdate to the due date of the book (the loan date plus the loan weeks) to determine if it is overdue

 /*Query 4: The number of users with collections
	This shows how many users are using the collection feature of the application
    */
 SELECT COUNT(*) AS USERS_WITH_COLLECTIONS FROM (
 SELECT distinct P.id from Person P where P.ID IN
	(select PB.ownerID from PersonBook PB where PB.bookID IN
		(select B.ID from Book B where B.ID IN
			(select BC.bookID from BookCollection BC where BC.collectionID IN
	  			(select C.ID from Collection C)))));
 --why I chose this approach: I could have also used a JOIN here instead and gotten the same results.
 --however, since I only needed to get data relating to the person(and not attributes of other relations), it seemed more intuitive to do the select statement
 --and 'build my way up' from the collection to the Person

/* View 1:
view of all a person's book and (if they are in a collection) the collection 
this makes it easy to create queries regarding individual's books (i.e. what books they have, what collections the books belong to)
since the data in this view will be frequently updated - every time a book or collection is added - it makes more sense to implement the view NOT as a materialized view (the default)*/
drop view Person_Book_Collection;
CREATE VIEW Person_Book_Collection
AS SELECT P.ID AS PersonID, P.firstName, P.lastName, B.ID AS BookID, B.title, C.id AS CollectionID, C.name FROM
Person P JOIN (
	 PersonBook PB JOIN  (
	 	Book B LEFT OUTER JOIN
 			(BookCollection BC JOIN Collection C
 			ON BC.collectionID = C.ID)
	 	ON B.ID = BC.bookID)
	 ON PB.bookID = B.ID)
	ON P.ID = PB.ownerID;
	select * from Person_Book_Collection;




	
	  			


