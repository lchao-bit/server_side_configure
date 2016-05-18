#! /bin/bash
psql -U postgres -d $1 << 'EOF'
CREATE LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION assign_polygon_level() RETURNS void AS $$
DECLARE rec_row planet_osm_polygon%ROWTYPE;
DECLARE l0 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'toilets';
DECLARE l1 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'police';
DECLARE l2 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'bus_station';
DECLARE l3 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'restaurant';
DECLARE l4 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'fuel';
DECLARE l5 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'theatre';
DECLARE l6 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'bench';
DECLARE l7 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'library';
DECLARE l8 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'community_centre';
DECLARE l9 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'fire_station';
DECLARE l10 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'fountain';
DECLARE l11 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'car_wash';
DECLARE l12 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'embassy';
DECLARE l13 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'townhall';
DECLARE l14 CURSOR FOR SELECT * FROM planet_osm_polygon where tourism = 'hotel';
DECLARE l15 CURSOR FOR SELECT * FROM planet_osm_polygon where tourism = 'alpine_hut';
DECLARE l16 CURSOR FOR SELECT * FROM planet_osm_polygon where tourism = 'museum';
DECLARE l17 CURSOR FOR SELECT * FROM planet_osm_polygon where tourism = 'hostel';
DECLARE l18 CURSOR FOR SELECT * FROM planet_osm_polygon where shop = 'car';
DECLARE l19 CURSOR FOR SELECT * FROM planet_osm_polygon where shop = 'convenience';
DECLARE l20 CURSOR FOR SELECT * FROM planet_osm_polygon where shop = 'supermarket';
DECLARE l21 CURSOR FOR SELECT * FROM planet_osm_polygon where shop = 'kiosk';
DECLARE l22 CURSOR FOR SELECT * FROM planet_osm_polygon where shop = 'department_store';
DECLARE l23 CURSOR FOR SELECT * FROM planet_osm_polygon where man_made = 'water_tower';
DECLARE l24 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'post_office';
DECLARE l25 CURSOR FOR SELECT * FROM planet_osm_polygon where "natural" = 'spring';
DECLARE l26 CURSOR FOR SELECT * FROM planet_osm_polygon where historic = 'monument';
DECLARE l27 CURSOR FOR SELECT * FROM planet_osm_polygon where historic = 'archaeological_site';
DECLARE l28 CURSOR FOR SELECT * FROM planet_osm_polygon where historic = 'memorial';
DECLARE l29 CURSOR FOR SELECT * FROM planet_osm_polygon where place = 'island';
DECLARE l30 CURSOR FOR SELECT * FROM planet_osm_polygon where place = 'islet';
DECLARE l31 CURSOR FOR SELECT * FROM planet_osm_polygon where tourism = 'attraction';
DECLARE l32 CURSOR FOR SELECT * FROM planet_osm_polygon where shop = 'mall';
DECLARE l33 CURSOR FOR SELECT * FROM planet_osm_polygon where shop = 'books';
DECLARE l34 CURSOR FOR SELECT * FROM planet_osm_polygon where "addr:housenumber" is not null and building is not null;
DECLARE l35 CURSOR FOR SELECT * FROM planet_osm_polygon where "addr:housename" is not null and building is not null;
DECLARE l36 CURSOR FOR SELECT * FROM planet_osm_polygon where barrier is not null;
DECLARE l37 CURSOR FOR SELECT * FROM planet_osm_polygon where aeroway = 'helipad';
DECLARE l38 CURSOR FOR SELECT * FROM planet_osm_polygon where highway = 'platform' or railway = 'platform';
DECLARE l39 CURSOR FOR SELECT * FROM planet_osm_polygon where leisure = 'miniature_golf';
DECLARE l40 CURSOR FOR SELECT * FROM planet_osm_polygon where highway = 'residential' or highway = 'unclassified' or highway = 'service';
DECLARE l41 CURSOR FOR SELECT * FROM planet_osm_polygon where highway = 'pedestrian' or highway = 'footway' or highway = 'cycleway' or  highway = 'path';
DECLARE l42 CURSOR FOR SELECT * FROM planet_osm_polygon where highway = 'track';
DECLARE l43 CURSOR FOR SELECT * FROM planet_osm_polygon where leisure = 'swimming_pool' or amenity = 'swimming_pool';
DECLARE l44 CURSOR FOR SELECT * FROM planet_osm_polygon where highway = 'living_street';
DECLARE l45 CURSOR FOR SELECT * FROM planet_osm_polygon where leisure = 'marina';
DECLARE l46 CURSOR FOR SELECT * FROM planet_osm_polygon where leisure = 'playground';
DECLARE l47 CURSOR FOR SELECT * FROM planet_osm_polygon where building is not null and  building != 'no';
DECLARE l48 CURSOR FOR SELECT * FROM planet_osm_polygon where waterway = 'dam';
DECLARE l49 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'place_of_worship';
DECLARE l50 CURSOR FOR SELECT * FROM planet_osm_polygon where aeroway = 'taxiway';
DECLARE l51 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'garages';
DECLARE l52 CURSOR FOR SELECT * FROM planet_osm_polygon where power = 'sub_station' or power = 'substation';
DECLARE l53 CURSOR FOR SELECT * FROM planet_osm_polygon where man_made = 'bridge';
DECLARE l54 CURSOR FOR SELECT * FROM planet_osm_polygon where man_made = 'pier' or man_made = 'breakwater' or man_made = 'groyne';
DECLARE l55 CURSOR FOR SELECT * FROM planet_osm_polygon where aeroway = 'runway';
DECLARE l56 CURSOR FOR SELECT * FROM planet_osm_polygon where tourism = 'camp_site' or tourism = 'caravan_site' or tourism = 'picnic_site';
DECLARE l57 CURSOR FOR SELECT * FROM planet_osm_polygon where tourism = 'theme_park' or tourism = 'zoo';
DECLARE l58 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'quarry';
DECLARE l59 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'vineyard';
DECLARE l60 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'orchard';
DECLARE l61 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'cemetery' or amenity = 'grave_yard';
DECLARE l62 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'prison';
DECLARE l63 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'residential';
DECLARE l64 CURSOR FOR SELECT * FROM planet_osm_polygon where leisure = 'park' or leisure = 'recreation_ground';
DECLARE l65 CURSOR FOR SELECT * FROM planet_osm_polygon where leisure = 'golf_course';
DECLARE l66 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'allotments';
DECLARE l67 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'farmyard';
DECLARE l68 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'farm' or landuse = 'farmland' or landuse = 'greenhouse_horticulture';
DECLARE l69 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'meadow' or "natural" = 'grassland' or landuse = 'grass' or landuse = 'recreation_ground' or landuse = 'village_green' or leisure = 'common' or leisure = 'garden';
DECLARE l70 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'retail';
DECLARE l71 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'industrial';
DECLARE l72 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'railway';
DECLARE l73 CURSOR FOR SELECT * FROM planet_osm_polygon where power = 'station' or power = 'generator';
DECLARE l74 CURSOR FOR SELECT * FROM planet_osm_polygon where "natural" = 'heath';
DECLARE l75 CURSOR FOR SELECT * FROM planet_osm_polygon where "natural" = 'scrub';
DECLARE l76 CURSOR FOR SELECT * FROM planet_osm_polygon where wetland = 'bog' or wetland = 'string_bog';
DECLARE l77 CURSOR FOR SELECT * FROM planet_osm_polygon where wetland = 'wet_meadow' or wetland = 'marsh';
DECLARE l78 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'hospital' or amenity = 'university' or amenity = 'college' or amenity = 'school' or amenity = 'kindergarten';
DECLARE l79 CURSOR FOR SELECT * FROM planet_osm_polygon where amenity = 'parking' or amenity = 'bicycle_parking' or amenity = 'motorcycle_parking';
DECLARE l80 CURSOR FOR SELECT * FROM planet_osm_polygon where aeroway = 'apron';
DECLARE l81 CURSOR FOR SELECT * FROM planet_osm_polygon where aeroway = 'aerodrome';
DECLARE l82 CURSOR FOR SELECT * FROM planet_osm_polygon where "natural"='beach';
DECLARE l83 CURSOR FOR SELECT * FROM planet_osm_polygon where highway='services' or highway='rest_area';
DECLARE l84 CURSOR FOR SELECT * FROM planet_osm_polygon where railway='station';
DECLARE l85 CURSOR FOR SELECT * FROM planet_osm_polygon where leisure='sports_centre' or leisure='stadium';
DECLARE l86 CURSOR FOR SELECT * FROM planet_osm_polygon where leisure= 'track';
DECLARE l87 CURSOR FOR SELECT * FROM planet_osm_polygon where leisure='pitch';
DECLARE l88 CURSOR FOR SELECT * FROM planet_osm_polygon where "natural" = 'marsh' or "natural" = 'mud' or "natural"= 'wetland' or "natural"= 'wood' or landuse = 'forest';
DECLARE l89 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'commercial';
DECLARE l90 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'brownfield' or landuse = 'landfill' or landuse = 'construction';
DECLARE l91 CURSOR FOR SELECT * FROM planet_osm_polygon where "natural" = 'bare_rock';
DECLARE l92 CURSOR FOR SELECT * FROM planet_osm_polygon where "natural" = 'scree' or "natural" = 'shingle';
DECLARE l93 CURSOR FOR SELECT * FROM planet_osm_polygon where "natural" = 'sand';
DECLARE l94 CURSOR FOR SELECT * FROM planet_osm_polygon where wetland = 'mud' or wetland = 'tidalflat';
DECLARE l95 CURSOR FOR SELECT * FROM planet_osm_polygon where military = 'danger_area';
DECLARE l96 CURSOR FOR SELECT * FROM planet_osm_polygon where waterway = 'dock' or waterway = 'canal';
DECLARE l97 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'basin';
DECLARE l98 CURSOR FOR SELECT * FROM planet_osm_polygon where wetland = 'swamp';
DECLARE l99 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'forest' or "natural" = 'wood';
DECLARE l100 CURSOR FOR SELECT * FROM planet_osm_polygon where (boundary = 'national_park' or leisure = 'nature_reserve') and building is null;
DECLARE l101 CURSOR FOR SELECT * FROM planet_osm_polygon where landuse = 'military';
DECLARE l102 CURSOR FOR SELECT * FROM planet_osm_polygon where "natural" = 'water' or landuse = 'reservoir' or waterway = 'riverbank';
DECLARE l103 CURSOR FOR SELECT * FROM planet_osm_polygon where "natural" = 'glacier';
BEGIN
OPEN l0;
   LOOP
      FETCH NEXT FROM l0 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l0;
   END LOOP;
   CLOSE l0;

OPEN l1;
   LOOP
      FETCH NEXT FROM l1 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l1;
   END LOOP;
   CLOSE l1;

OPEN l2;
   LOOP
      FETCH NEXT FROM l2 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l2;
   END LOOP;
   CLOSE l2;

OPEN l3;
   LOOP
      FETCH NEXT FROM l3 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l3;
   END LOOP;
   CLOSE l3;

OPEN l4;
   LOOP
      FETCH NEXT FROM l4 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l4;
   END LOOP;
   CLOSE l4;

OPEN l5;
   LOOP
      FETCH NEXT FROM l5 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l5;
   END LOOP;
   CLOSE l5;

OPEN l6;
   LOOP
      FETCH NEXT FROM l6 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 19;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l6;
   END LOOP;
   CLOSE l6;

OPEN l7;
   LOOP
      FETCH NEXT FROM l7 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l7;
   END LOOP;
   CLOSE l7;

OPEN l8;
   LOOP
      FETCH NEXT FROM l8 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l8;
   END LOOP;
   CLOSE l8;

OPEN l9;
   LOOP
      FETCH NEXT FROM l9 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l9;
   END LOOP;
   CLOSE l9;

OPEN l10;
   LOOP
      FETCH NEXT FROM l10 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l10;
   END LOOP;
   CLOSE l10;

OPEN l11;
   LOOP
      FETCH NEXT FROM l11 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l11;
   END LOOP;
   CLOSE l11;

OPEN l12;
   LOOP
      FETCH NEXT FROM l12 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l12;
   END LOOP;
   CLOSE l12;

OPEN l13;
   LOOP
      FETCH NEXT FROM l13 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l13;
   END LOOP;
   CLOSE l13;

OPEN l14;
   LOOP
      FETCH NEXT FROM l14 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l14;
   END LOOP;
   CLOSE l14;

OPEN l15;
   LOOP
      FETCH NEXT FROM l15 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l15;
   END LOOP;
   CLOSE l15;

OPEN l16;
   LOOP
      FETCH NEXT FROM l16 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l16;
   END LOOP;
   CLOSE l16;

OPEN l17;
   LOOP
      FETCH NEXT FROM l17 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l17;
   END LOOP;
   CLOSE l17;

OPEN l18;
   LOOP
      FETCH NEXT FROM l18 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l18;
   END LOOP;
   CLOSE l18;

OPEN l19;
   LOOP
      FETCH NEXT FROM l19 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l19;
   END LOOP;
   CLOSE l19;

OPEN l20;
   LOOP
      FETCH NEXT FROM l20 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l20;
   END LOOP;
   CLOSE l20;

OPEN l21;
   LOOP
      FETCH NEXT FROM l21 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l21;
   END LOOP;
   CLOSE l21;

OPEN l22;
   LOOP
      FETCH NEXT FROM l22 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l22;
   END LOOP;
   CLOSE l22;

OPEN l23;
   LOOP
      FETCH NEXT FROM l23 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l23;
   END LOOP;
   CLOSE l23;

OPEN l24;
   LOOP
      FETCH NEXT FROM l24 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l24;
   END LOOP;
   CLOSE l24;

OPEN l25;
   LOOP
      FETCH NEXT FROM l25 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l25;
   END LOOP;
   CLOSE l25;

OPEN l26;
   LOOP
      FETCH NEXT FROM l26 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l26;
   END LOOP;
   CLOSE l26;

OPEN l27;
   LOOP
      FETCH NEXT FROM l27 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l27;
   END LOOP;
   CLOSE l27;

OPEN l28;
   LOOP
      FETCH NEXT FROM l28 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l28;
   END LOOP;
   CLOSE l28;

OPEN l29;
   LOOP
      FETCH NEXT FROM l29 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 7;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l29;
   END LOOP;
   CLOSE l29;

OPEN l30;
   LOOP
      FETCH NEXT FROM l30 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l30;
   END LOOP;
   CLOSE l30;

OPEN l31;
   LOOP
      FETCH NEXT FROM l31 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l31;
   END LOOP;
   CLOSE l31;

OPEN l32;
   LOOP
      FETCH NEXT FROM l32 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l32;
   END LOOP;
   CLOSE l32;

OPEN l33;
   LOOP
      FETCH NEXT FROM l33 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l33;
   END LOOP;
   CLOSE l33;

OPEN l34;
   LOOP
      FETCH NEXT FROM l34 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l34;
   END LOOP;
   CLOSE l34;

OPEN l35;
   LOOP
      FETCH NEXT FROM l35 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 17;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l35;
   END LOOP;
   CLOSE l35;

OPEN l36;
   LOOP
      FETCH NEXT FROM l36 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l36;
   END LOOP;
   CLOSE l36;

OPEN l37;
   LOOP
      FETCH NEXT FROM l37 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l37;
   END LOOP;
   CLOSE l37;

OPEN l38;
   LOOP
      FETCH NEXT FROM l38 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 16;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l38;
   END LOOP;
   CLOSE l38;

OPEN l39;
   LOOP
      FETCH NEXT FROM l39 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 15;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l39;
   END LOOP;
   CLOSE l39;

OPEN l40;
   LOOP
      FETCH NEXT FROM l40 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l40;
   END LOOP;
   CLOSE l40;

OPEN l41;
   LOOP
      FETCH NEXT FROM l41 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l41;
   END LOOP;
   CLOSE l41;

OPEN l42;
   LOOP
      FETCH NEXT FROM l42 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l42;
   END LOOP;
   CLOSE l42;

OPEN l43;
   LOOP
      FETCH NEXT FROM l43 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l43;
   END LOOP;
   CLOSE l43;

OPEN l44;
   LOOP
      FETCH NEXT FROM l44 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l44;
   END LOOP;
   CLOSE l44;

OPEN l45;
   LOOP
      FETCH NEXT FROM l45 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 14;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l45;
   END LOOP;
   CLOSE l45;

OPEN l46;
   LOOP
      FETCH NEXT FROM l46 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l46;
   END LOOP;
   CLOSE l46;

OPEN l47;
   LOOP
      FETCH NEXT FROM l47 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l47;
   END LOOP;
   CLOSE l47;

OPEN l48;
   LOOP
      FETCH NEXT FROM l48 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l48;
   END LOOP;
   CLOSE l48;

OPEN l49;
   LOOP
      FETCH NEXT FROM l49 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l49;
   END LOOP;
   CLOSE l49;

OPEN l50;
   LOOP
      FETCH NEXT FROM l50 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l50;
   END LOOP;
   CLOSE l50;

OPEN l51;
   LOOP
      FETCH NEXT FROM l51 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l51;
   END LOOP;
   CLOSE l51;

OPEN l52;
   LOOP
      FETCH NEXT FROM l52 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 13;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l52;
   END LOOP;
   CLOSE l52;

OPEN l53;
   LOOP
      FETCH NEXT FROM l53 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l53;
   END LOOP;
   CLOSE l53;

OPEN l54;
   LOOP
      FETCH NEXT FROM l54 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 12;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l54;
   END LOOP;
   CLOSE l54;

OPEN l55;
   LOOP
      FETCH NEXT FROM l55 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 11;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l55;
   END LOOP;
   CLOSE l55;

OPEN l56;
   LOOP
      FETCH NEXT FROM l56 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l56;
   END LOOP;
   CLOSE l56;

OPEN l57;
   LOOP
      FETCH NEXT FROM l57 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l57;
   END LOOP;
   CLOSE l57;

OPEN l58;
   LOOP
      FETCH NEXT FROM l58 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l58;
   END LOOP;
   CLOSE l58;

OPEN l59;
   LOOP
      FETCH NEXT FROM l59 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l59;
   END LOOP;
   CLOSE l59;

OPEN l60;
   LOOP
      FETCH NEXT FROM l60 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l60;
   END LOOP;
   CLOSE l60;

OPEN l61;
   LOOP
      FETCH NEXT FROM l61 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l61;
   END LOOP;
   CLOSE l61;

OPEN l62;
   LOOP
      FETCH NEXT FROM l62 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l62;
   END LOOP;
   CLOSE l62;

OPEN l63;
   LOOP
      FETCH NEXT FROM l63 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l63;
   END LOOP;
   CLOSE l63;

OPEN l64;
   LOOP
      FETCH NEXT FROM l64 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l64;
   END LOOP;
   CLOSE l64;

OPEN l65;
   LOOP
      FETCH NEXT FROM l65 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l65;
   END LOOP;
   CLOSE l65;

OPEN l66;
   LOOP
      FETCH NEXT FROM l66 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l66;
   END LOOP;
   CLOSE l66;

OPEN l67;
   LOOP
      FETCH NEXT FROM l67 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l67;
   END LOOP;
   CLOSE l67;

OPEN l68;
   LOOP
      FETCH NEXT FROM l68 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l68;
   END LOOP;
   CLOSE l68;

OPEN l69;
   LOOP
      FETCH NEXT FROM l69 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l69;
   END LOOP;
   CLOSE l69;

OPEN l70;
   LOOP
      FETCH NEXT FROM l70 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l70;
   END LOOP;
   CLOSE l70;

OPEN l71;
   LOOP
      FETCH NEXT FROM l71 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l71;
   END LOOP;
   CLOSE l71;

OPEN l72;
   LOOP
      FETCH NEXT FROM l72 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l72;
   END LOOP;
   CLOSE l72;

OPEN l73;
   LOOP
      FETCH NEXT FROM l73 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l73;
   END LOOP;
   CLOSE l73;

OPEN l74;
   LOOP
      FETCH NEXT FROM l74 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l74;
   END LOOP;
   CLOSE l74;

OPEN l75;
   LOOP
      FETCH NEXT FROM l75 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l75;
   END LOOP;
   CLOSE l75;

OPEN l76;
   LOOP
      FETCH NEXT FROM l76 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l76;
   END LOOP;
   CLOSE l76;

OPEN l77;
   LOOP
      FETCH NEXT FROM l77 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l77;
   END LOOP;
   CLOSE l77;

OPEN l78;
   LOOP
      FETCH NEXT FROM l78 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l78;
   END LOOP;
   CLOSE l78;

OPEN l79;
   LOOP
      FETCH NEXT FROM l79 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l79;
   END LOOP;
   CLOSE l79;

OPEN l80;
   LOOP
      FETCH NEXT FROM l80 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l80;
   END LOOP;
   CLOSE l80;

OPEN l81;
   LOOP
      FETCH NEXT FROM l81 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l81;
   END LOOP;
   CLOSE l81;

OPEN l82;
   LOOP
      FETCH NEXT FROM l82 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l82;
   END LOOP;
   CLOSE l82;

OPEN l83;
   LOOP
      FETCH NEXT FROM l83 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l83;
   END LOOP;
   CLOSE l83;

OPEN l84;
   LOOP
      FETCH NEXT FROM l84 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l84;
   END LOOP;
   CLOSE l84;

OPEN l85;
   LOOP
      FETCH NEXT FROM l85 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l85;
   END LOOP;
   CLOSE l85;

OPEN l86;
   LOOP
      FETCH NEXT FROM l86 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l86;
   END LOOP;
   CLOSE l86;

OPEN l87;
   LOOP
      FETCH NEXT FROM l87 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l87;
   END LOOP;
   CLOSE l87;

OPEN l88;
   LOOP
      FETCH NEXT FROM l88 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l88;
   END LOOP;
   CLOSE l88;

OPEN l89;
   LOOP
      FETCH NEXT FROM l89 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l89;
   END LOOP;
   CLOSE l89;

OPEN l90;
   LOOP
      FETCH NEXT FROM l90 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 10;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l90;
   END LOOP;
   CLOSE l90;

OPEN l91;
   LOOP
      FETCH NEXT FROM l91 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 9;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l91;
   END LOOP;
   CLOSE l91;

OPEN l92;
   LOOP
      FETCH NEXT FROM l92 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 9;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l92;
   END LOOP;
   CLOSE l92;

OPEN l93;
   LOOP
      FETCH NEXT FROM l93 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 9;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l93;
   END LOOP;
   CLOSE l93;

OPEN l94;
   LOOP
      FETCH NEXT FROM l94 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 9;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l94;
   END LOOP;
   CLOSE l94;

OPEN l95;
   LOOP
      FETCH NEXT FROM l95 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 9;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l95;
   END LOOP;
   CLOSE l95;

OPEN l96;
   LOOP
      FETCH NEXT FROM l96 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 9;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l96;
   END LOOP;
   CLOSE l96;

OPEN l97;
   LOOP
      FETCH NEXT FROM l97 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 7;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l97;
   END LOOP;
   CLOSE l97;

OPEN l98;
   LOOP
      FETCH NEXT FROM l98 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 8;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l98;
   END LOOP;
   CLOSE l98;

OPEN l99;
   LOOP
      FETCH NEXT FROM l99 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 8;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l99;
   END LOOP;
   CLOSE l99;

OPEN l100;
   LOOP
      FETCH NEXT FROM l100 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 7;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l100;
   END LOOP;
   CLOSE l100;

OPEN l101;
   LOOP
      FETCH NEXT FROM l101 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 7;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l101;
   END LOOP;
   CLOSE l101;

OPEN l102;
   LOOP
      FETCH NEXT FROM l102 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 6;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l102;
   END LOOP;
   CLOSE l102;

OPEN l103;
   LOOP
      FETCH NEXT FROM l103 into rec_row;
      EXIT WHEN NOT FOUND;
      rec_row.minzoom := 6;
      insert into polygon_result VALUES (rec_row.*);
      delete from planet_osm_polygon where current of l103;
   END LOOP;
   CLOSE l103;

insert into polygon_result (select * from planet_osm_polygon);
END;
$$
language plpgsql;
EOF
