#!/bin/bash
helper(){
 echo "
	 
	 Name: modify.sh
	 
	 Description: Modify is a tool to rename any file/s in linux subsystems 
	 lowercasing, uppercasing or according to a sed pattren.

	 Usage:
		  modify [-r] [-l|-u] -- <\"dir/file names...\">
		  modify [-r] -- <sed pattern> <\"dir/file names...\">
		  modify [-h]
	   Please do not omit the -- after options, and surround file names with double quotes to support all file names
	 
	 Options:
	 	-l 			Lowercase file names that follow
	 	-u			Uppercase file names that follow
	 	-r			Recursively apply the modifications
	 	-h			Show help window
	 	
	 Examples:
	 	1. The following example will rename a file myfile.txt to MYFILE.TXT
		./modify.sh -u -- \"myfile.txt\"
	 	2. The following example will rename a file MYFILE.TXT in the current directory and all subdirectories to myfile.txt
		./modify.sh -r -l -- \"myfile.txt\"
		3. The following example will rename files myfile1.txt and myfile2.txt to yourfile1.txt and yourfile2.txt using a sed pattren
		./modify.sh -- sed 's/my/your/' \"myfile1.txt\" \"myfile2.txt\"
	   For more examples and test cases, please run modify_examples.sh
	     
	 Notes:
	 	- The script takes either -l or -u flag, not both. If both are provided, the last in the arugment list will be considered
	 	- If a sed pattern is provided, both -l and -u flags (if set) will be ignored 
	 	- The file names to change are only inserted after -- This behaviour was implemented to support every possible file name
	 	
	 "
 
 exit 0;
}

allowR="false"		# Used for the -r option
while [ -n "$1" ];do	# Options initialization
  case "$1" in
  -r) allowR="true";;
  -l) lowUp="tr [:upper:] [:lower:]";; #Tr to lowerize or upperize
  -u) lowUp="tr [:lower:] [:upper:]";;
  -h) helper;; 
  --) 
   shift 
   
   break;;
   
   *) echo "Option $1 not recognized";;
   
   esac

   shift
done

while [ -n "$1" ]; do

	if [ "$1" = "sed" ]						# If sed pattern is entered 
	then 

	for ((i=3; i<=$#; ++i)); do 				        # Loop over parameters starting from third

		fileOri=$(echo "${!i}" | sed  "s/.*\///")
		fileDir=$(echo "${!i}" | grep -o '.*\/')    
		fileNew=`echo "$fileOri" | sed $2`
		
		if [ "$allowR" = "true" ]; then
		echo "r enabled"
		for x in $(find . -name *"$fileOri"); do		# With -r, find [start directory] -name [what to find]
		mv $x $(echo "$x" | sed "s/"$fileOri"/"$fileNew"/")
		done 
		else 
		echo "r not enabled"
		mv -- "${!i}" "$fileNew"				# Without -r
		mv -- "$fileNew" $fileDir
		fi 
		
		done
	break;

	fi

	fileOri=$(echo "$1" | sed  "s/.*\///")         	       # Filename without directories ready to get looped over
	fileOriOg=$(echo "$1" | sed  "s/.*\///")                     # Filename without directories ready to get looped over
	fileNew=""					   	       # Initalize the new file name
	for letter in "${fileOri}" ; do 			       # Start looping through the original file name		
		fileOri=$(echo "$letter" | $lowUp)
		fileNew="$fileNew$fileOri"
	done
	fileDir=$(echo "$1" | grep -o '.*\/')

		if [ "$allowR" = "true" ]; then
		for x in $(find . -name *"$fileOriOg"); do	       # With -r, find [start directory] -name [what to find]
		mv $x $(echo "$x" | sed "s/"$fileOriOg"/"$fileNew"/")
		done
		
		else 							# Without -r
		mv -- "$1" "$fileNew"					# -- solves the -filename, --filename, *filename problem
		mv -- "$fileNew" $fileDir
		fi
		
 shift
done
