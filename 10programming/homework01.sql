insert into Movie VALUES (999999,'Test Movie',2001,6.9,NULL);

select count(*)
from movie
where id = 999999;
--delete from one instance did not affect the table in another instance

--after rollback the count of movie in both of them is 1 again

--add movie, movia in session 1 but not session 2.  after running query movie in both sessions

--Yes, oracle does handle the transaction life cycle because the instructions to commit etc. must be specified in Oracle.
-- No, we can not gurantee simply with commit etc.  Durability is not relevant here but there would be no way not to violate the Isolate property because
-- if one did two different transactions (in 2 different sections) and then committed both of those transactions, those transactions 
-- might then interfere with each other.  
-- Another example of this property would be creating two objects wit the same primary key in seperate sessions and then trying to commit them both.  Though they
-- both would be fine in each session once they had been committed the one committed could not be rolled back, leading to inconsistencies.
-- Could do atomicity because if the commands work, could commit all the updates.  If not, would not commit.
-- Consistency is possible because the database would go from one consistent state to another because the database would not allow inconsistent points and could ROLLBACK to SAVEPOINT.





/*
DECLARE
	intOut integer;
BEGIN 
	FOR i IN 1..1000 LOOP
		SELECT COUNT(*)
		INTO intout
		FROM Movie
		WHERE id=238073;
	END LOOP;
END;
*/