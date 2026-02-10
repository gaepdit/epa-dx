# https://www.techcartnow.com/windows-service-setting-recovery-options-sending-alert-email-in-case-of-service-failure-using-powershell-script/
$EmailFrom = "epd_it@dnr.ga.gov"
$EmailTo = "douglas.waldron@dnr.ga.gov"
$Subject = "Alert: VES Connector PROD service is down."
$Body = "VES Connector PROD service is down."
$SMTPServer = "smtp.gets.ga.gov"
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 25)
$SMTPClient.EnableSsl = $false
$SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
