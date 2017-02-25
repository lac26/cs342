drop table Purchase_Part;
drop table Part;
drop table Purchase;
drop table Employee;
drop table Customer;

create table Customer(
	customerID integer PRIMARY KEY,
	firstName varchar(30),
	lastName varchar(30),
	zipcode integer
	);
	
create table Employee(
	employeeID integer PRIMARY KEY,
	firstName varchar(30),
	lastName varchar(30),
	zipcode char(5)
	);
	
create table Purchase(
	orderID integer PRIMARY KEY,
	receiptDate DATE,
	shipDate DATE,
	employeeID integer,
	customerID integer,
	Foreign Key (employeeID) REFERENCES Employee(employeeID) ON DELETE SET NULL,
	Foreign Key (customerID) REFERENCES Customer(customerID) ON DELETE CASCADE
	);
	
create table Part(
	partID integer PRIMARY KEY,
	totalQuant integer,
	name varchar(30),
	price Decimal(12,2)
);

create table Purchase_Part(
	partID integer,
	orderID integer,
	quant integer,
	Primary Key (partID, orderID),
	Foreign Key (partID) REFERENCES Part(partID) ON DELETE CASCADE,
	Foreign Key (orderID) REFERENCES Purchase(orderID) ON DELETE CASCADE	
);

INSERT INTO Employee VALUES (1, 'Joel', 'Steitethower', 49546);
INSERT INTO Employee VALUES (2, 'Paige', 'Brinks', 49600);
INSERT INTO Employee VALUES (3, 'Beka', 'Agava', 99870);

INSERT INTO Customer VALUES (1, 'Ali', 'Ozturk', 49546);
INSERT INTO Customer VALUES (2, 'Seyma', 'Yildirim', 49999);
INSERT INTO Customer VALUES (3, 'Sezen', 'Akinci', 45988);

INSERT INTO Purchase VALUES (1, '01-Mar-2015', '05-Mar-2015', 1, 1);
INSERT INTO Purchase VALUES (2, '05-Mar-2015', '10-Mar-2015', 2, 1);

INSERT INTO Part VALUES (1, 10000, 'antique toothbrush', 10.00);
INSERT INTO Part VALUES (2, 10, 'feelClean shampoo', 25.00);
INSERT INTO Part VALUES (3, 100, 'happy-go-lucky deoderant', 10.00);

INSERT INTO Purchase_Part VALUES (1, 1, 100);
INSERT INTO Purchase_Part VALUES (3, 2, 3);






