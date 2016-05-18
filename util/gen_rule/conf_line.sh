#! /bin/bash
psql -U postgres -d $1 << 'EOF'
CREATE LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION assign_line_level() RETURNS void AS $$
DECLARE rec_row planet_osm_line%ROWTYPE;
DECLARE l0 CURSOR FOR SELECT * FROM planet_osm_line where "addr:interpolation" is not null;
DECLARE l1 CURSOR FOR SELECT * FROM planet_osm_line where "natural" = 'tree_row';
DECLARE l2 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'platform';
DECLARE l3 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'turntable';
DECLARE l4 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'platform';
DECLARE l5 CURSOR FOR SELECT * FROM planet_osm_line where power = 'minor_line';
DECLARE l6 CURSOR FOR SELECT * FROM planet_osm_line where barrier is not null;
DECLARE l7 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'tram' and service in ('spur', 'siding', 'yard');
DECLARE l8 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'disused';
DECLARE l9 CURSOR FOR SELECT * FROM planet_osm_line where man_made = 'embankment';
DECLARE l10 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'miniature';
DECLARE l11 CURSOR FOR SELECT * FROM planet_osm_line where historic = 'citywalls';
DECLARE l12 CURSOR FOR SELECT * FROM planet_osm_line where man_made = 'cutline';
DECLARE l13 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'monorail';
DECLARE l14 CURSOR FOR SELECT * FROM planet_osm_line where power = 'line';
DECLARE l15 CURSOR FOR SELECT * FROM planet_osm_line where waterway IN ('river', 'canal', 'derelict_canal', 'stream', 'drain', 'ditch', 'wadi') AND bridge IN ('yes', 'aqueduct');
DECLARE l16 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'cycleway' or ( highway='path' and bicycle = 'designated');
DECLARE l17 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'service';
DECLARE l18 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'footway' or (highway = 'path' and bicycle != 'designated' and horse != 'designated');
DECLARE l19 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'path' and bicycle is null and horse is null;
DECLARE l20 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'preserved';
DECLARE l21 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'track';
DECLARE l22 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'rail' and service in ('spur', 'siding', 'yard');
DECLARE l23 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'construction';
DECLARE l24 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'pedestrian';
DECLARE l25 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'living_street';
DECLARE l26 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'steps';
DECLARE l27 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'bridleway' or (highway = 'path' and horse = 'designated');
DECLARE l28 CURSOR FOR SELECT * FROM planet_osm_line where waterway = 'stream' or waterway = 'ditch' or waterway = 'drain';
DECLARE l29 CURSOR FOR SELECT * FROM planet_osm_line where waterway = 'wadi' and (bridge is null or bridge not in ('yes', 'aqueduct'));
DECLARE l30 CURSOR FOR SELECT * FROM planet_osm_line where "natural" = 'cliff';
DECLARE l31 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'bus_guideway' and (tunnel is null or tunnel != 'yes');
DECLARE l32 CURSOR FOR SELECT * FROM planet_osm_line where boundary = 'administrative' and (admin_level = '9' or admin_level = '10');
DECLARE l33 CURSOR FOR SELECT * FROM planet_osm_line where waterway = 'dam' or  waterway = 'weir' or waterway = 'lock_gate';
DECLARE l34 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'path';
DECLARE l35 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'tram';
DECLARE l36 CURSOR FOR SELECT * FROM planet_osm_line where man_made = 'pier' or man_made = 'breakwater' or man_made = 'groyne';
DECLARE l37 CURSOR FOR SELECT * FROM planet_osm_line where aerialway = 'cable_car' or aerialway = 'gondola';
DECLARE l38 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'construction';
DECLARE l39 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'raceway';
DECLARE l40 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'subway';
DECLARE l41 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'preserved';
DECLARE l42 CURSOR FOR SELECT * FROM planet_osm_line where aerialway = 'goods';
DECLARE l43 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'preserved' and service in ('spur', 'siding', 'yard');
DECLARE l44 CURSOR FOR SELECT * FROM planet_osm_line where aerialway = 'chair_lift' or aerialway = 'drag_lift' or aerialway = 't-bar' or aerialway = 'j-bar' or aerialway = 'platter' or aerialway = 'rope_tow';
DECLARE l45 CURSOR FOR SELECT * FROM planet_osm_line where waterway = 'canal'  and (bridge is null or bridge not in ('yes', 'aqueduct'));
DECLARE l46 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'unclassified';
DECLARE l47 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'residential';
DECLARE l48 CURSOR FOR SELECT * FROM planet_osm_line where boundary = 'administrative' and (admin_level = '7' or admin_level = '8');
DECLARE l49 CURSOR FOR SELECT * FROM planet_osm_line where waterway = 'derelict_canal' and (bridge is null or bridge not in ('yes', 'aqueduct'));
DECLARE l50 CURSOR FOR SELECT * FROM planet_osm_line where aeroway = 'runway';
DECLARE l51 CURSOR FOR SELECT * FROM planet_osm_line where aeroway = 'taxiway';
DECLARE l52 CURSOR FOR SELECT * FROM planet_osm_line where boundary = 'administrative' and (admin_level = '5' or admin_level = '6');
DECLARE l53 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'road';
DECLARE l54 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'tertiary' or highway = 'tertiary_link';
DECLARE l55 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'secondary' or highway = 'secondary_link';
DECLARE l56 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'primary' or highway = 'primary_link';
DECLARE l57 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'light_rail' or railway = 'funicular' or railway = 'narrow_gauge';
DECLARE l58 CURSOR FOR SELECT * FROM planet_osm_line where waterway = 'river';
DECLARE l59 CURSOR FOR SELECT * FROM planet_osm_line where route = 'ferry';
DECLARE l60 CURSOR FOR SELECT * FROM planet_osm_line where railway = 'rail';
DECLARE l61 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'motorway' or highway = 'motorway_link';
DECLARE l62 CURSOR FOR SELECT * FROM planet_osm_line where highway = 'trunk' or highway = 'trunk_link';
DECLARE l63 CURSOR FOR SELECT * FROM planet_osm_line where boundary = 'administrative' and (admin_level = '2' or admin_level = '3');
DECLARE l64 CURSOR FOR SELECT * FROM planet_osm_line where boundary = 'administrative' and admin_level = '4';
BEGIN
OPEN l0;
   LOOP
      FETCH NEXT FROM l0 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l0;
   END LOOP;
CLOSE l0;

OPEN l1;
   LOOP
      FETCH NEXT FROM l1 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l1;
   END LOOP;
CLOSE l1;

OPEN l2;
   LOOP
      FETCH NEXT FROM l2 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l2;
   END LOOP;
CLOSE l2;

OPEN l3;
   LOOP
      FETCH NEXT FROM l3 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l3;
   END LOOP;
CLOSE l3;

OPEN l4;
   LOOP
      FETCH NEXT FROM l4 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l4;
   END LOOP;
CLOSE l4;

OPEN l5;
   LOOP
      FETCH NEXT FROM l5 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l5;
   END LOOP;
CLOSE l5;

OPEN l6;
   LOOP
      FETCH NEXT FROM l6 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l6;
   END LOOP;
CLOSE l6;

OPEN l7;
   LOOP
      FETCH NEXT FROM l7 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l7;
   END LOOP;
CLOSE l7;

OPEN l8;
   LOOP
      FETCH NEXT FROM l8 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l8;
   END LOOP;
CLOSE l8;

OPEN l9;
   LOOP
      FETCH NEXT FROM l9 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l9;
   END LOOP;
CLOSE l9;

OPEN l10;
   LOOP
      FETCH NEXT FROM l10 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l10;
   END LOOP;
CLOSE l10;

OPEN l11;
   LOOP
      FETCH NEXT FROM l11 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l11;
   END LOOP;
CLOSE l11;

OPEN l12;
   LOOP
      FETCH NEXT FROM l12 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l12;
   END LOOP;
CLOSE l12;

OPEN l13;
   LOOP
      FETCH NEXT FROM l13 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l13;
   END LOOP;
CLOSE l13;

OPEN l14;
   LOOP
      FETCH NEXT FROM l14 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l14;
   END LOOP;
CLOSE l14;

OPEN l15;
   LOOP
      FETCH NEXT FROM l15 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l15;
   END LOOP;
CLOSE l15;

OPEN l16;
   LOOP
      FETCH NEXT FROM l16 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l16;
   END LOOP;
CLOSE l16;

OPEN l17;
   LOOP
      FETCH NEXT FROM l17 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l17;
   END LOOP;
CLOSE l17;

OPEN l18;
   LOOP
      FETCH NEXT FROM l18 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l18;
   END LOOP;
CLOSE l18;

OPEN l19;
   LOOP
      FETCH NEXT FROM l19 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l19;
   END LOOP;
CLOSE l19;

OPEN l20;
   LOOP
      FETCH NEXT FROM l20 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l20;
   END LOOP;
CLOSE l20;

OPEN l21;
   LOOP
      FETCH NEXT FROM l21 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l21;
   END LOOP;
CLOSE l21;

OPEN l22;
   LOOP
      FETCH NEXT FROM l22 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l22;
   END LOOP;
CLOSE l22;

OPEN l23;
   LOOP
      FETCH NEXT FROM l23 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l23;
   END LOOP;
CLOSE l23;

OPEN l24;
   LOOP
      FETCH NEXT FROM l24 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l24;
   END LOOP;
CLOSE l24;

OPEN l25;
   LOOP
      FETCH NEXT FROM l25 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l25;
   END LOOP;
CLOSE l25;

OPEN l26;
   LOOP
      FETCH NEXT FROM l26 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l26;
   END LOOP;
CLOSE l26;

OPEN l27;
   LOOP
      FETCH NEXT FROM l27 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l27;
   END LOOP;
CLOSE l27;

OPEN l28;
   LOOP
      FETCH NEXT FROM l28 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l28;
   END LOOP;
CLOSE l28;

OPEN l29;
   LOOP
      FETCH NEXT FROM l29 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l29;
   END LOOP;
CLOSE l29;

OPEN l30;
   LOOP
      FETCH NEXT FROM l30 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l30;
   END LOOP;
CLOSE l30;

OPEN l31;
   LOOP
      FETCH NEXT FROM l31 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l31;
   END LOOP;
CLOSE l31;

OPEN l32;
   LOOP
      FETCH NEXT FROM l32 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l32;
   END LOOP;
CLOSE l32;

OPEN l33;
   LOOP
      FETCH NEXT FROM l33 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l33;
   END LOOP;
CLOSE l33;

OPEN l34;
   LOOP
      FETCH NEXT FROM l34 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l34;
   END LOOP;
CLOSE l34;

OPEN l35;
   LOOP
      FETCH NEXT FROM l35 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l35;
   END LOOP;
CLOSE l35;

OPEN l36;
   LOOP
      FETCH NEXT FROM l36 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l36;
   END LOOP;
CLOSE l36;

OPEN l37;
   LOOP
      FETCH NEXT FROM l37 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l37;
   END LOOP;
CLOSE l37;

OPEN l38;
   LOOP
      FETCH NEXT FROM l38 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l38;
   END LOOP;
CLOSE l38;

OPEN l39;
   LOOP
      FETCH NEXT FROM l39 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l39;
   END LOOP;
CLOSE l39;

OPEN l40;
   LOOP
      FETCH NEXT FROM l40 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l40;
   END LOOP;
CLOSE l40;

OPEN l41;
   LOOP
      FETCH NEXT FROM l41 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l41;
   END LOOP;
CLOSE l41;

OPEN l42;
   LOOP
      FETCH NEXT FROM l42 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l42;
   END LOOP;
CLOSE l42;

OPEN l43;
   LOOP
      FETCH NEXT FROM l43 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l43;
   END LOOP;
CLOSE l43;

OPEN l44;
   LOOP
      FETCH NEXT FROM l44 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l44;
   END LOOP;
CLOSE l44;

OPEN l45;
   LOOP
      FETCH NEXT FROM l45 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l45;
   END LOOP;
CLOSE l45;

OPEN l46;
   LOOP
      FETCH NEXT FROM l46 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l46;
   END LOOP;
CLOSE l46;

OPEN l47;
   LOOP
      FETCH NEXT FROM l47 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l47;
   END LOOP;
CLOSE l47;

OPEN l48;
   LOOP
      FETCH NEXT FROM l48 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l48;
   END LOOP;
CLOSE l48;

OPEN l49;
   LOOP
      FETCH NEXT FROM l49 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l49;
   END LOOP;
CLOSE l49;

OPEN l50;
   LOOP
      FETCH NEXT FROM l50 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 11;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l50;
   END LOOP;
CLOSE l50;

OPEN l51;
   LOOP
      FETCH NEXT FROM l51 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 11;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l51;
   END LOOP;
CLOSE l51;

OPEN l52;
   LOOP
      FETCH NEXT FROM l52 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 11;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l52;
   END LOOP;
CLOSE l52;

OPEN l53;
   LOOP
      FETCH NEXT FROM l53 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l53;
   END LOOP;
CLOSE l53;

OPEN l54;
   LOOP
      FETCH NEXT FROM l54 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l54;
   END LOOP;
CLOSE l54;

OPEN l55;
   LOOP
      FETCH NEXT FROM l55 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 9;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l55;
   END LOOP;
CLOSE l55;

OPEN l56;
   LOOP
      FETCH NEXT FROM l56 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 8;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l56;
   END LOOP;
CLOSE l56;

OPEN l57;
   LOOP
      FETCH NEXT FROM l57 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 8;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l57;
   END LOOP;
CLOSE l57;

OPEN l58;
   LOOP
      FETCH NEXT FROM l58 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 8;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l58;
   END LOOP;
CLOSE l58;

OPEN l59;
   LOOP
      FETCH NEXT FROM l59 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 7;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l59;
   END LOOP;
CLOSE l59;

OPEN l60;
   LOOP
      FETCH NEXT FROM l60 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 7;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l60;
   END LOOP;
CLOSE l60;

OPEN l61;
   LOOP
      FETCH NEXT FROM l61 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 5;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l61;
   END LOOP;
CLOSE l61;

OPEN l62;
   LOOP
      FETCH NEXT FROM l62 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 5;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l62;
   END LOOP;
CLOSE l62;

OPEN l63;
   LOOP
      FETCH NEXT FROM l63 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 4;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l63;
   END LOOP;
CLOSE l63;

OPEN l64;
   LOOP
      FETCH NEXT FROM l64 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 4;
      insert into line_result VALUES (rec_row.*);
      delete from planet_osm_line where current of l64;
   END LOOP;
CLOSE l64;

insert into line_result (select * from planet_osm_line);
END;
$$
language plpgsql;
EOF
