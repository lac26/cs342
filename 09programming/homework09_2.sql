--create index group_bys from director(id, firstName, lastName); no effect
-- create index first_last_name from moviedirector(firstName || ' , ' || lastName); no effect

SET AUTOTRACE TRACEONLY;

/*
select d.firstName || ' , ' || d.lastName, count(1)
from director d, moviedirector md
where md.directorid = d.id
group by d.id, d.firstName, d.lastName
having count(*) > 200;
*/

--without any adjustments
/*
Elapsed: 00:00:00.17
Execution Plan
----------------------------------------------------------
Plan hash value: 2646178372
--------------------------------------------------------------------------------
--------------
| Id  | Operation            | Name          | Rows  | Bytes |TempSpc| Cost (%CP
U)| Time     |
--------------------------------------------------------------------------------
--------------
|   0 | SELECT STATEMENT     |               | 19033 |   483K|       |  1833   (
1)| 00:00:22 |
|*  1 |  FILTER              |               |       |       |       |
  |          |
|   2 |   HASH GROUP BY      |               | 19033 |   483K|    11M|  1833   (
1)| 00:00:22 |
|*  3 |    HASH JOIN         |               |   380K|  9665K|  2800K|   745   (
1)| 00:00:09 |
|   4 |     TABLE ACCESS FULL| DIRECTOR      | 86880 |  1781K|       |    86   (
2)| 00:00:02 |
|   5 |     TABLE ACCESS FULL| MOVIEDIRECTOR |   380K|  1858K|       |   215   (
1)| 00:00:03 |
--------------------------------------------------------------------------------
--------------
*/

create index movied_id from moviedirector(directorid); 
 

select d.firstName || ' , ' || d.lastName, count(1)
from director d, moviedirector md
where md.directorid = d.id
group by d.id, d.firstName, d.lastName
having count(1) > 200;

drop index movie_id;

/* adding the movie_id index adjsuted the execution to be 
--------------

| Id  | Operation             | Name                 | Rows  | Bytes | Cost (%CP
U)| Time     |

--------------------------------------------------------------------------------
--------------

|   0 | SELECT STATEMENT      |                      |    41 |  5330 |     1   (
0)| 00:00:01 |

|*  1 |  FILTER               |                      |       |       |
  |          |

|   2 |   SORT GROUP BY NOSORT|                      |    41 |  5330 |     1   (
0)| 00:00:01 |

|   3 |    NESTED LOOPS       |                      |    41 |  5330 |     1   (
0)| 00:00:01 |

|   4 |     INDEX FULL SCAN   | DIRECTORINDEX        |    34 |  3978 |     1   (
0)| 00:00:01 |

|*  5 |     INDEX RANGE SCAN  | MOVIEDIRECTORIDINDEX |     1 |    13 |     0   (
0)| 00:00:01 |

--------------------------------------------------------------------------------
--------------
*/

--the index full scan is preferable because it reads the entire index as compared to reading the entire table (all rows and columns)

