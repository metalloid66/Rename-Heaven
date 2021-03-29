#!/bin/bash
echo "
	** Run the command ./modify_examples.sh -n to initiate/reinitiate the creation of to be tested files and directories **
	** Place both modify.sh and modify_examples.sh in the same directory for modify_examples.sh to work **
	** For any bugs/feedback report to author mohamadnabeel3@gmail.com **
	
	- This script is meant to demonstrate the usage of modify.sh script.
	- It's specifically meant to lead the tester of the modify script through the typical,
	  uncommon and even incorrect scenarios of usage of the modify script.
	- Tester will be able to run test cases below using the approprite option assigned to each testcase.
	- Testcases will be labelled alphabetically from a to j 
	- E.g to test testcase c, the following command should be written in terminal ./modify_examples.sh -c
	
	--Correct usage scenarios
	
	Testcase a) 
	Description: The most basic testcase, a file myfile_a.txt is provided in the current directory, and the user 
	desires to change the file name to upper case: ./modify.sh -u -- \"modify_dir/myfile_a.txt\"
	Expected output: myfile_a.txt renamed to MYFILE_A.TXT
	
	Testcase b) 
	Description: The most basic testcase, a file MYFILE_B.TXT is provided in the current directory, and the user 
	desires to change the file name to lower case: ./modify.sh -l -- \"modify_dir/MYFILE_B.TXT\"
	Expected output: MYFILE_B.TXT renamed to myfile_b.txt
	
	Testcase c) 
	Description: Two files, myfile_c.txt, myfile_c_2.txt are provided, and the user desires to replace \"my\" in the
	filenames to \"your\": ./modify.sh -- sed 's/my/your/' \"modify_dir/myfile_c.txt\" \"modify_dir/myfile_c_2.txt\" 
	Expected output: myfile_c.txt and myfile_c_2.txt renamed to yourfile_c.txt and yourfile_c_2.txt
	
	Testcase d) 
	Description: A file containing a space my file d.txt is provided, and the user desires to change the file name
	to upper case: ./modify.sh -u -- \"modify_dir/my file d.txt\"
	Expected output: my file d.txt renamed to MY FILE D.TXT
	
	Testcase e) 
	Description: A file containing a space, --, *, comma, ? \"*mY --fi,le?e.tXt\" is provided, and the user desires
	to change the file name to upper case: ./modify.sh -u -- \"modify_dir/*mY --fi,le?e.tXt\"
	Expected output: *mY --fi,le?e.tXt renamed to *MY --FI,LE?E.TXT
	
	Testcase f)
	Description: A file rFile_f.txt is provided in the current directory and sub directories subdir1 and subdir2
	and the user desires to change the file name in all mentioned directories from rFile_f.txt to rFile_f.doc:
	./modify.sh -r -- sed 's/txt/doc/' \"modify_dir/rFile_f.txt\"
	Expected output: rFile_f.txt renamed to rFile_f.doc in specified directory and all its subdirectories 
	
	Testcase g) 
	Description: Two files rFile_g.txt, rFile_g_2.txt are provided in the current directory and sub directories subdir1 and subdir2
	and the user desires to change the file names in all mentinoned directories to uppercase letters only:
	./modify.sh -r -u -- \"modify_dir/rFile_g\" \"modify_dir/rFile_g_2\" 
	Expected output: rFile_g.txt, rFile_g_2.txt renamed to RFILE_G.TXT and RFILE_G_2.TXT in specified directory and all its subdirectories
	
	--Incorrect usage scenarios
	
	Testcase h)
	Description: A file containing a space my file h .txt is provided without double quotes:
	./modify.sh -u -- my file h .txt
	Expected output: MY FILE H .TXT
	Actual output: mv error message log
	
	Testcase i) 
	Description: A file myfile_i.HELP is provided after options without --
	./modify.sh -l \"modify_dir/myfile_i.HELP\"
	Expected output: myfile_i.help
	Actual output: \"Option \"modify_dir/myfile_i.HELP\" not recognized\"
	
	Testcase j)
	Description: A file myfile_j.png is provided with an incorrect sed pattren:
	./modify.sh -- sed '/my/your/' \"modify_dir/myfile_j.png\"
	Expected output: yourfile_j.png
	Actual output: sed error message, mv error message
"
newDir(){
mkdir "modify_dir"
cd modify_dir
mkdir "subdir1" "subdir2"
touch "myfile_a.txt" "MYFILE_B.TXT" "myfile_c.txt" "myfile_c_2.txt" "my file d.txt" "*mY --fi,le?e.tXt" "rFile_f.txt" "rFile_g.txt" "rFile_g_2.txt" "my file h .txt" "myfile_j.png" "myfile_i.HELP"
cd subdir1
touch "rFile_f.txt" "rFile_g.txt" "rFile_g_2.txt"
cd ..
cd subdir2
touch "rFile_f.txt" "rFile_g.txt" "rFile_g_2.txt"
cd ..
cd ..
}

while [ -n "$1" ];do	
  case "$1" in
  -a)./modify.sh -u --  "modify_dir/myfile_a.txt";;
  -b)./modify.sh -l --  "modify_dir/MYFILE_B.TXT";;
  -c)./modify.sh -- sed 's/my/your/' "modify_dir/myfile_c.txt" "modify_dir/myfile_c_2.txt";;
  -d)./modify.sh -u --  "modify_dir/my file d.txt";;
  -e)./modify.sh -u -- "modify_dir/*mY --fi,le?e.tXt";;
  -f)./modify.sh -r -- sed 's/txt/doc/' "modify_dir/rFile_f.txt";;
  -g)./modify.sh -r -u -- "modify_dir/rFile_g.txt" "modify_dir/rFile_g_2.txt";;
  -h)./modify.sh -u -- modify_dir/my file h .txt;;
  -i)./modify.sh -l \"modify_dir/myfile_i.HELP\";;
  -j)./modify.sh -- sed '/my/your/' \"modify_dir/myfile_j.png\";;

  -n)newDir;;
   *) echo "Testcase $1 not recognized";;
   
   esac

   shift
done

