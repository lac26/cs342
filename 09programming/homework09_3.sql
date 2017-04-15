--create index role_index from role(actorId, movieId); 
--this index was not necessary because the database engine automatically creates a unique index to enforce the uniqueness of the primary key.
--create index first_last from actor(id, firstName, lastName); no effect

/*
select a.id, a.firstName, a.lastName
from Actor a, Role r, Movie m
where a.id = r.actorId
and r.movieId = m.id
and (select count(*) from movie where r.movieid = m.id) > 10
group by a.id, a.firstName, a.lastName
having avg(m.rank) > 8.5;
*/

--drop index role_index;


/* original execution, not modified
--------------------------------------------------------------------------------
---------

|   0 | SELECT STATEMENT          |             |   100 |  4000 |  1011   (1)| 0
0:00:13 |

|*  1 |  FILTER                   |             |       |       |            |
        |

|   2 |   HASH GROUP BY           |             |   100 |  4000 |  1011   (1)| 0
0:00:13 |

|*  3 |    FILTER                 |             |       |       |            |
        |

|*  4 |     HASH JOIN             |             |  1993 | 79720 |    13   (8)| 0
0:00:01 |

|*  5 |      HASH JOIN            |             |  1993 | 37867 |     8  (13)| 0
0:00:01 |

|   6 |       TABLE ACCESS FULL   | MOVIE       |    41 |   369 |     2   (0)| 0
0:00:01 |

|   7 |       INDEX FAST FULL SCAN| SYS_C007457 |  1993 | 19930 |     5   (0)| 0
0:00:01 |

|   8 |      TABLE ACCESS FULL    | ACTOR       |  1910 | 40110 |     5   (0)| 0
0:00:01 |

|   9 |     SORT AGGREGATE        |             |     1 |       |            |
        |

|* 10 |      FILTER               |             |       |       |            |
        |

|  11 |       INDEX FULL SCAN     | SYS_C007451 |    41 |       |     1   (0)| 0
0:00:01 |

--------------------------------------------------------------------------------
*/

--updated the query so would not have a seperate select clause to make more efficient



create index id_rank on Movie(id, rank);

create index id_first_last on Actor(id, firstName, lastName);

select a.id, a.firstName, a.lastName
from Actor a, Role r, Movie m
where a.id = r.actorId
and r.movieId = m.id
group by a.id, a.firstName, a.lastName
having avg(m.rank) > 8.5
and count(*) > 10;

--drop index first_last;
drop index id_rank;
drop index id_first_last;

/*
execution with the updated query:

| Id  | Operation                | Name        | Rows  | Bytes | Cost (%CPU)| Ti
me     |

--------------------------------------------------------------------------------
--------

|   0 | SELECT STATEMENT         |             |     5 |   200 |    14  (15)| 00
:00:01 |

|*  1 |  FILTER                  |             |       |       |            |
       |

|   2 |   HASH GROUP BY          |             |     5 |   200 |    14  (15)| 00
:00:01 |

|*  3 |    HASH JOIN             |             |  1993 | 79720 |    13   (8)| 00
:00:01 |

|*  4 |     HASH JOIN            |             |  1993 | 37867 |     8  (13)| 00
:00:01 |

|   5 |      TABLE ACCESS FULL   | MOVIE       |    41 |   369 |     2   (0)| 00
:00:01 |

|   6 |      INDEX FAST FULL SCAN| SYS_C007457 |  1993 | 19930 |     5   (0)| 00
:00:01 |

|   7 |     TABLE ACCESS FULL    | ACTOR       |  1910 | 40110 |     5   (0)| 00
:00:01 |

--------------------------------------------------------------------------------
--------

significant improvement in execution plan, got rid of these commnads:

|   9 |     SORT AGGREGATE        |             |     1 |       |            |
        |

|* 10 |      FILTER               |             |       |       |            |
        |

|  11 |       INDEX FULL SCAN     | SYS_C007451 |    41 |       |     1   (0)| 0
*/

/* after adding id_rank and id_first_last improvement in execution plan.
Instead of doing TABLE ACCESS FULL for MOVIE and ACTOR does INDEX FAST FULL SCAN for both movie and actor.
The TABLE ACCESS FULL reads all of the rows and columns of the table where as the INDEX FAST FULL SCAN 
reads the entire index in the disk - since I included all the necessary rows from the table in the index
I could do an index scan and thus save time.
--------------------------------------------------------------------------------
-------

|   0 | SELECT STATEMENT         |            |     5 |   200 |    10  (20)| 00:
00:01 |

|*  1 |  FILTER                  |            |       |       |            |
      |

|   2 |   HASH GROUP BY          |            |     5 |   200 |    10  (20)| 00:
00:01 |

|*  3 |    HASH JOIN             |            |  1993 | 79720 |     9  (12)| 00:
00:01 |

|*  4 |     HASH JOIN            |            |  1993 | 37867 |     5  (20)| 00:
00:01 |

|   5 |      INDEX FULL SCAN     | MOVIEINDEX |    41 |   369 |     1   (0)| 00:
00:01 |

|   6 |      INDEX FAST FULL SCAN| ROLEINDEX  |  1993 | 19930 |     3   (0)| 00:
00:01 |

|   7 |     INDEX FAST FULL SCAN | ACTORINDEX |  1910 | 40110 |     4   (0)| 00:
00:01 |

--------------------------------------------------------------------------------
*/