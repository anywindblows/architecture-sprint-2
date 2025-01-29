#!/bin/bash

docker compose exec -T shard1 mongosh --port 27030  <<EOF
use somedb;
db.helloDoc.countDocuments();
exit();
EOF

docker compose exec -T shard2 mongosh --port 27040  <<EOF
use somedb;
db.helloDoc.countDocuments();
exit();
EOF
