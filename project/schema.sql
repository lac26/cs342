-- This command file loads an experimental person relation.
-- The data conforms to the following assumptions:
--     * Person IDs and team IDs are unique for people and teams respectively.
--     * People can have at most one mentor.
--     * People can be on many teams, but only have one role per team.
--     * Teams meet at only one time.
--
-- CS 342
-- Spring, 2017
-- kvlinden

drop table PersonGroupBookPayment;
drop table Payment;
drop table PersonGroup;
drop table ShareGroup;
drop table Collection;
drop table Book;
drop table Person;

CREATE TABLE Person (
	ID integer PRIMARY KEY,
	firstName varchar(20),
	lastName varchar(20),
	userName varchar(20),
	password varchar(20),
	bpoints integer
	);
	
	/* could make sep. type & cond. table to limit values */
CREATE TABLE Book(
	ID integer PRIMARY KEY,
	author varchar (30),
	title varchar (40),
	edition integer,
	condition varchar (20),
	ownerID integer,
	Foreign Key (ownerID) REFERENCES Person(ID) ON DELETE CASCADE
);

CREATE TABLE Collection(
	ID integer PRIMARY KEY,
	name varchar (60)
);

CREATE TABLE BookCollection(
	bookID integer,
	collectionID integer,
	Primary Key (bookID, collectionID),
	Foreign Key (bookID) REFERENCES Book(ID) ON DELETE CASCADE,
	Foreign Key (collectionID) REFERENCES Collection(ID) ON DELETE CASCADE	
);

CREATE TABLE ShareGroup(
	ID integer PRIMARY KEY,
	name varchar (60)	
);

CREATE TABLE CollectionGroup(
	collectionID integer,
	groupID integer,
	Primay key(collectoinID, groupID),
	Foreign Key (collectionID) REFERENCES Collection(ID) ON DELETE CASCADE,
	Foreign Key (groupID) REFERENCES ShareGroup(ID) ON DELETE CASCADE
);

Create TABLE PersonGroup (
	personID integer,
	groupID integer,
	Primary Key (personID, groupID),
	Foreign Key (personID) REFERENCES Person(ID) ON DELETE CASCADE,
	Foreign Key (groupID) REFERENCES ShareGroup(ID) ON DELETE CASCADE
);




CREATE SEQUENCE seq_person START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_book START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_coll START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_group START WITH 1 INCREMENT BY 1;

INSERT INTO Person VALUES (seq_person.nextval, 'Paige', 'Brinks', 'pBrinks', 'pbpbpb', 20);
INSERT INTO Person VALUES (seq_person.nextval, 'Andrew', 'Groenenewold', 'gWold', 'gggg', 10);
INSERT INTO Person VALUES (seq_person.nextval, 'Mufutau','Pruitt', 'mfPruitt', 'cpcpcpc', 40);
INSERT INTO Person VALUES (seq_person.nextval, 'Violet','Harris', 'harrisV', '044ioya',70);
INSERT INTO Person VALUES (seq_person.nextval, 'Patience','Decker', 'decker_patience', '067qtwf',55);
INSERT INTO Person VALUES (seq_person.nextval, 'Maya','Tyler', 'MayaTaya', '911jtcq',41);
INSERT INTO Person VALUES (seq_person.nextval, 'Noel','Branch', 'NoelNOEL', '618ibpm',36);
INSERT INTO Person VALUES (seq_person.nextval, 'Ivory','Merritt', 'IvoryMtt', '863lwec',10);
INSERT INTO Person VALUES (seq_person.nextval, 'Claire','Rosario', 'bestUserEver', '279dgoz',1);
INSERT INTO Person VALUES (seq_person.nextval, 'Elvis','Larson', 'ELarson','193uogk',68);
INSERT INTO Person VALUES (seq_person.nextval, 'Lane','Cohen', 'LCohen', '406iucj',31 );
INSERT INTO Person VALUES (seq_person.nextval, 'Walker','Gay', 'Walked', '659ofre',42);
INSERT INTO Person VALUES (seq_person.nextval, 'Solomon','Kent', 'Solomon', '242qabg',18);

INSERT INTO Book VALUES (seq_book.nextval,'Daniel Foster','Nullam',3,'awful',1);
INSERT INTO Book VALUES (seq_book.nextval, 'Kaitlin Stafford','enim mi tempor lorem,',3,'good',1);
INSERT INTO Book VALUES (seq_book.nextval, 'Candice Haynes','Curabitur',6,'awful',1);
INSERT INTO Book VALUES (seq_book.nextval, 'Jermaine Mills','ultrices',7,'good',2);
INSERT INTO Book VALUES (seq_book.nextval,'Oren Williamson','erat. Etiam vestibulum massa',9,'good',5);
INSERT INTO Book VALUES (seq_book.nextval,'Anjolie Cash','eu metus. In lorem.',4,'good',13);
INSERT INTO Book VALUES (seq_book.nextval,'Murphy Alvarez','arcu. Vestibulum ut',1,'good',12);
INSERT INTO Book VALUES (seq_book.nextval,'Uriel Cardenas','ridiculus mus. Proin',2,'excellent',11);
INSERT INTO Book VALUES (seq_book.nextval,'Uriel Cardenas','ridiculus mus. Proin',2,'excellent',10);
INSERT INTO Book VALUES (seq_book.nextval,'Derek Hoffman','lorem semper',5,'excellent', 9);
INSERT INTO Book VALUES (seq_book.nextval,'Adena Christian','scelerisque neque. Nullam',10,'excellent', 11);
INSERT INTO Book VALUES (seq_book.nextval,'Louis Black','ac orci. Ut semper pretium',7,'good', 8);
INSERT INTO Book VALUES (seq_book.nextval,'Quinn Young','a, scelerisque',4,'poor', 3);
INSERT INTO Book VALUES (seq_book.nextval,'Audra Roberts','sit',3,'decent', 3);

INSERT INTO Collection VALUES (seq_coll.nextvat, 'school books');
INSERT INTO Collection VALUES (seq_coll.nextvat, 'summer reads');
INSERT INTO Collection VALUES (seq_coll.nextvat, 'computer science collection');
INSERT INTO Collection VALUES (seq_coll.nextvat, 'german books');
INSERT INTO Collection VALUES (seq_coll.nextvat, 'turksih novels');
INSERT INTO Collection VALUES (seq_coll.nextvat, 'cookbooks');
INSERT INTO Collection VALUES (seq_coll.nextvat, 'books for nieces');
INSERT INTO Collection VALUES (seq_coll.nextvat, 'travel books');
INSERT INTO Collection VALUES (seq_coll.nextvat, 'professional development collection')

INSERT INTO BookCollection VALUES (1, 1);
INSERT INTO BookCollection VALUES (2, 1);
INSERT INTO BookCollection VALUES (5, 1);
INSERT INTO BookCollection VALUES (7, 1);
INSERT INTO BookCollection VALUES (10, 1);
INSERT INTO BookCollection VALUES (1, 2);
INSERT INTO BookCollection VALUES (4, 2);
INSERT INTO BookCollection VALUES (5, 2);
INSERT INTO BookCollection VALUES (8, 2);
INSERT INTO BookCollection VALUES (9, 2);
INSERT INTO BookCollection VALUES (1, 3);
INSERT INTO BookCollection VALUES (2, 3);
INSERT INTO BookCollection VALUES (7, 4);
INSERT INTO BookCollection VALUES (7, 5);
INSERT INTO BookCollection VALUES (9, 5);

INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Michigan Homeschoolers Unite');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Calvin CS Students');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Cupery Family');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Women in Computing Mentorship Books');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Broene Book Share');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'RA Resource');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Turkish Language Swap');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'German Language Swap');













