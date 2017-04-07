-- Insert your results into this table.
drop table sequelsTemp;
CREATE TABLE SequelsTemp (
  id INTEGER,
  name varchar2(100),
  PRIMARY KEY (id)
 );
 


create or replace procedure getSequels (movieIdIn in Movie.id%type) as
  cursor seq_movie is
		select seq.id, seq.name from Movie movie, Movie seq
		where movie.id = movieIdIn
		and movie.sequelId = seq.id;
	BEGIN
		for my_seq in seq_movie LOOP
			if my_seq.id IS NOT NULL then 
			getSequels(my_seq.id);
				insert into SequelsTemp values (my_seq.id, my_seq.name);
			END if;
		END LOOP;
END;
/

show errors;

-- Get the sequels for Ocean's 11, i.e., 4 of them.
BEGIN  getSequels(238071);  END;
/
SELECT * FROM SequelsTemp;

-- Get the sequels for Ocean's Fourteen, i.e., none.
BEGIN  getSequels(238075);  END;
/
SELECT * FROM SequelsTemp;

-- Clean up.
DROP TABLE SequelsTemp;
