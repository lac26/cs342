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
INSERT INTO Person VALUES (seq_person.nextval,'Cade','Irwin','OEKRLSAOXL','LRS16YUA8AD',50);
INSERT INTO Person VALUES (seq_person.nextval,'Steel','Weaver','FYYUFNYMIX','MMJ92WVR7LR',20);

INSERT INTO Person VALUES (seq_person.nextval,'Tucker','Davenport','RBBANXEBTB','HLS98EZY9PS',31);
INSERT INTO Person VALUES (seq_person.nextval,'Bradley','Arnold','HYCAOJMAYB','JCS11TXF6MZ',16);
INSERT INTO Person VALUES (seq_person.nextval,'Moses','Boone','HQSSORPGUF','FFR73ARD8OA',6);
INSERT INTO Person VALUES (seq_person.nextval,'Austin','Gamble','MTYYOEBCSB','YIQ66DCB9CI',50);
INSERT INTO Person VALUES (seq_person.nextval,'Hillary','Bruce','RUKRAHENTB','BUD06BTI1GB',47);

INSERT INTO Person  VALUES (seq_person.nextval,'Wanda','Welch','FUHLTGQNEU','BID73XTS9QB',9);
INSERT INTO Person  VALUES (seq_person.nextval,'Madeline','Cline','MMURDEDLXA','NAF02XIF4WU',30);
INSERT INTO Person  VALUES (seq_person.nextval,'Grant','Mcclure','WGZGMNIXDT','XRT64LKS7ZC',33);
INSERT INTO Person  VALUES (seq_person.nextval,'Kimberly','Patterson','KKKZYFEMRN','AOF83ARN2GS',12);
INSERT INTO Person VALUES (seq_person.nextval,'Erin','Simon','UDVEZGLAPS','JWY22GCE3UK',15);

INSERT INTO Person VALUES (seq_person.nextval,'Heather','Abbott','KXMMTGAQEM','RZS88BLH5KQ',12);


INSERT INTO Condition VALUES ('awful', 'hardly readable');
INSERT INTO Condition VALUES ('poor', 'can easily read but has stains/marks etc.');
INSERT INTO Condition VALUES ('mediocore', 'in good condition, may have some highlights, underlines, and a little wera and tear');
INSERT INTO Condition VALUES ('good', 'in good condition with only either a few marks a little bit of wear');
INSERT INTO Condition VALUES ('excellent', 'good condition, hardly any wear');

INSERT INTO Condition VALUES ('like new', 'like you would purshase it at the store');

--CS textbooks
INSERT INTO Book VALUES (seq_book.nextval,'Thomas H. Cormen','Introduction to Algorithms,',2,'awful');
INSERT INTO Book VALUES (seq_book.nextval,'Harold Abelson','Structure and Interpretation of Computer Programs ',1,'good');
INSERT INTO Book VALUES (seq_book.nextval,'Joy Silva','The C Programming Language',2,'awful');
INSERT INTO Book VALUES (seq_book.nextval,'Goodrich and Tamassia','Algorithm Design: Foundations, Analysis, and Internet Examples',7,'good');
INSERT INTO Book VALUES (seq_book.nextval,'Sebasta','Concepts of Programming Languages',10,'good');

--turkish books
INSERT INTO Book VALUES (seq_book.nextval,'Yasar Kemal','Ince Memed',NULL,'awful');
INSERT INTO Book VALUES (seq_book.nextval,'Oguz Atay','Tutunamayanlar',NULL,'good');
INSERT INTO Book VALUES (seq_book.nextval,'Ahmet Hamdi Tanpınar','Saatleri Ayarlama Enstitüsü',NULL,'excellent');
INSERT INTO Book VALUES (seq_book.nextval,'Nazim Hikmet','Memleketimden İnsan Manzaraları',NULL,'awful');
INSERT INTO Book VALUES (seq_book.nextval,'Sabahattin Ali','Kürk Mantolu Madonna',NULL,'good');

--German books
INSERT INTO Book VALUES (seq_book.nextval,'Thomas Lange, Claude Theil','Die Händlerin der Worte',NULL,'excellent');
INSERT INTO Book VALUES (seq_book.nextval,'Susanne Shmidt','Merjem',NULL,'mediocore');
INSERT INTO Book VALUES (seq_book.nextval,'Stefanie Höfler','Der Tanz der Tiefseequalle',7,'awful');
INSERT INTO Book VALUES (seq_book.nextval,'Herbert Heckmann','Benjamin und seine Väter',4,'good');
INSERT INTO Book VALUES (seq_book.nextval,'Jonas Lüschern','Kraft',2,'awful');

--novels
INSERT INTO Book VALUES (seq_book.nextval,' F. Scott Fitzgerald','The Great Gatsby',3,'excellent');
INSERT INTO Book VALUES (seq_book.nextval,'Aldous Huxley','Brave New World',5,'awful');
INSERT INTO Book VALUES (seq_book.nextval,'Ralph Elliot','Invisible Man',1,'good');
INSERT INTO Book VALUES (seq_book.nextval,'Jack Kerouac','On the Road',8,'excellent');
INSERT INTO Book VALUES (seq_book.nextval,'Sinclair Lewis','Main Street',4,'good');

--random examples
INSERT INTO Book VALUES (seq_book.nextval,'Hayden Gibbs','consectetuer, cursus',6,'good');
INSERT INTO Book VALUES (seq_book.nextval,'Carl Collins','auctor, velit',8,'mediocore');
INSERT INTO Book VALUES (seq_book.nextval,'Patrick Sears','aliquet, sem ut cursus',1,'awful');
INSERT INTO Book VALUES (seq_book.nextval,'Skyler Kent','ut aliquam iaculis, lacus pede',1,'poor');
INSERT INTO Book VALUES (seq_book.nextval,'Maile Schwartz','tellus sem mollis',10,'good');





INSERT INTO Collection VALUES (seq_coll.nextval, 'school books');
INSERT INTO Collection VALUES (seq_coll.nextval, 'summer reads');
INSERT INTO Collection VALUES (seq_coll.nextval, 'computer science collection');
INSERT INTO Collection VALUES (seq_coll.nextval, 'german books');
INSERT INTO Collection VALUES (seq_coll.nextval, 'turkish novels');

INSERT INTO Collection VALUES (seq_coll.nextval, 'cookbooks');
INSERT INTO Collection VALUES (seq_coll.nextval, 'books for nieces');
INSERT INTO Collection VALUES (seq_coll.nextval, 'travel books');
INSERT INTO Collection VALUES (seq_coll.nextval, 'professional development collection');
INSERT INTO Collection VALUES (seq_coll.nextval, 'monday night readings');

INSERT INTO Collection VALUES (seq_coll.nextval, 'favorite books');
INSERT INTO Collection VALUES (seq_coll.nextval, 'grand rapids');
INSERT INTO Collection VALUES (seq_coll.nextval, 'bike club');
INSERT INTO Collection VALUES (seq_coll.nextval, 'novels');
INSERT INTO Collection VALUES (seq_coll.nextval, 'short stories');

INSERT INTO Collection VALUES (seq_coll.nextval, 'professional development');
INSERT INTO Collection VALUES (seq_coll.nextval, '1900s collection');
INSERT INTO Collection VALUES (seq_coll.nextval, 'biographies and autobiographies');
INSERT INTO Collection VALUES (seq_coll.nextval, 'harry potter');
INSERT INTO Collection VALUES (seq_coll.nextval, 'health and wellness');

INSERT INTO Collection VALUES (seq_coll.nextval, 'music boooks');
INSERT INTO Collection VALUES (seq_coll.nextval, 'nancy drew');
INSERT INTO Collection VALUES (seq_coll.nextval, 'detective novels');


INSERT INTO BookCollection VALUES (1, 1, 8);
INSERT INTO BookCollection VALUES (2, 1, 10);
INSERT INTO BookCollection VALUES (5, 1, 5);
INSERT INTO BookCollection VALUES (7, 1, 10);
INSERT INTO BookCollection VALUES (10, 1, 20);

INSERT INTO BookCollection VALUES (1, 2, 18);
INSERT INTO BookCollection VALUES (4, 2, 19);
INSERT INTO BookCollection VALUES (5, 2, 13);
INSERT INTO BookCollection VALUES (2, 3, 1);
INSERT INTO BookCollection VALUES (8, 2, 5);
INSERT INTO BookCollection VALUES (9, 2, 4);

INSERT INTO BookCollection VALUES (1, 3, 25);
INSERT INTO BookCollection VALUES (7, 4, 23);
INSERT INTO BookCollection VALUES (7, 5, 24);
INSERT INTO BookCollection VALUES (9, 5, 20);
INSERT INTO BookCollection  VALUES (17,5, 9);


INSERT INTO BookCollection VALUES (1,13, 5);
INSERT INTO BookCollection VALUES (13,18, 8);
INSERT INTO BookCollection VALUES (1,5, 5);
INSERT INTO BookCollection VALUES (1,17, 6);
INSERT INTO BookCollection VALUES (17,10, 12);

INSERT INTO BookCollection VALUES (12,11, 13);
INSERT INTO BookCollection  VALUES (1,4, 3);
INSERT INTO BookCollection  VALUES (5,9, 5);
INSERT INTO BookCollection  VALUES (4,10, 2);
INSERT INTO BookCollection  VALUES (24,13, 3);

INSERT INTO BookCollection  VALUES (22,1, 14);
INSERT INTO BookCollection  VALUES (6,5, 13);
INSERT INTO BookCollection  VALUES (11,1, 7);
INSERT INTO BookCollection  VALUES (6,3, 6);
INSERT INTO BookCollection  VALUES (25,18, 5);

INSERT INTO BookCollection  VALUES (22,5, 11);
INSERT INTO BookCollection  VALUES (24,5, 7);
INSERT INTO BookCollection  VALUES (19,1, 22);
INSERT INTO BookCollection  VALUES (19,5, 20);
INSERT INTO BookCollection  VALUES (1,8, 5);




INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (3,10,6);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (5,10,7);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (2,9,2);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (20,1,9);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (20,8,9);

INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (5,3,2);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (4,3,9);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (18,2,2);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (8,7,7);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (6,6,5);

INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (20,6,4);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (9,7,7);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (4,9,9);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (16,13,8);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (8,3,4);

INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (8,9,10);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (19,5,6);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (12,10,9);
INSERT INTO PersonBook (bookID,ownerID,quant) VALUES (7,13,6);


INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Michigan Homeschoolers Unite');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Calvin CS Students');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Cupery Family');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Women in Computing Mentorship Books');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Broene Book Share');

INSERT INTO ShareGroup VALUES (seq_group.nextval, 'RA Resource');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Turkish Language Swap');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'German Language Swap');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Math deparment swap');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Asia Avenger Book Club');

INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Church Book Club');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Teenagers who love to read');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Illustrators Unite');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'self helpers');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'fashion advice');

INSERT INTO ShareGroup VALUES (seq_group.nextval, 'CALL members');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'Calvin Alums');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'spanish language and literature');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'kalamazoo swap');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'music lovers');

INSERT INTO ShareGroup VALUES (seq_group.nextval, 'theology form');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'evolution readings');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'psychology professionals');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'weekend reads group');
INSERT INTO ShareGroup VALUES (seq_group.nextval, 'medical professionals book swap');

INSERT INTO BookGroup VALUES (3,3);
INSERT INTO BookGroup VALUES (7,7);
INSERT INTO BookGroup VALUES (8,6);
INSERT INTO BookGroup VALUES (14,2);
INSERT INTO BookGroup VALUES (14,3);

INSERT INTO BookGroup VALUES (1,5);
INSERT INTO BookGroup VALUES (4,8);
INSERT INTO BookGroup VALUES (14,4);
INSERT INTO BookGroup VALUES (12,5);
INSERT INTO BookGroup VALUES (11,2);

INSERT INTO BookGroup VALUES (4,7);
INSERT INTO BookGroup VALUES (13,2);
INSERT INTO BookGroup VALUES (7,6);
INSERT INTO BookGroup VALUES (9,6);
INSERT INTO BookGroup VALUES (6,6);

INSERT INTO BookGroup VALUES (1,7);
INSERT INTO BookGroup VALUES (12,2);
INSERT INTO BookGroup VALUES (14,1);
INSERT INTO BookGroup VALUES (2,8);
INSERT INTO BookGroup VALUES (13,5);

INSERT INTO BookGroup VALUES (6,2);
INSERT INTO BookGroup VALUES (9,1);
INSERT INTO BookGroup VALUES (9,7);
INSERT INTO BookGroup VALUES (8,2);


INSERT INTO CollectionGroup VALUES (1,1);
INSERT INTO CollectionGroup VALUES (20,6);
INSERT INTO CollectionGroup VALUES (4,8);
INSERT INTO CollectionGroup VALUES (8, 2);
INSERT INTO CollectionGroup VALUES (3, 4);

INSERT INTO CollectionGroup VALUES (6,1);
INSERT INTO CollectionGroup VALUES (5, 7);
INSERT INTO CollectionGroup VALUES (7,1);
INSERT INTO CollectionGroup VALUES (2,1);
INSERT INTO CollectionGroup VALUES (8,5);

INSERT INTO CollectionGroup (collectionID,groupID) VALUES (7,10);
INSERT INTO CollectionGroup (collectionID,groupID) VALUES (3,2);
INSERT INTO CollectionGroup (collectionID,groupID) VALUES (11,3);
INSERT INTO CollectionGroup (collectionID,groupID) VALUES (3,7);
INSERT INTO CollectionGroup (collectionID,groupID) VALUES (2,12);

INSERT INTO CollectionGroup (collectionID,groupID) VALUES (17,5);
INSERT INTO CollectionGroup (collectionID,groupID) VALUES (1,11);
INSERT INTO CollectionGroup (collectionID,groupID) VALUES (19,16);
INSERT INTO CollectionGroup (collectionID,groupID) VALUES (5,1);
INSERT INTO CollectionGroup (collectionID,groupID) VALUES (5,2);

INSERT INTO CollectionGroup (collectionID,groupID) VALUES (16,7);
INSERT INTO CollectionGroup (collectionID,groupID) VALUES (12,16);
INSERT INTO CollectionGroup (collectionID,groupID) VALUES (4,11);
INSERT INTO CollectionGroup (collectionID,groupID) VALUES (3,3);
INSERT INTO CollectionGroup (collectionID,groupID) VALUES (5,15);

INSERT INTO CollectionGroup (collectionID,groupID) VALUES (3,15);


INSERT INTO PersonGroup (personID,groupID) VALUES (12,4);
INSERT INTO PersonGroup (personID,groupID) VALUES (5,5);
INSERT INTO PersonGroup (personID,groupID) VALUES (13,5);
INSERT INTO PersonGroup (personID,groupID) VALUES (2,5);
INSERT INTO PersonGroup (personID,groupID) VALUES (2,6);

INSERT INTO PersonGroup (personID,groupID) VALUES (12,6);
INSERT INTO PersonGroup (personID,groupID) VALUES (5,6);
INSERT INTO PersonGroup (personID,groupID) VALUES (7,5);
INSERT INTO PersonGroup (personID,groupID) VALUES (4,6);
INSERT INTO PersonGroup (personID,groupID) VALUES (10,6);

INSERT INTO PersonGroup (personID,groupID) VALUES (6,6);
INSERT INTO PersonGroup (personID,groupID) VALUES (3,6);
INSERT INTO PersonGroup (personID,groupID) VALUES (11,8);
INSERT INTO PersonGroup (personID,groupID) VALUES (9,5);
INSERT INTO PersonGroup (personID,groupID) VALUES (3,8);

INSERT INTO PersonGroup (personID,groupID) VALUES (1,3);
INSERT INTO PersonGroup (personID,groupID) VALUES (13,7);
INSERT INTO PersonGroup (personID,groupID) VALUES (12,7);


INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (1,1,8,'23-MAR-01',19);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (17,8,13,'02-JUN-06',10);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (14,2,9,'22-JUL-06',8);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (14,2,13,'16-OCT-15',7);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (25,12,1,'23-SEP-00',22);

INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (23,1,2,'09-AUG-05',23);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (17,7,7,'12-SEP-14',29);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (5,9,3,'08-JAN-06',14);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (1,13,1,'25-FEB-09',5);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (25,6,1,'12-JAN-05',18);

INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (16,12,8,'03-FEB-11',NULL);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (5,6,4,'19-APR-06',7);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (23,7,2,'17-MAY-02',25);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (20,4,2,'23-MAY-11',10);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (20,11,2,'01-MAY-11',10);

INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (17,8,8,'06-MAY-11',NULL);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (4,13,11,'20-MAY-11',10);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (20,6,12,'21-MAR-17',7);
INSERT INTO LoanBook (bookID,borrowerID,loanerID,loanDate,loanWeeks) VALUES (15,8,1,'24-MAR-17',13);

