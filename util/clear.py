#!/usr/bin/python

import binascii
import sys
import math
import time
import urllib
import os
import subprocess

os.system('rm -f /home/lchao/osm/vector/*');
os.system('rm -f /home/lchao/osm/image/*');
os.system('rm -rf /var/cache/apache2/mod_cache_disk/*');
os.system('rm -f /home/ug/osm/log');