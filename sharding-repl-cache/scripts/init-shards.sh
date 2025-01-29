#!/bin/bash

docker compose exec -T shard1 mongosh --port 27030  <<EOF
rs.initiate(
  {
    _id : "shard1",
    members: [
      { _id : 0, host : "shard1:27030" },
      { _id : 1, host : "shard1_replica1:27031" },
      { _id : 2, host : "shard1_replica2:27032" }
    ]
  }
);
exit();
EOF

docker compose exec -T shard2 mongosh --port 27040  <<EOF
rs.initiate(
  {
    _id : "shard2",
    members: [
      { _id : 0, host : "shard2:27040" },
      { _id : 1, host : "shard2_replica1:27041" },
      { _id : 2, host : "shard2_replica2:27042" }
    ]
  }
);
exit();
EOF
