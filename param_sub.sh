#!/bin/bash
function param_replace()
{
    config_file=$1
    shift
    configs=("$@")
    if [ ! -e $config_file ]; then
        echo "File $config_file does not exist!"
        return 4
    fi
	# param substitution
   	echo config_file=$config_file
    cp $config_file "${config_file%.*}"
	for config_v in ${configs[@]}; do
    	key="${config_v%,*}" # front
    	val="${config_v#*,}" # back
    	echo key=$key, val=$val
    	sed -i "s/\${$key}/$val/" "${config_file%.*}"
 	done
}

# param_replace "$@"
