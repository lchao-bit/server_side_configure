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
   os.system('psql -U postgres -d ' + dbname + ' -c \'truncate table exist_data;\'');
   os.system('psql -U postgres -d ' + dbname + ' -c \'truncate table planet_osm_line;\'');
   os.system('psql -U postgres -d ' + dbname + ' -c \'truncate table planet_osm_point;\'');
   os.system('psql -U postgres -d ' + dbname + ' -c \'truncate table planet_osm_polygon;\'');


