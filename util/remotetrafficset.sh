#! /bin/bash

#for ((i=1; i<=96; i++));
#{
   #psql -d osm_beijing -U postgres -c "alter table allroad_time_nonrush_$i add column seq integer;"
   #psql -d osm_beijing -U postgres -c "update allroad_time_nonrush_$i set seq = $i;"
#}

#for ((i=2; i<=96; i++))
#{
   #psql -d osm_beijing -U postgres -c "insert into allroad_time_nonrush_1 select * from allroad_time_nonrush_$i;"
#   psql -d osm_beijing -U postgres -c "drop table allroad_time_nonrush_$i;"
#}

#for ((i=1; i<=96; i++))
#{
#psql -d osm_beijing -U postgres -c "update allroad_time_nonrush set highway = planet_osm_line.highway, minzoom = planet_osm_line.minzoom from #planet_osm_line where allroad_time_nonrush.osm_id = planet_osm_line.osm_id and allroad_time_nonrush.seq=$i;"
#}

for ((i=1; i<=96; i++))
{
   #psql -d osm_beijing -U postgres -c "drop foreign table traffic_info_$i;"
   #psql -d osm_beijing -U postgres -c "create foreign table traffic_info_$i(gid integer, next_gid integer, reference bigint, \"time\" double precision, average_speed double precision, class_id integer, name text, length double precision, to_cost double precision, reverse_cost double precision) server server_remote options (table_name 'allroad_time_nonrush_$i');"
   #psql -d osm_beijing -U postgres -c "create table traffic_$i(gid integer, average_speed double precision, name text, geom geometry(LineString,4326), osm_id bigint, highway text, minzoom integer);"
}

#create foreign table ways_reference (gid integer, class_id integer NOT NULL, length double precision, name text, x1 double precision, y1 double precision, x2 double precision, y2 double precision, reverse_cost double precision, rule text, to_cost double precision, maxspeed_forward integer, maxspeed_backward integer, osm_id bigint, priority double precision DEFAULT 1, the_geom geometry(LineString,4326), source integer, target integer) server zhangyu options (table_name 'oneway_test');




#select count(*) from (select a.gid, a.average_speed, a.name, b.the_geom, b.osm_id from traffic_info_1 a, ways_reference b where a.gid = b.gid) as num;

#select count(*) from (select a.gid, a.average_speed, a.name, b.the_geom as geom, b.osm_id, c.highway, c.minzoom from traffic_info_1 a, ways_reference b, planet_osm_line c where a.gid = b.gid and b.osm_id = c.osm_id and ST_Intersects(ST_GeometryFromText('POLYGON(($long1 $lat1,$long2 $lat1,$long2 $lat2, $long1 $lat2, $long1 $lat1))',4326),geom) is true and c.minzoom <= $minzoom) as num;



