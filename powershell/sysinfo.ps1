function getIP {
        (Get-NetIPAddress).IPv4Address | Select-String "192"
        }
$IP = getIP
$User = $env:USERNAME
$Body = "Test"

Send-MailMessage -To "Klekchyant2167@gmail.com" -From "klekchyant216@gmail.com" -Subject "IT3038C Windows SysInfo" -Body $BODY -SmtpServer smtp.gmail.com -port 587 -UseSSL -Credential (Get-Credential)