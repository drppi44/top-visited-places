--1) create users table and fill it
create table users(
    id serial primary key
);

insert into users (id)
select generate_series(1, 100);


--2) create mypoints table and fill it
create table mypoints (
    id serial,
    geom geometry(Point, 4326),
    user_id int references users(id),
    datetime timestamp);


insert into mypoints (geom, user_id, datetime)
select ST_GeomFromText('POINT(' || (random()*360-180)::varchar || ' ' ||  (random()*180-90)::varchar || ')', 4326),
       trunc(random() * 100) + 1,
       NOW() - (random() * (NOW()+'90 days' - NOW()))
from generate_series(1,10*1000*1000);

CREATE INDEX mypoints_geography_index ON mypoints USING GIST (( geom::geography ));


--2) create mypoints table and fill it
create table places (
    id serial,
    geom geometry(Point, 4326));
CREATE INDEX places_geography_index ON places USING GIST (( geom::geography ));

create table places (
    id serial,
    geom geometry(Point, 4326));
CREATE INDEX places_geography_index ON places USING GIST (( geom::geography ));

insert into places(geom)
select ST_GeomFromText('POINT(' || (random()*360-180)::varchar || ' ' ||  (random()*180-90)::varchar || ')', 4326)
from generate_series(1, 1*1000);

CLUSTER mypoints USING mypoints_geography_index;
CLUSTER places USING places_geography_index;