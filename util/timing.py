#!/usr/bin/python

import binascii
import sys
import math
import time
import urllib
import os
import subprocess
from time import clock
start = time.time();

os.system('psql -d newbj -U postgres -c \'select assign_line_level();\'');
os.system('psql -d newbj -U postgres -c \'select assign_point_level();\'');
os.system('psql -d newbj -U postgres -c \'select assign_polygon_level();\'');

#os.system('sh /home/lchao/osm/timing/assign-line.sh');
#os.system('sh /home/lchao/osm/timing/assign-polygon.sh');
#os.system('sh /home/lchao/osm/timing/assign-point.sh');

finish = time.time();

elapsed = finish-start;
print elapsed;