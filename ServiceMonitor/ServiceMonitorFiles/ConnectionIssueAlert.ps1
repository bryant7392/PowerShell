Import-Module PSWriteHTML

$date = Get-Date -Format "MM-dd-yyyy"

Email{
    EmailHeader{
        EmailFrom -Address $from
        EmailTo -Addresses $to
        #EmailCC -Addresses ""
        #EmailBCC -Addresses ""
        EmailServer -Server $smtp -Port $port
        EmailOptions -Priority High
        EmailSubject -Subject "Service Monitor Connection Problems - $date"
               }
    EmailBody{

            Table -Table $connectiontable -HideFooter

             }
     }
