#!/bin/bash

file=$(ls result/ | tail -n -1)
END=$(egrep -i '^([0-9])' result/$file | wc -l)
p="p"
for ((i=1;i<=END;i++)); do
    line="$i$p"
    con_name=$(egrep -i '^([0-9])\.' result/$file | sed -n $line)
    con_state=$(grep '^....$' result/$file | sed -n $line)
    echo "$con_name : $con_state" >> file/tmp.txt  
done
column file/tmp.txt -t -s ":"
rm file/tmp.txt
