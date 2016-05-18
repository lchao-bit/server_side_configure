#!/usr/bin/python

import binascii
import sys
import math
import time
import urllib
import os
import subprocess
from sys import argv

def toregion(xtile, ytile, zoom):
   times = zoom - 3;
   for i in range(times):
      if (xtile % 2 == 1):
         xtile = (xtile - 1) / 2;
      else:
         xtile = xtile / 2;
      if (ytile % 2 ==1):
         ytile = (ytile - 1) / 2;
      else:
         ytile = ytile / 2;
   coord = xtile + 8 * ytile;
   return (coord);

def num2deg(xtile, ytile, zoom):
   n = 2.0 ** zoom
   lon_deg = xtile / n * 360.0 - 180.0
   lat_rad = math.atan(math.sinh(math.pi * (1 - 2 * ytile / n)))
   lat_deg = math.degrees(lat_rad)
   return (lat_deg, lon_deg)

scpt, z, x, y = argv;

fx=float(x);
fy=float(y);
fz=float(z);
(lat1, long1)=num2deg(fx,fy,fz);
(lat2, long2)=num2deg(fx+1,fy+1,fz);
coord = toregion(int(x), int(y), int(z));
foreigndb = 'osm_outside_' + str(coord);
url='http://api.openstreetmap.org/api/0.6/map?bbox=' + str(long1) + ',' + str(lat2) + ',' + str(long2) + ',' + str(lat1);
accessurl = urllib.urlopen(url);
availchk = accessurl.getcode();
if availchk == 200:
   tmposmfile='/home/lchao/tmp/'+ str(int(z)) + '_' + str(int(x)) + '_' + str(int(y)) + '.osm';
   try:
      urllib.urlretrieve(url, tmposmfile);
   except:
      sys.exit();
   dbname = str(int(z)) + '_' + str(int(x)) + '_' + str(int(y));
   os.system('createdb -U postgres ' + dbname);
   os.system('psql -U postgres -d ' + dbname + ' -c \'CREATE EXTENSION hstore; CREATE EXTENSION postgis; CREATE EXTENSION postgres_fdw;\'' + ' >> /dev/null 2>&1');
   os.system('osm2pgsql --create --slim --cache 1000 --number-processes 2 --hstore --style /home/lchao/osm/openstreetmap-carto-3d/openstreetmap-carto.style -d osm_outside -U postgres -l -d ' + dbname + ' --multi-geometry ' + tmposmfile + ' >> /dev/null 2>&1');
   os.system('psql -d ' + dbname + ' -U postgres -c \'alter table planet_osm_line add column minzoom integer;\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + dbname + ' -U postgres -c \'alter table planet_osm_point add column minzoom integer;\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + dbname + ' -U postgres -c \'alter table planet_osm_polygon add column minzoom integer;\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + dbname + ' -U postgres -c \'create table line_result as select * from planet_osm_line where 1=2;\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + dbname + ' -U postgres -c \'create table point_result as select * from planet_osm_point where 1=2;\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + dbname + ' -U postgres -c \'create table polygon_result as select * from planet_osm_polygon where 1=2;\'' + ' >> /dev/null 2>&1');
   os.system('/home/lchao/osm/gen_rule/conf_line.sh ' + dbname + ' >> /dev/null 2>&1');
   os.system('/home/lchao/osm/gen_rule/conf_point.sh ' + dbname + ' >> /dev/null 2>&1');
   os.system('/home/lchao/osm/gen_rule/conf_polygon.sh ' + dbname + ' >> /dev/null 2>&1');
   os.system('psql -d ' + dbname + ' -U postgres -c \'select assign_line_level();\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + dbname + ' -U postgres -c \'select assign_point_level();\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + dbname + ' -U postgres -c \'select assign_polygon_level();\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + dbname + ' -U postgres -c \'alter table line_result rename column way to geom;\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + dbname + ' -U postgres -c \'alter table point_result rename column way to geom;\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + dbname + ' -U postgres -c \'alter table polygon_result rename column way to geom;\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \"create server server_' + dbname + ' foreign data wrapper postgres_fdw options(host \'127.0.0.1\', port \'5432\', dbname \'' + dbname + '\');\"' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \"create user mapping for postgres server server_' + dbname + ' options(user \'postgres\', password \'postgres\');\"' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \'create foreign table line_' + dbname + '(osm_id bigint, access text, \"addr:housename\" text, \"addr:housenumber\" text, \"addr:interpolation\" text, admin_level text, aerialway text, aeroway text, amenity text, area text, barrier text, bicycle text, brand text,  bridge text, boundary text, building text, construction text, covered text, culvert text, cutting text, denomination text, disused text, embankment text, foot text, \"generator:source\" text, harbour text, highway text, historic text, horse text, intermittent text, junction text, landuse text, layer text, leisure text, lock text, man_made text, military text, motorcar text, name text, \"natural\" text, office text, oneway text,  operator text, place text, population text, power text, power_source text, public_transport text, railway text, ref text, religion text, route text, service text, shop text, sport text, surface text, toll text, tourism text, \"tower:type\" text, tracktype text, tunnel text, water text, waterway text, wetland text, width text, wood text, z_order integer, way_area real, max_level text, min_level text, height text, level text, room text, stairs text, indoor text, tags hstore, geom geometry(LineString,4326), minzoom integer) server server_' + dbname + ' options (table_name $$line_result$$);\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \'create foreign table point_' + dbname + '(osm_id bigint, access text, \"addr:housename\" text, \"addr:housenumber\" text, \"addr:interpolation\" text,  admin_level text, aerialway text, aeroway text, amenity text, area text, barrier text, bicycle text, brand text, bridge text, boundary text, building text, capital text, construction text, covered text, culvert text, cutting text, denomination text, disused text, ele text, embankment text, foot text, \"generator:source\" text, harbour text, highway text, historic text, horse text, intermittent text, junction text, landuse text, layer text,  leisure text, lock text, man_made text, military text, motorcar text, name text, \"natural\" text, office text, oneway text, operator text, place text, poi text, population text, power text, power_source text,  public_transport text, railway text, ref text, religion text, route text, service text, shop text, sport text, surface text, toll text, tourism text, \"tower:type\" text, tunnel text, water text, waterway text, wetland text, width text, wood text, z_order integer, max_level text, min_level text, height text, level text, room text,  stairs text, indoor text, tags hstore, geom geometry(Point,4326), minzoom integer) server server_' + dbname + ' options (table_name $$point_result$$);\'' + ' >> /dev/null 2>&1'); 
   os.system('psql -d ' + foreigndb + ' -U postgres -c \'create foreign table polygon_' + dbname + '(osm_id bigint, access text, \"addr:housename\" text, \"addr:housenumber\" text, \"addr:interpolation\" text, admin_level text, aerialway text, aeroway text, amenity text, area text, barrier text, bicycle text, brand text, bridge text, boundary text, building text, construction text, covered text, culvert text, cutting text,  denomination text, disused text, embankment text, foot text, \"generator:source\" text, harbour text, highway text, historic text, horse text, intermittent text, junction text, landuse text, layer text, leisure text, lock text, man_made text, military text, motorcar text, name text, \"natural\" text, office text, oneway text,  operator text, place text, population text, power text, power_source text, public_transport text, railway text, ref text, religion text, route text, service text, shop text, sport text, surface text, toll text, tourism text, \"tower:type\" text, tracktype text, tunnel text, water text, waterway text, wetland text, width text, wood text, z_order integer, way_area real, max_level text, min_level text, height text, level text, room text, stairs text, indoor text, tags hstore, geom geometry(Geometry,4326), minzoom integer) server server_' + dbname + ' options (table_name $$polygon_result$$);\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \'insert into planet_osm_line (select * from line_' + dbname + ');\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \'insert into planet_osm_point (select * from point_' + dbname + ');\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \'insert into planet_osm_polygon (select * from polygon_' + dbname + ');\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \'drop foreign table line_' + dbname +';\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \'drop foreign table point_' + dbname +';\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \'drop foreign table polygon_' + dbname +';\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \'drop user mapping for postgres server server_' + dbname + ';\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \'drop server server_' + dbname + ';\'' + ' >> /dev/null 2>&1');
   os.system('psql -d ' + foreigndb + ' -U postgres -c \'insert into exist_data VALUES(' + str(z) +',' + str(x) + ',' + str(y) + ')\'' + ' >> /dev/null 2>&1' + ' >> /dev/null 2>&1');
   os.system('rm -f ' + tmposmfile + ' >> /dev/null 2>&1');
   os.system('dropdb -U postgres ' + dbname + ' >> /dev/null 2>&1');