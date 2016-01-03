#!/usr/bin/python

import binascii
import sys
import math
import time

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
    seq=int(s);
    url=':8080/geoserver/osm_ubuntu/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=osm_ubuntu:traffic_beijing&outputFormat=application/json' + '&viewparams=' + 'long1:' + str(long1) +';' + 'lat1:' + str(lat1) + ';' + 'long2:' + str(long2) + ';' + 'lat2:' + str(lat2) + ';' + 'seq:' + str(seq) + ';' + 'minzoom:' + str(int(z)) +' \n';
    sys.stdout.write(url);
    sys.stdout.flush();