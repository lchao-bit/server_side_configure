#!/usr/bin/python

import binascii
import sys
import math
import time
import urllib
import os
import subprocess



for i in range(64):
   dbname = 'osm_outside_' + str(i);
   os.system('createdb -U postgres ' + dbname);
   os.system('psql -U postgres -d ' + dbname + ' -c \'CREATE EXTENSION hstore; CREATE EXTENSION postgis; CREATE EXTENSION postgres_fdw;\'');
   os.system('psql -d ' + dbname + ' -U postgres -c \'CREATE TABLE planet_osm_line (osm_id bigint, access text, \"addr:housename\" text, \"addr:housenumber\" text,  \"addr:interpolation\" text, admin_level text, aerialway text, aeroway text, amenity text, area text, barrier text, bicycle text, brand text, bridge text, boundary text, building text, construction text, covered text, culvert text, cutting text, denomination text, disused text, embankment text, foot text, \"generator:source\" text, harbour text, highway text, historic text, horse text, intermittent text, junction text, landuse text, layer text, leisure text, lock text, man_made text, military text, motorcar text, name text, \"natural\" text, office text, oneway text, operator text, place text, population text, power text, power_source text, public_transport text, railway text, ref text, religion text, route text, service text, shop text, sport text, surface text, toll text, tourism text, \"tower:type\" text, tracktype text, tunnel text, water text, waterway text, wetland text, width text, wood text, z_order integer, way_area real, max_level text, min_level text, height text, level text, room text, stairs text, indoor text, tags hstore, geom geometry(LineString,4326), minzoom integer);\'');
   os.system('psql -d ' + dbname + ' -U postgres -c \'CREATE TABLE planet_osm_point(osm_id bigint, access text,  \"addr:housename\" text, \"addr:housenumber\" text, \"addr:interpolation\" text, admin_level text, aerialway text, aeroway text, amenity text, area text, barrier text, bicycle text, brand text, bridge text, boundary text,  building text, capital text, construction text, covered text, culvert text, cutting text, denomination text,  disused text, ele text, embankment text, foot text, \"generator:source\" text, harbour text, highway text,  historic text, horse text, intermittent text, junction text, landuse text, layer text, leisure text, lock text,  man_made text, military text, motorcar text, name text, \"natural\" text, office text, oneway text, operator text, place text, poi text, population text, power text, power_source text, public_transport text, railway text, ref text, religion text, route text, service text, shop text, sport text, surface text, toll text, tourism text,  \"tower:type\" text, tunnel text, water text, waterway text, wetland text, width text, wood text, z_order integer, max_level text, min_level text, height text, level text, room text, stairs text, indoor text, tags hstore, geom geometry(Point,4326), minzoom integer);\'');
   os.system('psql -d ' + dbname + ' -U postgres -c \'CREATE TABLE planet_osm_polygon(osm_id bigint, access text, \"addr:housename\" text, \"addr:housenumber\" text, \"addr:interpolation\" text, admin_level text,  aerialway text, aeroway text, amenity text, area text, barrier text, bicycle text, brand text, bridge text,  boundary text, building text, construction text, covered text, culvert text, cutting text, denomination text,  disused text, embankment text, foot text, \"generator:source\" text, harbour text, highway text, historic text,   horse text, intermittent text, junction text, landuse text, layer text, leisure text, lock text, man_made text,   military text, motorcar text, name text, \"natural\" text, office text, oneway text, operator text, place text,  population text, power text, power_source text, public_transport text, railway text, ref text, religion text,  route text, service text, shop text, sport text, surface text, toll text, tourism text, \"tower:type\" text,   tracktype text, tunnel text, water text, waterway text, wetland text, width text, wood text, z_order integer,   way_area real, max_level text, min_level text, height text, level text, room text, stairs text, indoor text,   tags hstore, geom geometry(Geometry,4326), minzoom integer);\'');
   os.system('psql -d ' + dbname + ' -U postgres -c \'CREATE TABLE exist_data(z int, x int, y int);\'');
   #os.system('dropdb -U postgres ' + dbname);



