--when addding a book to a person, make sure that the same book (just with a diff id)
--does not exist for that specific person

/*
The trigger noSameBook ensures that when adding a book to a person (i.e. adding an entry to Person Book table)
that the book being added is not similar in every aspect but the id (in other words, that the same book, just with a different id, has not been added to that person in the PersonBook table)
*/

CREATE OR REPLACE TRIGGER noSameBook
BEFORE INSERT OR UPDATE ON PersonBook
For each row 
DECLARE bookAuthor Book.author%type;
		bookTitle Book.title%type;
		bookEdition Book.edition%type;
		bookCondition Book.condition%type;
		counter integer;
		sameEntry EXCEPTION;
BEGIN
SELECT author, title, edition, condition, id
INTO bookAuthor, bookTitle, bookEdition, bookCondition
FROM Book where id = :new.bookId;
SELECT COUNT(*)
INTO counter
FROM PersonBook PB, Book B, Person P
WHERE PB.bookId = B.id AND PB.ownerID = P.id
AND B.author = bookAuthor AND B.title = bookTitle
AND B.edition = bookEdition AND B.condition = bookCondition;
if counter >0 THEN
	raise sameEntry;
end if;
EXCEPTION
when sameEntry THEN
	RAISE_APPLICATION_ERROR(-20001, 'there is already a entry for this person with a similar book (new book id is:) '||bookId);
END;
/

show errors;

--reset
delete from PersonBook where bookid=1 and ownerid=5;
delete from PersonBook where bookid=81 and ownerid=5;
delete from Book where id=81;

INSERT INTO PersonBook Values(1, 5, 2);

--similar to book id 1
INSERT INTO Book VALUES (81,'Thomas H. Cormen','Introduction to Algorithms,',2,'awful');

--book id, person id, quant
INSERT INTO PersonBook Values(81,5,2);


--it works!
