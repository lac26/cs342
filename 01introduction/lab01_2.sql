/* to get the contents of the table */
SELECT * from dual;

/* to get the format (schema) of the table */
DESCRIBE dual;

/* exploring additional functionality */
SELECT sysdate from dual;
SELECT user from dual;

/*
dual stores values such as the sysdate and the user
it has one column with the type being varchar
it is set by default to x
I'm not sure what this table would be used for, other than having a place to get the date and the current user
 */
