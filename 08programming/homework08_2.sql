drop table BaconTable;

create table BaconTable(
	actorID integer primary key,
	baconNumber integer
);


create or replace procedure baconNum(pactorID IN integer, pbaconNum IN integer) IS counter integer;
BEGIN
	--get all actors one away from the target actor (pactor)
	FOR actor IN (select distinct actorID from role where movieID in 
		(select movieID from Role where pactorID = actorID)) LOOP
	--if the person is not in the table, insert into table		
		SELECT COUNT(*) INTO counter FROM baconTable
		WHERE actorID = actor.actorID;		
		IF counter>0 THEN
			--check to see bacon number, if bigger than current bacon number still insert
			UPDATE bacontable set baconNumber = pbaconNum where actorID = actor.actorID and baconNumber > pbaconNum;
			--otherwise, insert into bacon table
		ELSE 
			IF pbaconNum < 41 THEN
				INSERT INTO BaconTable VALUES (actor.actorID, pbaconNum+1);
				baconNum(actor.actorID, pbaconNum+1);
			END IF;
		END IF;	
	END LOOP;
END;
/


BEGIN 
baconNum(22591, 1);
END;
/



show errors;