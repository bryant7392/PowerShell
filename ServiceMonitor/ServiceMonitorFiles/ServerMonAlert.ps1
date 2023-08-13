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
        EmailSubject -Subject "$servicename Restart Issue on $srv - $date"
               }
    EmailBody{
            EmailTextBox -FontFamily 'Calibri' -Size 17 -TextDecoration underline -Color Red -Alignment center{
                    $body
                    }
             }
     }
