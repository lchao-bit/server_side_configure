#!/usr/bin/python

import binascii
import sys
import math
import time
import urllib
import os
import subprocess

def num2deg(xtile, ytile, zoom):
  n = 2.0 ** zoom
  lon_deg = xtile / n * 360.0 - 180.0
  lat_rad = math.atan(math.sinh(math.pi * (1 - 2 * ytile / n)))
  lat_deg = math.degrees(lat_rad)
  return (lat_deg, lon_deg)
  
while True:
   (z,x,y) = map(int,sys.stdin.readline().split());
   jsonname='/home/lchao/osm/vector/'+ str(int(z)) + '_' + str(int(x)) + '_' + str(int(y)) + '.json';
   if os.path.exists(jsonname):
      sys.stdout.write('/vector/' + str(int(z)) + '_' + str(int(x)) + '_' + str(int(y)) + '.json' + '\n');
      sys.stdout.flush();
      continue;
   else:
      fx=float(x);
      fy=float(y);
      fz=float(z);
      (lat1, long1)=num2deg(fx,fy,fz);
      (lat2, long2)=num2deg(fx+1,fy+1,fz);
      if (lat1 > 53.4478600000) or (lat2 < 18.2166241180) or (long1 < 73.7090230000) or (long2 > 135.0536590000):
         continue;
      if (lat1 < 40.2108419673093) and (lat2 > 39.7203276628608) and (long1 > 116.035690317589) and (long2 < 116.744768659913):
         geourl='http://localhost:8080/geoserver/osm_ubuntu/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=osm_ubuntu:osm_beijing&outputFormat=application/json' + '&viewparams=' + 'long1:' + str(long1) +';' + 'lat1:' + str(lat1) + ';' + 'long2:' + str(long2) + ';' + 'lat2:' + str(lat2)+ ';' + 'minzoom:' + str(int(z));
         #print geourl;
         #print 'beijing';
         jsontmp = filename='/home/lchao/tmp/'+ str(int(z)) + '_' + str(int(x)) + '_' + str(int(y)) + '.json';
         urllib.urlretrieve(geourl, jsontmp);
         os.system('jq -c \'del(.features[].properties | .[]| select(.==null))\' '+ jsontmp + '> ' + jsonname);
         os.system('rm -f /home/lchao/tmp/*' + ' >> /dev/null 2>&1');
         sys.stdout.write('/vector/' + str(int(z)) + '_' + str(int(x)) + '_' + str(int(y)) + '.json' + '\n');
         sys.stdout.flush();
         continue;
      else:
         args='psql -d osm_outside -U postgres -U postgres -c \'select * from exist_data where z=' + str(z) + ' and ' + 'x=' + str(x) + ' and ' + 'y=' + str(y) + ';\'| wc -l';
         #print args;

         sqlline = subprocess.Popen(args, stdout=subprocess.PIPE, shell=True);
         count = int(sqlline.stdout.read())-4;
         #print count;

         url='http://api.openstreetmap.org/api/0.6/map?bbox=' + str(long1) + ',' + str(lat2) + ',' + str(long2) + ',' + str(lat1);
         #print url;

         if count == 0:
            accessurl = urllib.urlopen(url);
            availchk = accessurl.getcode();
            #print availchk;
            if availchk == 200:
               filename='/home/lchao/tmp/'+ str(int(z)) + '_' + str(int(x)) + '_' + str(int(y)) + '.osm';
               urllib.urlretrieve(url, filename);
               os.system('osm2pgsql --create --slim --cache 1000 --number-processes 2 --hstore --style /home/lchao/osm/openstreetmap-carto/openstreetmap-carto.style -d osm_outside -U postgres -l --multi-geometry ' + filename  + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'alter table planet_osm_line add column minzoom int;\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'alter table planet_osm_point add column minzoom int;\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'alter table planet_osm_polygon add column minzoom int;\'' + ' >> /dev/null 2>&1');
               os.system('sh /home/lchao/osm/assign-line-outside.sh' + ' >> /dev/null 2>&1');
               os.system('sh /home/lchao/osm/assign-point-outside.sh' + ' >> /dev/null 2>&1');
               os.system('sh /home/lchao/osm/assign-polygon-outside.sh' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'insert into osm_line_result (select * from planet_osm_line where osm_id not in (select osm_id from osm_line_result));\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'insert into osm_point_result (select * from planet_osm_point where osm_id not in (select osm_id from osm_point_result));\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'insert into osm_polygon_result (select * from planet_osm_polygon where osm_id not in (select osm_id from osm_polygon_result));\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'insert into osm_roads_result (select * from planet_osm_roads where osm_id not in (select osm_id from osm_roads_result));\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'drop table planet_osm_line;\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'drop table planet_osm_point;\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'drop table planet_osm_polygon;\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'drop table planet_osm_roads;\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'drop table planet_osm_rels;\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'drop table planet_osm_ways;\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'drop table planet_osm_nodes;\'' + ' >> /dev/null 2>&1');
               os.system('psql -d osm_outside -U postgres -c \'insert into exist_data VALUES(' + str(z) +',' + str(x) + ',' + str(y) + ')\'' + ' >> /dev/null 2>&1');
            else:
               continue;
         geourl='http://localhost:8080/geoserver/osm_ubuntu/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=osm_ubuntu:osm_outside&outputFormat=application/json' + '&viewparams=' + 'long1:' + str(long1) +';' + 'lat1:' + str(lat1) + ';' + 'long2:' + str(long2) + ';' + 'lat2:' + str(lat2) + ';' + 'minzoom:' + str(int(z));
         #print geourl;
         jsontmp = filename='/home/lchao/tmp/'+ str(int(z)) + '_' + str(int(x)) + '_' + str(int(y)) + '.json';
         urllib.urlretrieve(geourl, jsontmp);
         os.system('jq -c \'del(.features[].properties | .[]| select(.==null))\' '+ jsontmp + '> ' + jsonname);
         os.system('rm -f /home/lchao/tmp/*' + ' >> /dev/null 2>&1');
         sys.stdout.write('/vector/' + str(int(z)) + '_' + str(int(x)) + '_' + str(int(y)) + '.json' + '\n');
         sys.stdout.flush();
