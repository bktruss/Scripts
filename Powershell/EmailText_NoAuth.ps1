$emailSmtpServer = "mail.charter.net"
$emailFrom = "Hourly Report Alerts"
$emailTo = "1234567890@vtext.com"
$emailSubject = "ALERT!!!"
$emailBody = @"
Here is a message
From your friendly neighbor
"@
Send-MailMessage -To $emailTo -From $emailFrom -Subject $emailSubject -Body $emailBody -SmtpServer $emailSmtpServer
