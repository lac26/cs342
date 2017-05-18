First, ensure that the Oracle Database System is running on your system (I used Oracle Express 11g in development).

Next,

1. Clone this repo and navigate to the /project directory, which contains the create.sql file
2. Start sqlplus with a user with CREATE USER privileges
3. Set the define line in the create.sql file to be the path for the cs342
DEFINE lydia=[PATH TO WHERE CLONED CS 342 DIRECTORY]\cs342\project
4. Run @create
5. Exit sqlplus
6. Login in as the created user.  In this case, login as Lydia/pass.
