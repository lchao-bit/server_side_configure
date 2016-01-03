#!/usr/bin/python

import binascii
import sys
import math
import time
import urllib
import os
import subprocess
while True:
   (z,x,y) = map(int,sys.stdin.readline().split());
   pngname='/home/lchao/osm/image/'+ str(int(z)) + '_' + str(int(x)) + '_' + str(int(y)) + '.png';
   if not os.path.exists(pngname):
      imgurl='http://a.tile.openstreetmap.org/' + str(z) + '/' + str(x) + '/' + str(y) +'.png';
      urllib.urlretrieve(imgurl, pngname);
   sys.stdout.write('/image/' + str(int(z)) + '_' + str(int(x)) + '_' + str(int(y)) + '.png' + '\n');
   sys.stdout.flush();