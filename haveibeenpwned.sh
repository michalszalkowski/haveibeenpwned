#!/usr/bin/env bash

echo

URL_FILE=emails.txt

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

while read email;
    do

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
        sleep 2
done < ${URL_FILE}
