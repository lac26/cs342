CREATE OR REPLACE PROCEDURE transferRank ( firstId in Movie.id%type, secondId in Movie.id%type, rankTrans in Movie.rank%type)
AS 
sourceRank Movie.rank%type;
destRank Movie.rank%type;
negative_rank exception;
negative_transfer exception;
BEGIN
--lock rank when reading from it
SELECT rank
INTO sourceRank
FROM movie where id = firstId FOR UPDATE OF Rank;

if (sourceRank-rankTrans)<0 then
	raise negative_rank;
end if;
if  rankTrans<0 then
	raise negative_transfer;
end if;

UPDATE Movie SET rank = (rank-rankTrans) WHERE id = firstId;
commit;

UPDATE Movie SET rank = (rank+rankTrans) WHERE id = secondId;
commit;

EXCEPTION
when negative_rank THEN
	RAISE_APPLICATION_ERROR(-20001, 'transferring the rank from source movie with id '|| firstId ||' make the rank negative.  Try with smaller value.');
when negative_transfer THEN
	RAISE_APPLICATION_ERROR(-20002, 'You are transferring the negative value  '|| rankTrans ||' please transfer a positive value (if you want to transfer the other direction, switch order of movies :D )');
END;
/

show errors;

--get original values from movies
select rank, name from movie where id = 176712;
select rank,name from movie where id = 176711;

BEGIN
transferRank(176712, 176711, .1);
END;
/

--look at the movies, did they change?
select rank, name from movie where id = 176712;
select rank, name from movie where id = 176711;
