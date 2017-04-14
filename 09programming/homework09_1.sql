--Get the movies directed by Clint Eastwood.

select *
from movie m, moviedirector md, director d
where m.id = md.movieId 
and md.directorid = d.id
and d.firstName = 'Clint'
and d.lastName = 'Eastwood';

select d.firstName || ' , ' || d.lastName, count(*)
from director d, moviedirector md
where md.directorid = d.id
group by d.id, d.firstName, d.lastName
having count(*) > 200;

select a.id, a.firstName, a.lastName
from Actor a, Role r, Movie m
where a.id = r.actorId
and r.movieId = m.id
and (select count(*) from movie where r.movieid = m.id) > 10
group by a.id, a.firstName, a.lastName
having avg(m.rank) > 8.5;