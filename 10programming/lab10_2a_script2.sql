--lost update problems occurs when one of the updates is incorrect
--therefore, in each of the scripts will attempt to update the value with different numbers
/*

--add 1

BEGIN 
	FOR i IN 1..100 LOOP
		UPDATE movie
		SET rank = rank + 1
		WHERE id = 238071;
	END LOOP;
END;
/

select rank
from Movie
where id = 238071;


--get the final value, should be the same
*/

--read
 select rank from MOvie where id = 238071;
 
 --modify
 update movie set rank = rank  + 1 where id = 238071;
 
 --write
 commit;