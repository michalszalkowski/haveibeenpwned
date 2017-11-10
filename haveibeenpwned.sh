#!/usr/bin/env bash

ARG=$1

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

function pwned {

    statusCode=$(curl --write-out %{http_code} --silent --output /dev/null "https://haveibeenpwned.com/api/v2/breachedaccount/$email")

    if [ "$statusCode" == 200 ]
        then
            echo -e ${RED} 'Oh no — pwned!' ${email} ${NC}
        else
    if [ "$statusCode" == 404 ]
        then
            echo -e ${GREEN} 'Good news — no pwnage found!' ${email} ${NC}
        else
            echo -e  ${YELLOW} 'Error' ${email} ${NC}
        fi
    fi

}

if [ $ARG == *.txt ]
  then
    for FILE in "$@"
    do
        while read email;
            do
            pwned email
            sleep 2
        done < ${ARG}
    done
  else
    email=$ARG
    pwned $email
fi