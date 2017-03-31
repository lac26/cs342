CREATE OR REPLACE PROCEDURE castDirector(actor IN Actor.id%type, movie IN Actor.id%type, role IN Role.role%type)
AS
BEGIN
INSERT INTO Role (actorId, movieId, role) VALUES (actor, movie, role);
END;
/

--execute procedure
--EXECUTE castDirector(1, 4, 'Danny Ocean');

--my own tests

/*
--delete the rows from row
DELETE FROM role WHERE actorId = 616440 
AND movieId = 10920
AND role = 'Danny Ocean';

DELETE FROM role WHERE actorId = 616440 
AND movieId = 10920
AND role = 'Beka Agava';

--inser the rows

BEGIN 
castDirector(616440, 10920, 'Danny Ocean');
castDirector(616440, 10920, 'Beka Agava');
END;
/
*/



--create trigger not allowing actors to be cast more than once for each movie
CREATE OR REPLACE TRIGGER onlyOnce 
BEFORE INSERT OR UPDATE ON Role 
FOR each row
DECLARE
counter INTEGER;
tooManyMovies EXCEPTION;
BEGIN
SELECT COUNT(*) INTO counter FROM Role
WHERE movieId = :new.movieId AND actorID =:new.actorID;
IF counter >= 2 THEN
	raise tooManyMovies;
END IF;
EXCEPTION
WHEN tooManyMovies THEN
RAISE_APPLICATION_ERROR (-20001, 'this actor is in too many movies:'||:new.actorID);
END;
/


--do not allow more than 230 castings for any movie
CREATE OR REPLACE TRIGGER limit230
BEFORE INSERT OR UPDATE ON Role 
FOR each row
DECLARE
counter INTEGER;
tooManyActors EXCEPTION;
BEGIN
SELECT COUNT(*) INTO counter FROM Role
WHERE movieId = :new.movieId;
IF counter >= 230 THEN
	raise tooManyActors;
END IF;
EXCEPTION
WHEN tooManyActors THEN
RAISE_APPLICATION_ERROR (-20001, 'this movie has too many actors:'||:new.movieId);
END;
/

--tests as specfied in lab

--delete added entries (if necessary)
/*
DELETE FROM role WHERE actorId = 89558 
AND movieId = 238072
AND role = 'Danny Ocean';

DELETE FROM role WHERE actorId = 89558 
AND movieId = 238073
AND role = 'Danny Ocean';

DELETE FROM role WHERE actorId = 89558 
AND movieId = 167324
AND role = 'Danny Ocean';
*/

--insert the rows
BEGIN 
castDirector(89558, 238072, 'Danny Ocean');
END;
/


BEGIN
castDirector(89558, 238073, 'Danny Ocean');
END;
/



BEGIN
castDirector(89558, 167324, 'Danny Ocean');
END;
/

