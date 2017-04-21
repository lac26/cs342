/*
Looking at movie id 350424

select rank from movie where id = 350424;
Rank before incrementing: 6.9

execute incrementRank(350424, .1);
Execute procedure in one instance, new rank is: 5006.9

execute incrementRank(350424, -.1);
Execute 

However, when add one +.1 and one -.1 simultaneosly

In one instance get,   
RANK
----------
    5006.9
However, in the other instance get
ORA-02290: check constraint (SYSTEM.SYS_C007961) violated
ORA-06512: at "SYSTEM.INCREMENTRANK", line 9
ORA-06512: at line 1
The '-.1' starts taking over so it ends up being a negative value.

When run execute incrementRank(350424, .1); in two different sessions
get the result

     RANK
----------
    5331.2
	
Where as if just run execute incrementRank(350424, .1); twice get 

      RANK
----------
   10006.9
   Thus rank is updating incorrectly when running in two instances.
   One of the updates is being lost so it is a lost update.
 
	
*/

--updated procedrue to be 
CREATE OR REPLACE PROCEDURE incrementRank
	(movieIdIn IN Movie.id%type, 
	 deltaIn IN integer
    ) AS
	x Movie.rank%type;
BEGIN
	FOR i IN 1..50000 LOOP
		SELECT rank INTO x FROM Movie WHERE id=movieIdIn FOR UPDATE;
		UPDATE Movie SET rank=x+deltaIn WHERE id=movieIdIn;
		COMMIT;
	END LOOP;
END;
/



--now when I run 
-- execute incrementRank(350424, .1) in one instance and execute incrementRank(350424, .-1) in another instance and then
 select rank from movie where id = 350424;
 
 --I get the correct answer
 /*
 
      RANK
----------
       6.9

 */

