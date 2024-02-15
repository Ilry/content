#!/bin/bash

# https://stackoverflow.com/questions/4277665/how-do-i-compare-two-string-variables-in-an-if-statement-in-bash
# https://stackoverflow.com/questions/2875424/correct-way-to-check-for-a-command-line-flag-in-bash

segment="descriptors"

if [[ $* == *-p* ]]; then
	segment="prefab_descriptors"
	echo "Entering prefab descriptor mode."
fi

if test -f ./scripts/$segment/$1.lua; then
	echo "Descriptor '$1.lua' already exists."
else
	cp ./scripts/$segment/example.lua ./scripts/$segment/$1.lua
	sed -i -e "s/example/$1/g" ./scripts/$segment/$1.lua
	echo "Created descriptor [./scripts/$segment/$1.lua]"

	code ./scripts/$segment/$1.lua
fi