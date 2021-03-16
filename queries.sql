explain analyse select places.id,
       count(mypoints.id) as point_count,
       count(distinct mypoints.user_id) as user_count
from places
inner join mypoints
-- ST_DWithin use an index and ST_Distance do not
on ST_DWithin(
    mypoints.geom::geography,
    places.geom::geography,
    2000)
group by places.id
order by count(mypoints.id) desc
limit 10;