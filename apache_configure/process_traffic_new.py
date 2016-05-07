#!/usr/bin/python

#create extension postgres_fdw;
#create server zhangyu foreign data wrapper postgres_fdw options(host '192.168.2.120', port '5432', dbname 'taxi_data');
#create user mapping for postgres server zhangyu options(user 'postgres', password 'p@ssw0rd');




import binascii
import sys
import math
import time
import os
import subprocess

def num2deg(xtile, ytile, zoom):
  n = 2.0 ** zoom
  lon_deg = xtile / n * 360.0 - 180.0
  lat_rad = math.atan(math.sinh(math.pi * (1 - 2 * ytile / n)))
  lat_deg = math.degrees(lat_rad)
  return (lat_deg, lon_deg)
  
while True:
    (z,x,y,s) = map(float,sys.stdin.readline().split());
    (lat1, long1)=num2deg(x,y,z);
    (lat2, long2)=num2deg(x+1,y+1,z);
    seq=str(int(s));
    minzoom = str(int(z));
    slong1 = str(long1);
    slong2 = str(long2);
    slat1 = str(lat1);
    slat2 = str(lat2);
    if 1 <= int(s) and int(s) <= 96:
        args='psql -d osm_beijing -U postgres -c \'select * from traffic_exist where z=' + str(int(z)) + ' and ' + 'x=' + str(int(x)) + ' and ' + 'y=' + str(int(y)) + 'and ' + 'seq=' + seq + ';\'| wc -l';
        sqlline = subprocess.Popen(args, stdout=subprocess.PIPE, shell=True);
        count = int(sqlline.stdout.read())-4;
        if count == 0:
            os.system('psql -d osm_beijing -U postgres -c \'insert into traffic_exist VALUES(' + str(z) +',' + str(x) + ',' + str(y) + ',' + str(seq) + ')\'' + ' >> /dev/null 2>&1');
            pcomm = 'psql -d osm_beijing -U postgres -c "insert into traffic_' + seq + ' ' + 'select a.gid, a.average_speed, a.name, b.the_geom as geom, b.osm_id, c.highway, c.minzoom from traffic_info_' + seq + ' '  +'a, ways_reference b, planet_osm_line c where a.gid = b.gid and b.osm_id = c.osm_id and ST_Intersects(ST_GeometryFromText(\'POLYGON((' + slong1 + ' ' + slat1 + ',' + slong2 + ' ' + slat1 + ',' + slong2 + ' ' + slat2 + ',' + slong1 + ' ' + slat2 + ',' + slong1 + ' ' + slat1 +'))\',4326),the_geom) is true and c.minzoom <=' + minzoom + ' ' + ';"' + ' >> /dev/null 2>&1';
            os.system(pcomm);
        url=':8080/geoserver/osm_ubuntu/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=osm_ubuntu:traffic_beijing&outputFormat=application/json' + '&viewparams=' + 'long1:' + str(long1) +';' + 'lat1:' + str(lat1) + ';' + 'long2:' + str(long2) + ';' + 'lat2:' + str(lat2) + ';' + 'seq:' + seq + ';' + 'minzoom:' + minzoom +' \n';
        sys.stdout.write(url);
        sys.stdout.flush();
    else:
         sys.stdout.write('/void/void.json' + '\n');
         sys.stdout.flush();