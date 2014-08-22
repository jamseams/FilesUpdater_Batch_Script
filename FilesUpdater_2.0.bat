::This is a comment. Anything that start with :: is ignored by the interpreter.

::Check to see if Folder1 and Folder2 exist, otherwise exit.
if NOT EXIST "C:\Folder1" exit
if NOT EXIST "C:\Folder2" exit

::Create a mapping from D: to location C:\Folder1
::Create a mapping from S: to location C:\Folder2
::Basically D: will be equivalent to location C:\Folder1
subst R: "C:\Folder1"
subst S: "C:\Folder2"

::Change current working directory to S:
cd /d S:

::Loops through all folders within S: and check that they exist
::in D: as well. If not, create the folder.
::Notice that %%A is a comodin and takes the name of each folder
::within S: as the for loop traverses it. 
for /d %%A in (*) do if NOT EXIST "R:\%%A" md "R:\%%A"

::Copy contents of C:\Folder2 into C:\Folder1 with Robocopy
::/Z means that it can use resources over a network storage
::/E means to copy subfolders even they are empty.
::/XO means that old files will be updated; same files skipped.
for /d %%A in (*) do robocopy /Z /E /XO "\%%A" "R:\%%A"

::At this point it is finished updating folders. 
::Change current working directory back to C:, the default.
cd /d C:

::Release both mappings to free memory. 
subst R: /d
subst S: /d

::As seen before this just shows a message to the terminal. 
echo Update performed succesfully... Now program will exit...
pause

::Just to exit and close the window.
exit