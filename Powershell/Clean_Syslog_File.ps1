############################################
# Analytics - Clean Syslog File v1.0.0
# Connections Only - UTC Time -> Src -> Dst
# Author: BK
# Date: 2/15/2016
# Put script in same directory as logs
# Used with Sonicwall logs:
# I.E. X_20161004_122159_to_20161004_123018.src
############################################

# Dump results to directory the script was ran from
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath

# Rename all file extensions to .txt
Get-ChildItem $dir -Filter “*.log” | Rename-Item -NewName {$_.name -replace ‘.log’,’.txt’ }
Get-ChildItem $dir -Filter “*.src” | Rename-Item -NewName {$_.name -replace ‘.src’,’.txt’ }

# Select only lines that have all three attributes
Get-Content $dir\*.txt |
Where-Object { $_.Contains("UTC") -and $_.Contains("src=") -and $_.Contains("dst=") } |
Out-file $dir\full.txt -encoding ascii

# Extract UTC time stamps
$input_path = $dir + "\full.txt"
$output_file = $dir + "\clean.txt"
$regex = ‘\b[0-9]{4}-[0-9]{2}-[0-9]{2}\s[0-9]{2}:[0-9]{2}:[0-9]{2}\sUTC\b’

select-string -Path $input_path -Pattern $regex -AllMatches | % { $_.Matches } | % { $_.Value } > $output_file

# Extract Source IP Addresses
$input_path = $dir + "\full.txt"
$output_file = $dir + "\clean1.txt"
$regex = ‘\bsrc=\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:\d{1,5}\b’

select-string -Path $input_path -Pattern $regex -AllMatches | % { $_.Matches } | % { $_.Value } > $output_file

# Extract Destination IP Addresses
$input_path = $dir + "\full.txt"
$output_file = $dir + "\clean2.txt"
$regex = ‘\bdst=\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}:\d{1,5}\b’

select-string -Path $input_path -Pattern $regex -AllMatches | % { $_.Matches } | % { $_.Value } > $output_file

# Combines above 3 text file per line of per text file into one text file
$File1 = @((Get-Content $dir\clean.txt))
$File2 = @((Get-Content $dir\clean1.txt))
$File3 = @((Get-Content $dir\clean2.txt))
$file4 = @()
For($a=0;$a -lt $File1.count;$a++){$File4+=$File1[$a].trim()+ " --> " +$File2[$a].trim()+ " --> " +$File3[$a].trim()}
$File4 | Out-File $dir\log.txt -encoding ascii

# Clean up of working directory - Remove comment below to delete logs when done
Remove-item $dir\clean.txt
Remove-item $dir\clean1.txt
Remove-item $dir\clean2.txt
Remove-item $dir\full.txt
#Remove-item $dir\X_*.txt
