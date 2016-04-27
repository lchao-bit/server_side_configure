#! /bin/bash

for ((i=1; i<=96; i++));
{
   psql -d osm_beijing -U postgres -c "truncate table traffic_$i;"
}
psql -d osm_beijing -U postgres -c "truncate table traffic_exist;"
