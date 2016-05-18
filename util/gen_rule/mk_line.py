#!/usr/bin/python

import binascii
import sys
import math
import time
import urllib
import os
import subprocess

rulesource=open("./rule_line.txt", "r");
dest = open("./conf_line.sh", "w");
alllines=rulesource.readlines();
rulesource.close();

dest.write("#! /bin/bash\n");
dest.write("psql -U postgres -d $1 << 'EOF'\n");
dest.write("CREATE LANGUAGE plpgsql;\n");
dest.write("CREATE OR REPLACE FUNCTION assign_line_level() RETURNS void AS $$\n");
dest.write("DECLARE rec_row planet_osm_line%ROWTYPE;\n");
number = 0;
for eachline in alllines:
   (level, rule) = map(str, eachline.split(',', 1));
   dest.write("DECLARE l" + str(number) + " CURSOR FOR SELECT * FROM planet_osm_line" + rule.strip('\n') + ';\n');
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
   dest.write("      insert into line_result VALUES (rec_row.*);\n");
   dest.write("      delete from planet_osm_line where current of l" + str(number) + ";\n");
   dest.write("   END LOOP;\n");
   dest.write("CLOSE l" + str(number) + ";\n");
   dest.write("\n");
   number += 1;
dest.write("insert into line_result (select * from planet_osm_line);\n");
dest.write("END;\n");
dest.write("$$\n");
dest.write("language plpgsql;\n")
dest.write("EOF\n");
