	My project is a design for a virtual library database.  The potential users of this database would be 

anyone with books who was willing to lend or borrow books.  Similar to Uber, both the lenders and the 

borrowers would be rated with stars so, when lending a book, both the lender and the borrower would know 

the other person was trustworthy.  The application would keep track of who was lending which of the 

lenders books, also eliminating the worry of having to remember who has what.  In future iterations, 

features such as renting or selling books could also be added.


	The tables in the database are Person, Book, PersonBook (since Person:Book is a many-many relationship), 

Group, GroupPerson (because Person:Group is also a many-to-many relationship), Condition (specifying the 

possible condition values of the book), Collection, BookCollection, CollectionGroup, and LoanBook.  


	The Group table would be say if a group of people wanted to share their libraries with each other (i.e. a 

household, a homeschool group, or a group of friends).  By joining that group you could have access to 

everyone in the group’s books.


	The Collection table allows users to store their books in a collection for sorting.  Additionally, the 

CollectionGroup table allows a user to share their whole collection with a group.  For example, if a user 

had a collection "Turkish Books" they would be able to share the whole collection with say the "Grand 

Rapids Turkish Book Swap" group.


	The Condition table lists legal value for the condition entry in the Book table along with a description 

of what the condition value represents.


