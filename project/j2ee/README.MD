The information returned in my J2EE application is:

GET book/{id}
Returns an individual book record with the id of {id}
With the book record, returns the condition of the book (along with what that condition means), along with the groups
and collections the book is in

GET group/{id}
Returns an individual group record with the id of {id}
With the group record, returns the books contained in the group

GET books
Returns all books
With the book record, returns the condition of the book (along with what that condition means), along with the groups
and collections the book is in

DELETE book/{id}
Deletes the book with the specifid id

PUT book/{id}
Reads a persons data in JSON format and updates exsiting book record
While doing this, sets the condition description to match the condition name
Also, checks to see that all groups & collections for the record are in the DB by checking for their PK

POST book
Reads a persons data in JSON format and puts new record, uses the iterator to determine the ID
While doing this, sets the condition description to match the condition name
Also, checks to see that all groups & collections for the record are in the DB by checking for their PK

POST book/group/{groupid}/book/{bookid}
Posts the book with specified id to the group with the specified id.

This information would be useful for the web application development because the Book is one of the key entitites in my database.
This interface would allow the book to be assigned to a new group or a new collection and would allow a user to 
delete a book or update information about the book (such as the condition).  It would also allow the user to easily add a book to a group (and book to a group).
