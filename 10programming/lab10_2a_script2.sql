 --read in only file(1)

 --read in this file(2)
 select rank from MOvie where id = 238071;

 --update in other file(3)

 --update in this file(4)

 --rank was 8.5, want to subtract two so modify to 6.5 (3)
 update movie set rank = 9.5 where id = 238071;  --this will give the incorrect value because should have first added one then subtracted one
 	--however, the update of +1 in script1 is simply being replaced with the update to subract 2

