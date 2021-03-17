#!/bin/bash

dir="."

if [[ $# -ge 1 ]]
then
	dir=$1
fi

ls -AkhlR $dir | awk -v file_name="$dir" '{
	if ($2 ~ /K$/) total += $2;
	if ($2 ~ /M$/) total += $2 * 1024;
	if ($2 ~ /G$/) total += $2 * 1024 * 1024;
} END {
	total += 4;
	if (total < 1024) printf "%dK\t", total;
	else if (total < 1024 * 1024) printf "%.1fM\t", total / 1024;
	else printf "%.1fG\t", total / 1024 / 1024;
	printf "%s\n", file_name;	
}'
