#!/bin/bash
for i in `seq 1000 10000`; do
echo $i;
(
curl -X POST http://loadtest.clientsofradical.com:3001/joinPledge --header "Content-Type: application/json" -d '{
    "pledgeID":      1,
    "pledgeType":    "eat",
    "username":      "user'$i'@example.com",
    "socialNetwork": "facebook"
}' 2> /dev/null &
curl -X POST http://loadtest.clientsofradical.com:3001/joinPledge --header "Content-Type: application/json" -d '{
    "pledgeID":      2,
    "pledgeType":    "move",
    "username":      "user'$i'@example.com",
    "socialNetwork": "gmail"
}' 2> /dev/null &
curl -X POST http://loadtest.clientsofradical.com:3001/joinPledge --header "Content-Type: application/json" -d '{
    "pledgeID":      3,
    "pledgeType":    "share",
    "username":      "@twitter_handle'$i'",
    "socialNetwork": "twitter"
}' 2> /dev/null
) > /dev/null
done
