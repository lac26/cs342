/*trigger everytime update the movie record */

drop table RankLog;
CREATE TABLE RankLog(
	id integer primary key,
	userId varchar(30),
	changeDate date,
	origRank number(10,2),
	updateRank number(10,2)
);


drop sequence ranklog_seq;
CREATE SEQUENCE ranklog_seq
 START WITH 1 
 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER updateRank
AFTER UPDATE OF Rank
ON Movie
FOR EACH ROW 
BEGIN
	INSERT INTO RankLog
	VALUES (ranklog_seq.nextval, user, sysdate, :old.rank, :new.rank);
END;
/

update MOVIE
set rank=9
where id=306032;

update MOVIE
set rank=9.1
where id=306032;

update MOVIE
set rank=9.3
where id=306032;

update MOVIE
set rank=9.6
where id=306032;

select * from ranklog;