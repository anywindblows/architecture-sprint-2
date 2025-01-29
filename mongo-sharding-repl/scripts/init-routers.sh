#!/bin/bash

docker compose exec -T router1 mongosh --port 27020 <<EOF
sh.addShard( "shard1/shard1:27030");
sh.addShard( "shard1/shard1_replica1:27031");
sh.addShard( "shard1/shard1_replica2:27032");
sh.addShard( "shard2/shard2:27040");
sh.addShard( "shard2/shard2_replica1:27041");
sh.addShard( "shard2/shard2_replica2:27042");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )
EOF

docker compose exec -T router2 mongosh --port 27021 <<EOF
sh.addShard( "shard1/shard1:27030");
sh.addShard( "shard1/shard1_replica1:27031");
sh.addShard( "shard1/shard1_replica2:27032");
sh.addShard( "shard2/shard2:27040");
sh.addShard( "shard2/shard2_replica1:27041");
sh.addShard( "shard2/shard2_replica2:27042");

sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } )
EOF

docker compose exec -T router1 mongosh --port 27020 <<EOF
use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i})
db.helloDoc.countDocuments()
exit();
EOF

docker compose exec -T router2 mongosh --port 27021 <<EOF
use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i})
db.helloDoc.countDocuments()
exit();
EOF
