#!/bin/bash

echo "Please Wait...."
chmod +x file/cis_command.sh
chmod +x file/resume.sh
date=$(date '+%d_%m_%Y_%H');
ext=".txt"
filename="$date$ext"
file_name_resume="Resume_${filename}"
echo "Execute script:"

mkdir result
file/cis_command.sh > ./result/$filename
file/resume.sh > $file_name_resume
echo "Create Archive:"
if [ $(rpm -q tar &>/dev/null; echo $?) -eq 0 ]; then
	tar -cvf Oracle_Linux_Audit_Evidence.tar $file_name_resume ./result/$filename
	rm $file_name_resume
	rm -R ./result/
fi
echo ""
echo "Finish! THX!"
