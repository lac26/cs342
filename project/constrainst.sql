/* drop constraints (if have) */
ALTER TABLE PersonBook
DROP CONSTRAINT posQuant;

ALTER TABLE LoanBook
DROP CONSTRAINT posLoan;


/* add constraints */

ALTER TABLE PersonBook
ADD CONSTRAINT posQuant 
	CHECK (quant>0);
	
ALTER TABLE LoanBook
ADD CONSTRAINT posLoan
	CHECK (loanWeeks>0);

