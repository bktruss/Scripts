##################################################
#        NOAA Weather Alert - Your County        #
#                  Hours Edition                 #
# Version: 1.0                                   #  
# Author: BK                                     #
# Date: 12/13/17                                 #
# Powershellv3                                   #
#                                                #
# Find the your home states county list at       #
# https://alerts.weather.gov/                    #
# Then find your county code and replace the     #
# first variable below with that county code     #
##################################################

# Settings
$countycode = "FLC041"
# Below limits alerts to one per "X" hour period
$hoursbetweenAlerts = "12"

# Identify Current Working Directory
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath

# Remove previous working files
if (Test-path ($dir + "\weatheralert.txt")){Remove-item ($dir + "\weatheralert.txt")}
if (Test-path ($dir + "\weatheralertsummary.txt")){Remove-item ($dir + "\weatheralertsummary.txt")}

# Checks to see if sent.txt is present, if less than "X" hours old then script Exits, if not then sent.txt gets deleted
if (Test-path ($dir + "\sent.txt"))
{
Get-ChildItem -path ($dir + "\sent.txt") | where {$_.Lastwritetime -gt (date).addhours($hoursbetweenAlerts)} | remove-item
}

#-----------------------------------------------------------------------------------------------------------

# Checks to see if sent.txt is present, if yes then script exits, if no then script run continues
if (Test-path ($dir + "\sent.txt"))
{
Exit
}

else

{
# Download webpage from NOAA - Watches, Warnings or Advisories
$url = ("http://alerts.weather.gov/cap/wwaatmget.php?x=" + $countycode + "&y=1")
$output = ($dir + "\weatheralert.txt")
$start_time = Get-Date

Invoke-WebRequest -Uri $url -OutFile $output

# Pull alert summary if an alert is present
$path = ($dir + "\weatheralert.txt")
$output = ($dir + "\weatheralertsummary.txt")
$content = Get-Content $path -Raw

if ($content -match '<summary>(.+?)</summary>')
{
    $matches[1] | Out-File $output -Encoding ascii

# Configure your notification settings below
$emailSmtpServer = "mail.charter.net"
$emailFrom = "AlertsFrom@BK.com"
$emailTo = "1234567890@vtext.com"
$emailSubject = "Weather Alert!"
$emailBody = Get-Content ($dir + "\weatheralertsummary.txt")

Send-MailMessage -To $emailTo -From $emailFrom -Subject $emailSubject -Body $emailBody -SmtpServer $emailSmtpServer

New-item ($dir + "\sent.txt") -type File

}

else

{Exit}

}