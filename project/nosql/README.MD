README.The information provided in GetBookValues is appropriate for a noSQL solution because if just accessing the information in a certain
book it makes sense to retrive the information from the book with the key of the book.

However, the key-value system is not the best type of database when attempting to do joins.  Though noSQL worked alright in my implementation because 
I simply got the owners and quantity of the book if I had wanted to reverse that query and gotten the books belonging to an owner, I would
have had to re-implement the whole key-value structure in reverse.  Thus, since my application has a lot of relationships between
tables and thus requires many joins in queries, the KVLite key-value ststen us not the best type of noSQL database.  A graph-based noSQL
database would have worked better.MD