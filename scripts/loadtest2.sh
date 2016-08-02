#!/bin/bash -x
doit() {
echo $1
    curl -X POST http://loadtest2.clientsofradical.com:3001/joinPledge --header "Content-Type: application/json" -d '{
        "pledgeID":      1,
        "pledgeType":    "eat",
        "username":      "user'$1'@example.com",
        "socialNetwork": "facebook"
    }' 2> /dev/null
    curl -X POST http://loadtest2.clientsofradical.com:3001/joinPledge --header "Content-Type: application/json" -d '{
        "pledgeID":      2,
        "pledgeType":    "move",
        "username":      "user'$1'@example.com",
        "socialNetwork": "gmail"
    }' 2> /dev/null
    curl -X POST http://loadtest2.clientsofradical.com:3001/joinPledge --header "Content-Type: application/json" -d '{
        "pledgeID":      3,
        "pledgeType":    "share",
        "username":      "@twitter_handle'$1'",
        "socialNetwork": "twitter"
    }' 2> /dev/null
}
export -f doit
seq -w 0 1 | parallel --max-procs 64 doit