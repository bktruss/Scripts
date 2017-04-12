#########################################
# Analytics - MAC White List Maker v1.0.0
# Author: BK
# Date: 12/4/2015
##########################################

# Add starting timestamp to timestamp.txt in debug folder
$date1 = Get-Date
"Start "+ $date1 >> "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\debug\timestamp.txt"

# Takes the second most recent file and moves it to Destination_IP_Module temp folder
gci C:\Users\admin\Desktop\Analytics\MAC_Address_List\capture\*.cap | 
where {!$_.PSIsContainer} | sort LastWriteTime | select -f 1 | 
move -destination "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp"

# Renames capture file to capture.cap
gci C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp *.cap | 
rename-item -newname capture.cap

tshark -r "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\capture.cap" -T fields -e eth.src |
sort | unique | Out-file "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\tempmac.txt" -encoding ascii -width 4096

Get-Content "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\tempmac.txt" | 
select-string -pattern '<GATEWAY MAC HERE>' -notmatch | 
Out-file "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\MacWhiteList.txt" -encoding ascii -Append

Get-Content "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\MacWhiteList.txt" | sort | unique | 
Set-Content "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\MacWhiteList.txt"

Remove-Item "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\debug\tempmac.txt"
Remove-Item "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\debug\capture.cap"

Move-Item "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\tempmac.txt" "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\debug\tempmac.txt"
Move-Item "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\capture.cap" "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\debug\capture.cap"


# Add Finishing timestamp to timestamp.txt in debug folder
$date2 = Get-Date
"Finish "+ $date2 >> "C:\Users\admin\Desktop\Analytics\MAC_Address_List\temp\debug\timestamp.txt"
