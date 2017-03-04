-- Load the Centrepointe church database. 
-- See ../README.md for details.

-- Drop the previous table declarations.
@&lydia\drop         
commit;
-- Reload the table declarations.
@&lydia\schema
commit;
-- Load the table data.
@&lydia\data
commit;