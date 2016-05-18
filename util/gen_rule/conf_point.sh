#! /bin/bash
psql -U postgres -d $1 << 'EOF'
CREATE LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION assign_point_level() RETURNS void AS $$
DECLARE rec_row planet_osm_point%ROWTYPE;
DECLARE l0 CURSOR FOR SELECT * FROM planet_osm_point where highway = 'services';
DECLARE l1 CURSOR FOR SELECT * FROM planet_osm_point where place = 'island';
DECLARE l2 CURSOR FOR SELECT * FROM planet_osm_point where place = 'islet';
DECLARE l3 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'attraction';
DECLARE l4 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'mall';
DECLARE l5 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'bench';
DECLARE l6 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'waste_basket';
DECLARE l7 CURSOR FOR SELECT * FROM planet_osm_point where railway = 'subway_entrance';
DECLARE l8 CURSOR FOR SELECT * FROM planet_osm_point where highway = 'elevator';
DECLARE l9 CURSOR FOR SELECT * FROM planet_osm_point where "addr:housenumber" is not null;
DECLARE l10 CURSOR FOR SELECT * FROM planet_osm_point where "addr:housename" is not null;
DECLARE l11 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'bicycle_parking';
DECLARE l12 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'motorcycle_parking';
DECLARE l13 CURSOR FOR SELECT * FROM planet_osm_point where leisure = 'picnic_table';
DECLARE l14 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'parking';
DECLARE l15 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'car_wash';
DECLARE l16 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'post_office';
DECLARE l17 CURSOR FOR SELECT * FROM planet_osm_point where leisure = 'slipway';
DECLARE l18 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'car_parts';
DECLARE l19 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'travel_agency';
DECLARE l20 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'hifi';
DECLARE l21 CURSOR FOR SELECT * FROM planet_osm_point where leisure = 'miniature_golf';
DECLARE l22 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'car';
DECLARE l23 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'alcohol';
DECLARE l24 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'electronics';
DECLARE l25 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'photo';
DECLARE l26 CURSOR FOR SELECT * FROM planet_osm_point where leisure = 'playground';
DECLARE l27 CURSOR FOR SELECT * FROM planet_osm_point where leisure = 'water_park';
DECLARE l28 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'variety_store';
DECLARE l29 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'stationery';
DECLARE l30 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'bicycle';
DECLARE l31 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'motorcycle';
DECLARE l32 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'gift';
DECLARE l33 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'toys';
DECLARE l34 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'jewelry';
DECLARE l35 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'jewellery';
DECLARE l36 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'shoes';
DECLARE l37 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'mobile_phone';
DECLARE l38 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'optician';
DECLARE l39 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'wine';
DECLARE l40 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'newsagent';
DECLARE l41 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'kiosk';
DECLARE l42 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'musical_instrument';
DECLARE l43 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'hostel';
DECLARE l44 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'furniture';
DECLARE l45 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'hardware';
DECLARE l46 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'photography';
DECLARE l47 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'photo_studio';
DECLARE l48 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'outdoor';
DECLARE l49 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'car_repair';
DECLARE l50 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'dentist';
DECLARE l51 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'pet';
DECLARE l52 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'post_box';
DECLARE l53 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'florist';
DECLARE l54 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'hairdresser';
DECLARE l55 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'garden_centre';
DECLARE l56 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'fishmonger';
DECLARE l57 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'ice_cream';
DECLARE l58 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'farm';
DECLARE l59 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'doityourself';
DECLARE l60 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'laundry';
DECLARE l61 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'dry_cleaning';
DECLARE l62 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'perfumery';
DECLARE l63 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'other';
DECLARE l64 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'greengrocer';
DECLARE l65 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'butcher';
DECLARE l66 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'seafood';
DECLARE l67 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'confectionery';
DECLARE l68 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'computer';
DECLARE l69 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'cosmetics';
DECLARE l70 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'toilets';
DECLARE l71 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'copyshop';
DECLARE l72 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'books';
DECLARE l73 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'fashion';
DECLARE l74 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'convenience';
DECLARE l75 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'bakery';
DECLARE l76 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'beverages';
DECLARE l77 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'emergency_phone';
DECLARE l78 CURSOR FOR SELECT * FROM planet_osm_point where amenity ='veterinary';
DECLARE l79 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'clothes';
DECLARE l80 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'chemist';
DECLARE l81 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'beauty';
DECLARE l82 CURSOR FOR SELECT * FROM planet_osm_point where historic = 'memorial';
DECLARE l83 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'telephone';
DECLARE l84 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'hotel';
DECLARE l85 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'bag';
DECLARE l86 CURSOR FOR SELECT * FROM planet_osm_point where man_made = 'water_tower';
DECLARE l87 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'prison';
DECLARE l88 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'doctors';
DECLARE l89 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'fast_food';
DECLARE l90 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'drinking_water';
DECLARE l91 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'restaurant';
DECLARE l92 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'food_court';
DECLARE l93 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'recycling';
DECLARE l94 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'motel';
DECLARE l95 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'pub';
DECLARE l96 CURSOR FOR SELECT * FROM planet_osm_point where historic = 'wayside_cross';
DECLARE l97 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'biergarten';
DECLARE l98 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'ice_cream';
DECLARE l99 CURSOR FOR SELECT * FROM planet_osm_point where man_made = 'mast';
DECLARE l100 CURSOR FOR SELECT * FROM planet_osm_point where man_made = 'cross';
DECLARE l101 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'pharmacy';
DECLARE l102 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'atm';
DECLARE l103 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'fuel';
DECLARE l104 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'community_centre';
DECLARE l105 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'information';
DECLARE l106 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'embassy';
DECLARE l107 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'guest_house';
DECLARE l108 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'nightclub';
DECLARE l109 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'fountain';
DECLARE l110 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'car_rental';
DECLARE l111 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'chalet';
DECLARE l112 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'cafe';
DECLARE l113 CURSOR FOR SELECT * FROM planet_osm_point where highway = 'traffic_signals';
DECLARE l114 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'taxi';
DECLARE l115 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'bicycle_rental';
DECLARE l116 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'bank';
DECLARE l117 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'bar';
DECLARE l118 CURSOR FOR SELECT * FROM planet_osm_point where waterway = 'dam' or  waterway = 'weir' or waterway = 'lock_gate';
DECLARE l119 CURSOR FOR SELECT * FROM planet_osm_point where historic = 'monument';
DECLARE l120 CURSOR FOR SELECT * FROM planet_osm_point where aeroway = 'helipad';
DECLARE l121 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'department_store';
DECLARE l122 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'picnic_site';
DECLARE l123 CURSOR FOR SELECT * FROM planet_osm_point where historic = 'archaeological_site';
DECLARE l124 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'viewpoint';
DECLARE l125 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'theatre';
DECLARE l126 CURSOR FOR SELECT * FROM planet_osm_point where power = 'pole';
DECLARE l127 CURSOR FOR SELECT * FROM planet_osm_point where shop = 'supermarket';
DECLARE l128 CURSOR FOR SELECT * FROM planet_osm_point where "natural" = 'tree';
DECLARE l129 CURSOR FOR SELECT * FROM planet_osm_point where barrier = 'bollard';
DECLARE l130 CURSOR FOR SELECT * FROM planet_osm_point where barrier = 'block';
DECLARE l131 CURSOR FOR SELECT * FROM planet_osm_point where barrier = 'lift_gate';
DECLARE l132 CURSOR FOR SELECT * FROM planet_osm_point where barrier = 'gate';
DECLARE l133 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'shelter';
DECLARE l134 CURSOR FOR SELECT * FROM planet_osm_point where highway = 'bus_stop';
DECLARE l135 CURSOR FOR SELECT * FROM planet_osm_point where highway = 'mini_roundabout';
DECLARE l136 CURSOR FOR SELECT * FROM planet_osm_point where historic = 'wayside_cross';
DECLARE l137 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'hunting_stand';
DECLARE l138 CURSOR FOR SELECT * FROM planet_osm_point where man_made = 'windmill';
DECLARE l139 CURSOR FOR SELECT * FROM planet_osm_point where man_made = 'cross';
DECLARE l140 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'camp_site';
DECLARE l141 CURSOR FOR SELECT * FROM planet_osm_point where highway = 'ford';
DECLARE l142 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'museum';
DECLARE l143 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'place_of_worship';
DECLARE l144 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'townhall';
DECLARE l145 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'courthouse';
DECLARE l146 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'police';
DECLARE l147 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'clinic';
DECLARE l148 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'caravan_site';
DECLARE l149 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'cinema';
DECLARE l150 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'library';
DECLARE l151 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'bus_station';
DECLARE l152 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'fire_station';
DECLARE l153 CURSOR FOR SELECT * FROM planet_osm_point where highway = 'turning_circle' OR highway = 'turning_loop';
DECLARE l154 CURSOR FOR SELECT * FROM planet_osm_point where amenity = 'hospital';
DECLARE l155 CURSOR FOR SELECT * FROM planet_osm_point where leisure = 'golf_course';
DECLARE l156 CURSOR FOR SELECT * FROM planet_osm_point where man_made = 'lighthouse';
DECLARE l157 CURSOR FOR SELECT * FROM planet_osm_point where "natural" = 'saddle';
DECLARE l158 CURSOR FOR SELECT * FROM planet_osm_point where "natural" = 'cave_entrance';
DECLARE l159 CURSOR FOR SELECT * FROM planet_osm_point where power = 'generator' and ("generator:source" = 'wind' or power_source = 'wind');
DECLARE l160 CURSOR FOR SELECT * FROM planet_osm_point where place = 'hamlet' or place = 'locality' or place = 'neighbourhood' or place = 'isolated_dwelling' or place = 'farm';
DECLARE l161 CURSOR FOR SELECT * FROM planet_osm_point where power = 'tower';
DECLARE l162 CURSOR FOR SELECT * FROM planet_osm_point where man_made = 'tower';
DECLARE l163 CURSOR FOR SELECT * FROM planet_osm_point where "natural" = 'spring';
DECLARE l164 CURSOR FOR SELECT * FROM planet_osm_point where railway = 'level_crossing';
DECLARE l165 CURSOR FOR SELECT * FROM planet_osm_point where junction = 'yes' or highway = 'traffic_signals';
DECLARE l166 CURSOR FOR SELECT * FROM planet_osm_point where tourism = 'alpine_hut';
DECLARE l167 CURSOR FOR SELECT * FROM planet_osm_point where railway = 'halt';
DECLARE l168 CURSOR FOR SELECT * FROM planet_osm_point where aerialway = 'station';
DECLARE l169 CURSOR FOR SELECT * FROM planet_osm_point where railway = 'tram_stop';
DECLARE l170 CURSOR FOR SELECT * FROM planet_osm_point where railway = 'station';
DECLARE l171 CURSOR FOR SELECT * FROM planet_osm_point where place = 'village' or place = 'suburb';
DECLARE l172 CURSOR FOR SELECT * FROM planet_osm_point where "natural" = 'peak' or "natural" = 'volcano';
DECLARE l173 CURSOR FOR SELECT * FROM planet_osm_point where highway = 'motorway_junction';
DECLARE l174 CURSOR FOR SELECT * FROM planet_osm_point where aeroway = 'aerodrome';
DECLARE l175 CURSOR FOR SELECT * FROM planet_osm_point where place = 'town';
DECLARE l176 CURSOR FOR SELECT * FROM planet_osm_point where place = 'city';
BEGIN
OPEN l0;
   LOOP
      FETCH NEXT FROM l0 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l0;
   END LOOP;
   CLOSE l0;

OPEN l1;
   LOOP
      FETCH NEXT FROM l1 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 7;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l1;
   END LOOP;
   CLOSE l1;

OPEN l2;
   LOOP
      FETCH NEXT FROM l2 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l2;
   END LOOP;
   CLOSE l2;

OPEN l3;
   LOOP
      FETCH NEXT FROM l3 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l3;
   END LOOP;
   CLOSE l3;

OPEN l4;
   LOOP
      FETCH NEXT FROM l4 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l4;
   END LOOP;
   CLOSE l4;

OPEN l5;
   LOOP
      FETCH NEXT FROM l5 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 19;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l5;
   END LOOP;
   CLOSE l5;

OPEN l6;
   LOOP
      FETCH NEXT FROM l6 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 19;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l6;
   END LOOP;
   CLOSE l6;

OPEN l7;
   LOOP
      FETCH NEXT FROM l7 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 18;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l7;
   END LOOP;
   CLOSE l7;

OPEN l8;
   LOOP
      FETCH NEXT FROM l8 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 18;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l8;
   END LOOP;
   CLOSE l8;

OPEN l9;
   LOOP
      FETCH NEXT FROM l9 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l9;
   END LOOP;
   CLOSE l9;

OPEN l10;
   LOOP
      FETCH NEXT FROM l10 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l10;
   END LOOP;
   CLOSE l10;

OPEN l11;
   LOOP
      FETCH NEXT FROM l11 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l11;
   END LOOP;
   CLOSE l11;

OPEN l12;
   LOOP
      FETCH NEXT FROM l12 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l12;
   END LOOP;
   CLOSE l12;

OPEN l13;
   LOOP
      FETCH NEXT FROM l13 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l13;
   END LOOP;
   CLOSE l13;

OPEN l14;
   LOOP
      FETCH NEXT FROM l14 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l14;
   END LOOP;
   CLOSE l14;

OPEN l15;
   LOOP
      FETCH NEXT FROM l15 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l15;
   END LOOP;
   CLOSE l15;

OPEN l16;
   LOOP
      FETCH NEXT FROM l16 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l16;
   END LOOP;
   CLOSE l16;

OPEN l17;
   LOOP
      FETCH NEXT FROM l17 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l17;
   END LOOP;
   CLOSE l17;

OPEN l18;
   LOOP
      FETCH NEXT FROM l18 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l18;
   END LOOP;
   CLOSE l18;

OPEN l19;
   LOOP
      FETCH NEXT FROM l19 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l19;
   END LOOP;
   CLOSE l19;

OPEN l20;
   LOOP
      FETCH NEXT FROM l20 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l20;
   END LOOP;
   CLOSE l20;

OPEN l21;
   LOOP
      FETCH NEXT FROM l21 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l21;
   END LOOP;
   CLOSE l21;

OPEN l22;
   LOOP
      FETCH NEXT FROM l22 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l22;
   END LOOP;
   CLOSE l22;

OPEN l23;
   LOOP
      FETCH NEXT FROM l23 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l23;
   END LOOP;
   CLOSE l23;

OPEN l24;
   LOOP
      FETCH NEXT FROM l24 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l24;
   END LOOP;
   CLOSE l24;

OPEN l25;
   LOOP
      FETCH NEXT FROM l25 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l25;
   END LOOP;
   CLOSE l25;

OPEN l26;
   LOOP
      FETCH NEXT FROM l26 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l26;
   END LOOP;
   CLOSE l26;

OPEN l27;
   LOOP
      FETCH NEXT FROM l27 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l27;
   END LOOP;
   CLOSE l27;

OPEN l28;
   LOOP
      FETCH NEXT FROM l28 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l28;
   END LOOP;
   CLOSE l28;

OPEN l29;
   LOOP
      FETCH NEXT FROM l29 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l29;
   END LOOP;
   CLOSE l29;

OPEN l30;
   LOOP
      FETCH NEXT FROM l30 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l30;
   END LOOP;
   CLOSE l30;

OPEN l31;
   LOOP
      FETCH NEXT FROM l31 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l31;
   END LOOP;
   CLOSE l31;

OPEN l32;
   LOOP
      FETCH NEXT FROM l32 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l32;
   END LOOP;
   CLOSE l32;

OPEN l33;
   LOOP
      FETCH NEXT FROM l33 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l33;
   END LOOP;
   CLOSE l33;

OPEN l34;
   LOOP
      FETCH NEXT FROM l34 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l34;
   END LOOP;
   CLOSE l34;

OPEN l35;
   LOOP
      FETCH NEXT FROM l35 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l35;
   END LOOP;
   CLOSE l35;

OPEN l36;
   LOOP
      FETCH NEXT FROM l36 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l36;
   END LOOP;
   CLOSE l36;

OPEN l37;
   LOOP
      FETCH NEXT FROM l37 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l37;
   END LOOP;
   CLOSE l37;

OPEN l38;
   LOOP
      FETCH NEXT FROM l38 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l38;
   END LOOP;
   CLOSE l38;

OPEN l39;
   LOOP
      FETCH NEXT FROM l39 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l39;
   END LOOP;
   CLOSE l39;

OPEN l40;
   LOOP
      FETCH NEXT FROM l40 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l40;
   END LOOP;
   CLOSE l40;

OPEN l41;
   LOOP
      FETCH NEXT FROM l41 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l41;
   END LOOP;
   CLOSE l41;

OPEN l42;
   LOOP
      FETCH NEXT FROM l42 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l42;
   END LOOP;
   CLOSE l42;

OPEN l43;
   LOOP
      FETCH NEXT FROM l43 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l43;
   END LOOP;
   CLOSE l43;

OPEN l44;
   LOOP
      FETCH NEXT FROM l44 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l44;
   END LOOP;
   CLOSE l44;

OPEN l45;
   LOOP
      FETCH NEXT FROM l45 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l45;
   END LOOP;
   CLOSE l45;

OPEN l46;
   LOOP
      FETCH NEXT FROM l46 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l46;
   END LOOP;
   CLOSE l46;

OPEN l47;
   LOOP
      FETCH NEXT FROM l47 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l47;
   END LOOP;
   CLOSE l47;

OPEN l48;
   LOOP
      FETCH NEXT FROM l48 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l48;
   END LOOP;
   CLOSE l48;

OPEN l49;
   LOOP
      FETCH NEXT FROM l49 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l49;
   END LOOP;
   CLOSE l49;

OPEN l50;
   LOOP
      FETCH NEXT FROM l50 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l50;
   END LOOP;
   CLOSE l50;

OPEN l51;
   LOOP
      FETCH NEXT FROM l51 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l51;
   END LOOP;
   CLOSE l51;

OPEN l52;
   LOOP
      FETCH NEXT FROM l52 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l52;
   END LOOP;
   CLOSE l52;

OPEN l53;
   LOOP
      FETCH NEXT FROM l53 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l53;
   END LOOP;
   CLOSE l53;

OPEN l54;
   LOOP
      FETCH NEXT FROM l54 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l54;
   END LOOP;
   CLOSE l54;

OPEN l55;
   LOOP
      FETCH NEXT FROM l55 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l55;
   END LOOP;
   CLOSE l55;

OPEN l56;
   LOOP
      FETCH NEXT FROM l56 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l56;
   END LOOP;
   CLOSE l56;

OPEN l57;
   LOOP
      FETCH NEXT FROM l57 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l57;
   END LOOP;
   CLOSE l57;

OPEN l58;
   LOOP
      FETCH NEXT FROM l58 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l58;
   END LOOP;
   CLOSE l58;

OPEN l59;
   LOOP
      FETCH NEXT FROM l59 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l59;
   END LOOP;
   CLOSE l59;

OPEN l60;
   LOOP
      FETCH NEXT FROM l60 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l60;
   END LOOP;
   CLOSE l60;

OPEN l61;
   LOOP
      FETCH NEXT FROM l61 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l61;
   END LOOP;
   CLOSE l61;

OPEN l62;
   LOOP
      FETCH NEXT FROM l62 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l62;
   END LOOP;
   CLOSE l62;

OPEN l63;
   LOOP
      FETCH NEXT FROM l63 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l63;
   END LOOP;
   CLOSE l63;

OPEN l64;
   LOOP
      FETCH NEXT FROM l64 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l64;
   END LOOP;
   CLOSE l64;

OPEN l65;
   LOOP
      FETCH NEXT FROM l65 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l65;
   END LOOP;
   CLOSE l65;

OPEN l66;
   LOOP
      FETCH NEXT FROM l66 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l66;
   END LOOP;
   CLOSE l66;

OPEN l67;
   LOOP
      FETCH NEXT FROM l67 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l67;
   END LOOP;
   CLOSE l67;

OPEN l68;
   LOOP
      FETCH NEXT FROM l68 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l68;
   END LOOP;
   CLOSE l68;

OPEN l69;
   LOOP
      FETCH NEXT FROM l69 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l69;
   END LOOP;
   CLOSE l69;

OPEN l70;
   LOOP
      FETCH NEXT FROM l70 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l70;
   END LOOP;
   CLOSE l70;

OPEN l71;
   LOOP
      FETCH NEXT FROM l71 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l71;
   END LOOP;
   CLOSE l71;

OPEN l72;
   LOOP
      FETCH NEXT FROM l72 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l72;
   END LOOP;
   CLOSE l72;

OPEN l73;
   LOOP
      FETCH NEXT FROM l73 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l73;
   END LOOP;
   CLOSE l73;

OPEN l74;
   LOOP
      FETCH NEXT FROM l74 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l74;
   END LOOP;
   CLOSE l74;

OPEN l75;
   LOOP
      FETCH NEXT FROM l75 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l75;
   END LOOP;
   CLOSE l75;

OPEN l76;
   LOOP
      FETCH NEXT FROM l76 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l76;
   END LOOP;
   CLOSE l76;

OPEN l77;
   LOOP
      FETCH NEXT FROM l77 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l77;
   END LOOP;
   CLOSE l77;

OPEN l78;
   LOOP
      FETCH NEXT FROM l78 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l78;
   END LOOP;
   CLOSE l78;

OPEN l79;
   LOOP
      FETCH NEXT FROM l79 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l79;
   END LOOP;
   CLOSE l79;

OPEN l80;
   LOOP
      FETCH NEXT FROM l80 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l80;
   END LOOP;
   CLOSE l80;

OPEN l81;
   LOOP
      FETCH NEXT FROM l81 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l81;
   END LOOP;
   CLOSE l81;

OPEN l82;
   LOOP
      FETCH NEXT FROM l82 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l82;
   END LOOP;
   CLOSE l82;

OPEN l83;
   LOOP
      FETCH NEXT FROM l83 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l83;
   END LOOP;
   CLOSE l83;

OPEN l84;
   LOOP
      FETCH NEXT FROM l84 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l84;
   END LOOP;
   CLOSE l84;

OPEN l85;
   LOOP
      FETCH NEXT FROM l85 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l85;
   END LOOP;
   CLOSE l85;

OPEN l86;
   LOOP
      FETCH NEXT FROM l86 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l86;
   END LOOP;
   CLOSE l86;

OPEN l87;
   LOOP
      FETCH NEXT FROM l87 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l87;
   END LOOP;
   CLOSE l87;

OPEN l88;
   LOOP
      FETCH NEXT FROM l88 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l88;
   END LOOP;
   CLOSE l88;

OPEN l89;
   LOOP
      FETCH NEXT FROM l89 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l89;
   END LOOP;
   CLOSE l89;

OPEN l90;
   LOOP
      FETCH NEXT FROM l90 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l90;
   END LOOP;
   CLOSE l90;

OPEN l91;
   LOOP
      FETCH NEXT FROM l91 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l91;
   END LOOP;
   CLOSE l91;

OPEN l92;
   LOOP
      FETCH NEXT FROM l92 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l92;
   END LOOP;
   CLOSE l92;

OPEN l93;
   LOOP
      FETCH NEXT FROM l93 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l93;
   END LOOP;
   CLOSE l93;

OPEN l94;
   LOOP
      FETCH NEXT FROM l94 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l94;
   END LOOP;
   CLOSE l94;

OPEN l95;
   LOOP
      FETCH NEXT FROM l95 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l95;
   END LOOP;
   CLOSE l95;

OPEN l96;
   LOOP
      FETCH NEXT FROM l96 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l96;
   END LOOP;
   CLOSE l96;

OPEN l97;
   LOOP
      FETCH NEXT FROM l97 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l97;
   END LOOP;
   CLOSE l97;

OPEN l98;
   LOOP
      FETCH NEXT FROM l98 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l98;
   END LOOP;
   CLOSE l98;

OPEN l99;
   LOOP
      FETCH NEXT FROM l99 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l99;
   END LOOP;
   CLOSE l99;

OPEN l100;
   LOOP
      FETCH NEXT FROM l100 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l100;
   END LOOP;
   CLOSE l100;

OPEN l101;
   LOOP
      FETCH NEXT FROM l101 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l101;
   END LOOP;
   CLOSE l101;

OPEN l102;
   LOOP
      FETCH NEXT FROM l102 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l102;
   END LOOP;
   CLOSE l102;

OPEN l103;
   LOOP
      FETCH NEXT FROM l103 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l103;
   END LOOP;
   CLOSE l103;

OPEN l104;
   LOOP
      FETCH NEXT FROM l104 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l104;
   END LOOP;
   CLOSE l104;

OPEN l105;
   LOOP
      FETCH NEXT FROM l105 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l105;
   END LOOP;
   CLOSE l105;

OPEN l106;
   LOOP
      FETCH NEXT FROM l106 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l106;
   END LOOP;
   CLOSE l106;

OPEN l107;
   LOOP
      FETCH NEXT FROM l107 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l107;
   END LOOP;
   CLOSE l107;

OPEN l108;
   LOOP
      FETCH NEXT FROM l108 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l108;
   END LOOP;
   CLOSE l108;

OPEN l109;
   LOOP
      FETCH NEXT FROM l109 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l109;
   END LOOP;
   CLOSE l109;

OPEN l110;
   LOOP
      FETCH NEXT FROM l110 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l110;
   END LOOP;
   CLOSE l110;

OPEN l111;
   LOOP
      FETCH NEXT FROM l111 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l111;
   END LOOP;
   CLOSE l111;

OPEN l112;
   LOOP
      FETCH NEXT FROM l112 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l112;
   END LOOP;
   CLOSE l112;

OPEN l113;
   LOOP
      FETCH NEXT FROM l113 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l113;
   END LOOP;
   CLOSE l113;

OPEN l114;
   LOOP
      FETCH NEXT FROM l114 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l114;
   END LOOP;
   CLOSE l114;

OPEN l115;
   LOOP
      FETCH NEXT FROM l115 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l115;
   END LOOP;
   CLOSE l115;

OPEN l116;
   LOOP
      FETCH NEXT FROM l116 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l116;
   END LOOP;
   CLOSE l116;

OPEN l117;
   LOOP
      FETCH NEXT FROM l117 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l117;
   END LOOP;
   CLOSE l117;

OPEN l118;
   LOOP
      FETCH NEXT FROM l118 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l118;
   END LOOP;
   CLOSE l118;

OPEN l119;
   LOOP
      FETCH NEXT FROM l119 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l119;
   END LOOP;
   CLOSE l119;

OPEN l120;
   LOOP
      FETCH NEXT FROM l120 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l120;
   END LOOP;
   CLOSE l120;

OPEN l121;
   LOOP
      FETCH NEXT FROM l121 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l121;
   END LOOP;
   CLOSE l121;

OPEN l122;
   LOOP
      FETCH NEXT FROM l122 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l122;
   END LOOP;
   CLOSE l122;

OPEN l123;
   LOOP
      FETCH NEXT FROM l123 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l123;
   END LOOP;
   CLOSE l123;

OPEN l124;
   LOOP
      FETCH NEXT FROM l124 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l124;
   END LOOP;
   CLOSE l124;

OPEN l125;
   LOOP
      FETCH NEXT FROM l125 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l125;
   END LOOP;
   CLOSE l125;

OPEN l126;
   LOOP
      FETCH NEXT FROM l126 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l126;
   END LOOP;
   CLOSE l126;

OPEN l127;
   LOOP
      FETCH NEXT FROM l127 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l127;
   END LOOP;
   CLOSE l127;

OPEN l128;
   LOOP
      FETCH NEXT FROM l128 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l128;
   END LOOP;
   CLOSE l128;

OPEN l129;
   LOOP
      FETCH NEXT FROM l129 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l129;
   END LOOP;
   CLOSE l129;

OPEN l130;
   LOOP
      FETCH NEXT FROM l130 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l130;
   END LOOP;
   CLOSE l130;

OPEN l131;
   LOOP
      FETCH NEXT FROM l131 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l131;
   END LOOP;
   CLOSE l131;

OPEN l132;
   LOOP
      FETCH NEXT FROM l132 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l132;
   END LOOP;
   CLOSE l132;

OPEN l133;
   LOOP
      FETCH NEXT FROM l133 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l133;
   END LOOP;
   CLOSE l133;

OPEN l134;
   LOOP
      FETCH NEXT FROM l134 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l134;
   END LOOP;
   CLOSE l134;

OPEN l135;
   LOOP
      FETCH NEXT FROM l135 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l135;
   END LOOP;
   CLOSE l135;

OPEN l136;
   LOOP
      FETCH NEXT FROM l136 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l136;
   END LOOP;
   CLOSE l136;

OPEN l137;
   LOOP
      FETCH NEXT FROM l137 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l137;
   END LOOP;
   CLOSE l137;

OPEN l138;
   LOOP
      FETCH NEXT FROM l138 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l138;
   END LOOP;
   CLOSE l138;

OPEN l139;
   LOOP
      FETCH NEXT FROM l139 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l139;
   END LOOP;
   CLOSE l139;

OPEN l140;
   LOOP
      FETCH NEXT FROM l140 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l140;
   END LOOP;
   CLOSE l140;

OPEN l141;
   LOOP
      FETCH NEXT FROM l141 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l141;
   END LOOP;
   CLOSE l141;

OPEN l142;
   LOOP
      FETCH NEXT FROM l142 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l142;
   END LOOP;
   CLOSE l142;

OPEN l143;
   LOOP
      FETCH NEXT FROM l143 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l143;
   END LOOP;
   CLOSE l143;

OPEN l144;
   LOOP
      FETCH NEXT FROM l144 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l144;
   END LOOP;
   CLOSE l144;

OPEN l145;
   LOOP
      FETCH NEXT FROM l145 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l145;
   END LOOP;
   CLOSE l145;

OPEN l146;
   LOOP
      FETCH NEXT FROM l146 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l146;
   END LOOP;
   CLOSE l146;

OPEN l147;
   LOOP
      FETCH NEXT FROM l147 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l147;
   END LOOP;
   CLOSE l147;

OPEN l148;
   LOOP
      FETCH NEXT FROM l148 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l148;
   END LOOP;
   CLOSE l148;

OPEN l149;
   LOOP
      FETCH NEXT FROM l149 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l149;
   END LOOP;
   CLOSE l149;

OPEN l150;
   LOOP
      FETCH NEXT FROM l150 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l150;
   END LOOP;
   CLOSE l150;

OPEN l151;
   LOOP
      FETCH NEXT FROM l151 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l151;
   END LOOP;
   CLOSE l151;

OPEN l152;
   LOOP
      FETCH NEXT FROM l152 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l152;
   END LOOP;
   CLOSE l152;

OPEN l153;
   LOOP
      FETCH NEXT FROM l153 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l153;
   END LOOP;
   CLOSE l153;

OPEN l154;
   LOOP
      FETCH NEXT FROM l154 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l154;
   END LOOP;
   CLOSE l154;

OPEN l155;
   LOOP
      FETCH NEXT FROM l155 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l155;
   END LOOP;
   CLOSE l155;

OPEN l156;
   LOOP
      FETCH NEXT FROM l156 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l156;
   END LOOP;
   CLOSE l156;

OPEN l157;
   LOOP
      FETCH NEXT FROM l157 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l157;
   END LOOP;
   CLOSE l157;

OPEN l158;
   LOOP
      FETCH NEXT FROM l158 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l158;
   END LOOP;
   CLOSE l158;

OPEN l159;
   LOOP
      FETCH NEXT FROM l159 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l159;
   END LOOP;
   CLOSE l159;

OPEN l160;
   LOOP
      FETCH NEXT FROM l160 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l160;
   END LOOP;
   CLOSE l160;

OPEN l161;
   LOOP
      FETCH NEXT FROM l161 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l161;
   END LOOP;
   CLOSE l161;

OPEN l162;
   LOOP
      FETCH NEXT FROM l162 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l162;
   END LOOP;
   CLOSE l162;

OPEN l163;
   LOOP
      FETCH NEXT FROM l163 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l163;
   END LOOP;
   CLOSE l163;

OPEN l164;
   LOOP
      FETCH NEXT FROM l164 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l164;
   END LOOP;
   CLOSE l164;

OPEN l165;
   LOOP
      FETCH NEXT FROM l165 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l165;
   END LOOP;
   CLOSE l165;

OPEN l166;
   LOOP
      FETCH NEXT FROM l166 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l166;
   END LOOP;
   CLOSE l166;

OPEN l167;
   LOOP
      FETCH NEXT FROM l167 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l167;
   END LOOP;
   CLOSE l167;

OPEN l168;
   LOOP
      FETCH NEXT FROM l168 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l168;
   END LOOP;
   CLOSE l168;

OPEN l169;
   LOOP
      FETCH NEXT FROM l169 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l169;
   END LOOP;
   CLOSE l169;

OPEN l170;
   LOOP
      FETCH NEXT FROM l170 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l170;
   END LOOP;
   CLOSE l170;

OPEN l171;
   LOOP
      FETCH NEXT FROM l171 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l171;
   END LOOP;
   CLOSE l171;

OPEN l172;
   LOOP
      FETCH NEXT FROM l172 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 11;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l172;
   END LOOP;
   CLOSE l172;

OPEN l173;
   LOOP
      FETCH NEXT FROM l173 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 11;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l173;
   END LOOP;
   CLOSE l173;

OPEN l174;
   LOOP
      FETCH NEXT FROM l174 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l174;
   END LOOP;
   CLOSE l174;

OPEN l175;
   LOOP
      FETCH NEXT FROM l175 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 9;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l175;
   END LOOP;
   CLOSE l175;

OPEN l176;
   LOOP
      FETCH NEXT FROM l176 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 6;
      insert into point_result VALUES (rec_row.*);
      delete from planet_osm_point where current of l176;
   END LOOP;
   CLOSE l176;

insert into point_result (select * from planet_osm_point);
END;
$$
language plpgsql;
EOF
