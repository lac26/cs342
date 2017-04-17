/* insert_book_for_person takes in parameters:
quantp - quantity of book to insert for person
personp - person to insert the book for
bookidp - id of book to insert
bookauthorp - author of book to insert
booktitlep - title of book to insert
bookeditionp - edition of book to insert
bookconditionp - condition of book to insert

if the book already exists, simply update the quantity of the book the person has

if the book does not exist, create an instance of that book with the given quantity for the given person
*/
CREATE OR REPLACE PROCEDURE insert_book_for_person (quantp in PersonBook.quant%type, personidp in Person.id%type,
bookidp in Book.id%type, bookauthorp in Book.author%type, booktitlep in Book.title%type,
bookeditionp in Book.edition%type, bookconditionp in Book.condition%type)
As entryCounter integer;
bookCounter integer;
personCounter integer;
BEGIN
SELECT COUNT(*)
INTO entryCounter
FROM Book B, Person P, PersonBook PB
WHERE PB.bookId = B.id AND PB.ownerID = P.id
and B.id = bookidp and P.id = personidp;
SELECT COUNT(*)
INTO bookCounter
FROM Book B
WHERE bookidp = B.id;
SELECT COUNT(*)
INTO personCounter
FROM Person P
WHERE personidp = P.id;
If entryCounter > 0 then
dbms_output.put_line('book already exists so will update quantity of existing book');
updateQuant(quantp, bookidp, personidp);
elsif personCounter > 0 and personCounter > 0 then
		if bookCounter < 1 then
		dbms_output.put_line('creating book and inserting');
		INSERT INTO Book VALUES (bookidp, bookauthorp, booktitlep, bookeditionp, bookconditionp);
		INSERT INTO PersonBook VALUES(bookidp, personidp, quantp);
		else
		RAISE_APPLICATION_ERROR(-20002, 'Book ' || bookidp ||
    	' already exists but corresponding person entry doess not.  Please re-try query with different book or different person' );
		end if;
else 
RAISE_APPLICATION_ERROR(-20003, 'Person ' || personidp ||
    	' does not exist' );
END IF;
END;
/
show errors;

BEGIN 
insert_book_for_person(5, 1, 100,'Jonas','Kraft',2,'awful');
END;
/
--it works!

/* updateQuant updates the quantity of a certain book a person has
quantp - new quantity of book belonging to person with personidp
personidp - the id of the owner of the book
bookidp - the id of the book

If an entry already exists for the book, update it.  Otherwise, throw an error.
*/
CREATE OR REPLACE PROCEDURE updateQuant (quantp in PersonBook.quant%type, bookidp in Book.id%type, personidp in Person.id%type) 
AS counter integer;
BEGIN
SELECT count(*)
INTO counter
FROM Book B, Person P, PersonBook PB
WHERE PB.bookId = B.id AND PB.ownerID = P.id
and B.id = bookidp and P.id = personidp;
if counter = 1 then
	UPDATE PersonBook SET quant = quantp
	WHERE ownerid = personidp and bookid = bookidp;
elsif counter = 0 then
	RAISE_APPLICATION_ERROR(-20000, 'Person ' || personidp ||
    	' with book ' || bookidp || ' does not exist.');
else 
	RAISE_APPLICATION_ERROR(-20001, 'Person ' || personidp ||
    	' with book ' || bookidp || ' has mutliple records.  Fix this before updating.');
end if;
END;
/

BEGIN 
updateQuant(5, 3, 10);
END;
/

show errors;

 select * from personbook where ownerid = 10 and bookid = 3;  
 --it works!