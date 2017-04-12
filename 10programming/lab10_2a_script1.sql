/*
--subtract 1
BEGIN 
	FOR i IN 1..10000 LOOP
		UPDATE movie
		SET rank = rank - 1
		WHERE id = 238071;
	END LOOP;
END;
/

select rank
from Movie
where id = 238071;

--get the final value, should be the same
*/

update movie set rank = rank -1 where id = 238071;

--gives us rank decremented by 1
select rank from movie where id = 238071;


