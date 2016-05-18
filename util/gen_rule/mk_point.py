#!/usr/bin/python

import binascii
import sys
import math
import time
import urllib
import os
import subprocess

rulesource=open("./rule_point.txt", "r");
dest = open("./conf_point.sh", "w");
alllines=rulesource.readlines();
rulesource.close();

dest.write("#! /bin/bash\n");
dest.write("psql -U postgres -d $1 << 'EOF'\n");
dest.write("CREATE LANGUAGE plpgsql;\n");
dest.write("CREATE OR REPLACE FUNCTION assign_point_level() RETURNS void AS $$\n");
dest.write("DECLARE rec_row planet_osm_point%ROWTYPE;\n");
number = 0;
for eachline in alllines:
   (level, rule) = map(str, eachline.split(',', 1));
   dest.write("DECLARE l" + str(number) + " CURSOR FOR SELECT * FROM planet_osm_point" + rule.strip('\n') + ';\n');
   number += 1;

dest.write("BEGIN\n");
number = 0;
for eachline in alllines:
   (level, rule) = map(str, eachline.split(',', 1));
   dest.write("OPEN l" + str(number) + ";\n");
   dest.write("   LOOP\n");
   dest.write("      FETCH NEXT FROM l" + str(number) + " into rec_row;\n");
   dest.write("      EXIT WHEN NOT FOUND;\n");
   dest.write("      rec_row.minzoom := " + level + ";\n");
   dest.write("      insert into point_result VALUES (rec_row.*);\n");
   dest.write("      delete from planet_osm_point where current of l" + str(number) + ";\n");
   dest.write("   END LOOP;\n");
   dest.write("   CLOSE l" + str(number) + ";\n");
   dest.write("\n");
   number += 1;
dest.write("insert into point_result (select * from planet_osm_point);\n");
dest.write("END;\n");
dest.write("$$\n");
dest.write("language plpgsql;\n")
dest.write("EOF\n");
