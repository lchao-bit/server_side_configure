#! /bin/bash

#http://www.openstreetmap.org/api/0.6/way/16266682/history

psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'primary', minzoom = '8' where osm_id in ('33617091', '35878490', '35878491', '35878494', '175598142');"
psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'primary_link', minzoom = '8' where osm_id in ('33617094', '114076957', '121907192', '165634590');"

psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'motorway', minzoom = '5' where osm_id = '205501259';"
psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'motorway_link', minzoom = '5' where osm_id in ('30186676', '51269765', '120495415');"


psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'trunk', minzoom = '5' where osm_id in ('26679308', '176590507', '187814129', '196117049');"
psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'trunk_link', minzoom = '5' where osm_id in ('103256002', '104638474', '106996384', '106996980', '106996982', '106996985', '106996998', '120521085', '128949625', '150541843', '150589180', '150589500', '152637075', '162652089', '173389715', '193048072', '193048073', '193048074', '193048075', '213651846', '213651847', '213651848', '224839727');"

psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'secondary', minzoom = '9' where osm_id in ('22801744', '34104202', '42412592', '58867970', '58867971', '119980739', '159783238', '159794829', '162982998', '172814029', '187211817', '229705697', '186874296', '186874285');"
psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'secondary_link', minzoom = '9' where osm_id in ('103143703', '103143719', '172878280');"

psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'tertiary', minzoom = '10' where osm_id in ('16266682', '25109400', '27032732', '29179599', '30243135', '34104213', '35878500', '39116258', '42746882', '47501596', '47693438', '58867969', '59217037', '60110814', '60500064', '60500551', '84381703', '104131024', '121977756', '152292478', '154526689', '156346949', '159791638', '161455982', '161701278', '161701309', '165174637', '165628738', '165628849', '169123341', '169123343', '169445701', '170628896', '176441244', '209743741', '210697447', '213274458', '213274459', '213274465', '217178242', '217178245', '42412830');"
psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'tertiary_link', minzoom = '10' where osm_id in ('104637464', '104637469', '146586688', '169612166');"

psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'service', minzoom = '13' where osm_id in ('30766016', '30802770', '30802771', '33657948', '46031443', '57885679', '81813448', '161811129', '164587497', '164587507', '186862119', '186951601', '191693438', '206372062', '34104208', '30765989', '30765947');"

psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'unclassified', minzoom = '12' where osm_id in ('23892321', '29309205', '42673859', '72630933', '106617477', '129622316', '173019254', '191693437', '191693439');"

psql -d osm_beijing -U postgres -c "update beijing_traffic set highway = 'residential', minzoom = '12' where osm_id in ('24476339', '24476375', '24825396', '26812221', '35028275', '38354319', '42398763', '42454658', '50633884', '55887590', '59167938', '59174442', '59174490', '59174512', '59174549', '59188995', '59198112', '59198117', '59198148', '59198241', '59210872', '59210876', '60110790', '60495825', '107948696', '134699928', '136512010', '149226242', '149226251', '155577041', '174937157', '175425323', '188239402', '191049868', '216637033', '229774173');"

