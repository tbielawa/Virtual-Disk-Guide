#!/bin/bash

# Oh SWEET. Color codes! Ganked from http://stackoverflow.com/a/10466960/263969
RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'

ok() {
    echo -e "${RESTORE}[${GREEN}OK${RESTORE}]"
}

fail() {
    echo -e "${RESTORE}[${RED}FAIL${RESTORE}]"
}


# Go through the XML sources and grep for links (using a positive look-behind
#
# grep will output "filename:line match", so remove the "filename:" part with cut
grep -P -r -o '(?<=href=")(http://[^"]*)' docbook | cut -d: -f 2-  | \
    # In XML we have to escape ampersands with &amp;, use sed to reverse that
    sed 's/\&amp;/\&/g' | \
    # Remove references to anything from me
    grep -vE '(lnx|tbielawa)' | \
    # Loop over each URL
    while read line; do
    echo -n "${line} ... "; curl --connect-timeout 15 -f ${line} &>/dev/null; # Curl each URL and return a special code if not found
    if [ "${?}" == "0" ]; then # 0 return status means we found it, else it wasn't found
	ok
    else
	fail
    fi
done
