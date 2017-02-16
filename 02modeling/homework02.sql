-- Drop current database
DROP TABLE SHIPMENT;
DROP TABLE WAREHOUSE;
DROP TABLE ORDER_ITEM;
DROP TABLE ITEM;
DROP TABLE CUSTOMER_ORDER;
DROP TABLE CUSTOMER_INFO;



CREATE TABLE CUSTOMER_INFO (
    ID INTEGER NOT NULL,
    CustName VARCHAR (50),
    CustCity VARCHAR (30),
    PRIMARY KEY (ID)
);

-- OrderAmt is dollar amount of order
-- ON DELETE SET NULL, even if the customer no longer exists still want to have the history of orders
CREATE TABLE CUSTOMER_ORDER (
    ID INTEGER NOT NULL, 
    CustID INTEGER, 
    OrderDate DATE NOT NULL,
    OrdAmt Decimal(12,2),
    PRIMARY KEY (ID),
    FOREIGN KEY (CustID) REFERENCES CUSTOMER_INFO(ID) ON DELETE SET NULL 
);

-- UnitPrice maximum 12 digits to left, 2 to right to specify price
CREATE TABLE ITEM(
    ID INTEGER NOT NULL, 
    Name VARCHAR (50),
    UnitPrice Decimal(12,2), 
    PRIMARY KEY (ID),
    CHECK (UnitPrice >= 0.00)
);

-- ItemID assume one order cannot have multiple entries with the same number (though would not need to because there is a qty field for order_item so can be primary key
-- OrderID because this is part of PK cannot be NULL.  Also, if item no longer exists would not know what the quantity belongs to so makes more sense to delete so DELETE CASCADE
-- OrderID because this is part of PK can not be NULL.  Also, if Order does not exist should not have record of order item so DELETE CASCADE
CREATE  TABLE ORDER_ITEM (
    ItemID INTEGER NOT NULL,
    OrderID INTEGER NOT NULL, 
    OrderQty INTEGER,
    PRIMARY KEY (ItemID, OrderID), 
    FOREIGN KEY (ItemID) REFERENCES ITEM(ID) ON DELETE CASCADE, 
    FOREIGN KEY (OrderID) REFERENCES CUSTOMER_ORDER(ID) ON DELETE CASCADE  
);


CREATE TABLE WAREHOUSE(
    ID INTEGER NOT NULL, 
    WareCity VARCHAR (30),
    PRIMARY KEY (ID)
);



-- PK assume will not have 2 identical orders from same warehouse
-- WareID, If delete order will not need to ship it so can delete from shipment so DELETE CASCADE
-- OrderID, if deleted order do not need record of it so DELETE CASCADE
-- check condition assuming company founded in 1970
CREATE TABLE SHIPMENT(
    OrderID INTEGER NOT NULL, 
    WareID INTEGER NOT NULL, 
    ShipDate DATE,
    PRIMARY KEY (WareID, OrderID), 
    FOREIGN KEY (WareID) REFERENCES WAREHOUSE(ID) ON DELETE CASCADE , 
    FOREIGN KEY (OrderID) REFERENCES CUSTOMER_ORDER(ID) ON DELETE CASCADE,  
    check(ShipDate > '01-Jan-1970') 
);


INSERT INTO CUSTOMER_INFO VALUES (1, 'Stentehower', 'Grand Haven');
INSERT INTO CUSTOMER_INFO VALUES (2, 'Paige', 'Germany');
INSERT INTO CUSTOMER_INFO VALUES (3, 'Lydia', 'Istanbul');
INSERT INTO CUSTOMER_INFO VALUES (4, 'Customer', 'Somewhere');



INSERT INTO ITEM VALUES (1, 'Hair Brush', 10.0);
INSERT INTO ITEM VALUES (2, 'Antique Tooth Brush', 5.0);
INSERT INTO ITEM VALUES (3, 'Ornate Shampoo Bottle', 40.0);
INSERT INTO ITEM VALUES (4, 'Happy-Go-Lucky Deoderant', 15.0);



INSERT INTO WAREHOUSE VALUES (1, 'Grand Rapids');
INSERT INTO WAREHOUSE VALUES (2, 'Detroit');
INSERT INTO WAREHOUSE VALUES (3, 'New York');


--orderID, customer, date, dollar amount of order
INSERT INTO CUSTOMER_ORDER VALUES (1, 2, sysdate, 120.00); 
INSERT INTO CUSTOMER_ORDER VALUES (2, 2, '01-FEB-2017', 30.00); 
INSERT INTO CUSTOMER_ORDER VALUES (3, 1, sysdate, 20.00); 
INSERT INTO CUSTOMER_ORDER VALUES (4, 4, sysdate, 10.0);


--itemID, CUSTOMER_ORDER, OrderQty
INSERT INTO ORDER_ITEM VALUES (1,1,1);
INSERT INTO ORDER_ITEM VALUES (2, 1, 3);
INSERT INTO ORDER_ITEM VALUES (4, 2, 2);
INSERT INTO  ORDER_ITEM VALUES (4, 3, 1);
INSERT INTO  ORDER_ITEM VALUES (2, 3, 1);
INSERT INTO ORDER_ITEM VALUES (1, 4, 1);


--CustOrderID, WareID, ShipDate
INSERT INTO SHIPMENT VALUES (1, 3, '15-Jan-2018');
INSERT INTO SHIPMENT VALUES (2, 3, '01-May-2017');
INSERT INTO SHIPMENT VALUES (3, 1, '01-Mar-2017');

/* 3 */

/* a */
SELECT CUSTOMER_INFO.CustName, CUSTOMER_ORDER.OrderDate, CUSTOMER_ORDER.OrdAmt
FROM CUSTOMER_ORDER
INNER JOIN CUSTOMER_INFO
ON CUSTOMER_INFO.CustName LIKE 'Paige' WHERE CUSTOMER_INFO.ID = CUSTOMER_ORDER.CustID
ORDER BY CUSTOMER_ORDER.OrderDate;

/* b */
SELECT UNIQUE CUSTOMER_ORDER.CustID
FROM CUSTOMER_ORDER
INNER JOIN ORDER_ITEM
ON ORDER_ITEM.OrderID = CUSTOMER_ORDER.ID;

/* c */
SELECT CUSTOMER_INFO.CustName, CUSTOMER_INFO.ID
FROM CUSTOMER_INFO
INNER JOIN CUSTOMER_ORDER ON CUSTOMER_ORDER.CustID = CUSTOMER_INFO.ID
INNER JOIN ORDER_ITEM ON ORDER_ITEM.OrderID = CUSTOMER_ORDER.ID
INNER JOIN ITEM ON ORDER_ITEM.ITemID = ITEM.ID
WHERE ITEM.name LIKE 'Happy-Go-Lucky Deoderant';


