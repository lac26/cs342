--LYDIA CUPERY
/* a */
/* i */
INSERT INTO movie (id, title, year, score) VALUES (1, 'testing', 1990, 8.0);
/* Error is unique unique constraint violated,
this is because there was already a record with primary key 1 */

/*ii*/
INSERT INTO movie (id, title, year, score) VALUES (NULL, 'testing2', 1990, 8.0);
/*Get the error cannot insert NULL into ("LYDIA"."MOVIE"."ID")
 Since ID is the primary key I get an error when I try to insert a NULL value into it
 */

/* iii */
INSERT INTO movie (id, title, year, score) VALUES (20, 'testing2', 1600, 8.0);
/* Error: check constraint (LYDIA.SYS_C006998) violated
I get this error because my year (1600) is less than the minimum year 1991
 */

/* iv */
INSERT INTO movie (id, title, year, score) VALUES (20, 'testing2', 'a long time ago', 8.0);
/* Error: ORA-01722 invalid number
* I got this error because 'a long time ago' is not a number but, when creating table, year was specified as a 4 digit decimal number
 */

/* v */
INSERT INTO movie(id, title, year, score) VALUES (25, 'horrible movie', 1995, -8.0);
/* no error, a float can be negative */


/* b */
/* i */
INSERT INTO casting(movieID, performerID, status) VALUES (NULL, 4, 'star');
/* no error, since the FK is not required to identify the row it is okay for it to be NULL*/

/* ii */
INSERT INTO casting(movieID, performerID, status) VALUES (20, 4, 'star');
/* error, integrity constraint violated - parent key not found
 The integrity constraints ensures that when adding FK there exists a parent we are referencing
 */

/* iii */
INSERT INTO movie(id, title, year, score) VALUES (11, 'WONDERFUL MOVIE WATCH IT EVERDAY', 1995, 10.0);
/* no error, a referencing table can reference this value if it wants but the values in the referenced table do not need to be valued be the referencing table */

/* c */
/* i */
/* so delete a move that is referenced in casting */
DELETE FROM movie WHERE id = 1;
/* does not produce any errors */
SELECT * FROM casting;
/* when I do display all records in casting, all records with move ID 1 still exist but just have an empty MovieID field because casting has a FK to MovieID.  Thus,
So, cascading did not occur.
 */

/* ii */
DELETE FROM casting WHERE performerID=4;
/* deletes all rows with performerID equal to 4 */
SELECT * FROM casting;
/* no movies with a performer that has ID equal to 4 */
SELECT * FROM performer;
/* the deleting from casting did not affect the IDS in performer (there is still ID number 4 here).  This is because since performer does not reference casting, the updates on casting only affected casting and not performer */

/* iii */
UPDATE Movie
SET id = 101
WHERE id = 2;
/* error, integrity constraint violated, child record found
Because there is a child record (actually there are 2) of movie that has an id=2, cannot delete the parent record
 */









