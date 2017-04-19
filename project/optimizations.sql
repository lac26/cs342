SET AUTOTRACE ON;
SET SERVEROUTPUT ON;
SET TIMING ON;

SET AUTOTRACE TRACEONLY;

create index person_index on Person(id, firstName, lastName);
create index book_index on Book(id, title);
create index compute_weeks on LoanBook(loanWeeks*7);
--not creating an index for LoanBook because we use all of the fields in that table

/*Query 4: The number of users with collections
	This shows how many users are using the collection feature of the application
    */
    
SELECT borrower.firstName || ' ' || borrower.lastName || ' BORROWED ' ||
 B.title || ' WAS DUE AT ' || (LB.loanDate + (7 * LB.loanWeeks)) AS Borrowers 
 FROM Person borrower, Person lender, LoanBook LB, Book B
 WHERE LB.loanWeeks IS NOT NULL 
 AND LB.loanDate + (7*LB.loanWeeks) < sysdate 
 AND LB.borrowerID = borrower.id 
 AND LB.loanerID = lender.ID
 AND B.ID = LB.bookID;

 drop index person_index;
 drop index book_index;
drop index compute_weeks;


 /*


Elapsed: 00:00:00.01

Execution Plan
----------------------------------------------------------
Plan hash value: 1454287942

--------------------------------------------------------------------------------
| Id  | Operation           | Name     | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------
|   0 | SELECT STATEMENT    |          |    15 |  1965 |     7  (15)| 00:00:01 |
|*  1 |  HASH JOIN          |          |    15 |  1965 |     7  (15)| 00:00:01 |
|*  2 |   HASH JOIN         |          |    15 |   990 |     5  (20)| 00:00:01 |
|*  3 |    TABLE ACCESS FULL| LOANBOOK |    15 |   720 |     2   (0)| 00:00:01 |
|   4 |    TABLE ACCESS FULL| PERSON   |    26 |   468 |     2   (0)| 00:00:01 |
|   5 |   TABLE ACCESS FULL | BOOK     |    26 |  1690 |     2   (0)| 00:00:01 |
--------------------------------------------------------------------------------

 */

 /* After adding person index, changed TABLE ACCESS FULL | PERSON to INDEX FULL SCAN | PERSON_INDEX

Elapsed: 00:00:00.01

Execution Plan
----------------------------------------------------------
Plan hash value: 857816086

--------------------------------------------------------------------------------
----

| Id  | Operation           | Name         | Rows  | Bytes | Cost (%CPU)| Time
   |

--------------------------------------------------------------------------------
----

|   0 | SELECT STATEMENT    |              |    15 |  1965 |     6  (17)| 00:00:
01 |

|*  1 |  HASH JOIN          |              |    15 |  1965 |     6  (17)| 00:00:
01 |

|*  2 |   HASH JOIN         |              |    15 |   990 |     4  (25)| 00:00:
01 |

|*  3 |    TABLE ACCESS FULL| LOANBOOK     |    15 |   720 |     2   (0)| 00:00:
01 |

|   4 |    INDEX FULL SCAN  | PERSON_INDEX |    26 |   468 |     1   (0)| 00:00:
01 |

|   5 |   TABLE ACCESS FULL | BOOK         |    26 |  1690 |     2   (0)| 00:00:
01 |

--------------------------------------------------------------------------------
----

 */

 /*
After adding book_index, instead of doing TABLE ACCESS FULL | BOOK now does INDEX FULL SCAN | BOOK_INDEX
Elapsed: 00:00:00.01

Execution Plan
----------------------------------------------------------
Plan hash value: 4258302577

--------------------------------------------------------------------------------
----

| Id  | Operation           | Name         | Rows  | Bytes | Cost (%CPU)| Time
   |

--------------------------------------------------------------------------------
----

|   0 | SELECT STATEMENT    |              |    15 |  1965 |     5  (20)| 00:00:
01 |

|*  1 |  HASH JOIN          |              |    15 |  1965 |     5  (20)| 00:00:
01 |

|*  2 |   HASH JOIN         |              |    15 |   990 |     4  (25)| 00:00:
01 |

|*  3 |    TABLE ACCESS FULL| LOANBOOK     |    15 |   720 |     2   (0)| 00:00:
01 |

|   4 |    INDEX FULL SCAN  | PERSON_INDEX |    26 |   468 |     1   (0)| 00:00:
01 |

|   5 |   INDEX FULL SCAN   | BOOK_INDEX   |    26 |  1690 |     1   (0)| 00:00:
01 |

--------------------------------------------------------------------------------
----

 */

 /* after adding compute_weeks index, does NESTED LOOPS instead of HASH JOIN

 Execution Plan
----------------------------------------------------------
Plan hash value: 193414205

--------------------------------------------------------------------------------
----

| Id  | Operation           | Name         | Rows  | Bytes | Cost (%CPU)| Time
   |

--------------------------------------------------------------------------------
----

|   0 | SELECT STATEMENT    |              |     1 |   144 |     4   (0)| 00:00:
01 |

|   1 |  NESTED LOOPS       |              |     1 |   144 |     4   (0)| 00:00:
01 |

|   2 |   NESTED LOOPS      |              |     1 |    79 |     3   (0)| 00:00:
01 |

|*  3 |    TABLE ACCESS FULL| LOANBOOK     |     1 |    61 |     2   (0)| 00:00:
01 |

|*  4 |    INDEX RANGE SCAN | PERSON_INDEX |     1 |    18 |     1   (0)| 00:00:
01 |

|*  5 |   INDEX RANGE SCAN  | BOOK_INDEX   |     1 |    65 |     1   (0)| 00:00:
01 |

--------------------------------------------------------------------------------
----

 

 */