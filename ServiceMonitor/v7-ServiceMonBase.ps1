########################################################################################################################
# This Script Goes and Checks a CSV File which has a list of services and servers referenced to that Service. It will  #
# check the server based on the service using a hash file and run some Invoke Commands to check the service status. If #
# The Service Status is Stopped, it will attempt to start the Service Until it is started, otherwise sending email     #
# notifications about that Service Status                                                                              #
########################################################################################################################
$ErrorActionPreference = 'SilentlyContinue'

#Specify a Transcript location for the Service Monitor if you with to Log, otherwise keep it commented out
#Start-Transcript 'D:\scripts\ScriptLogs\ServiceMonitor.txt'

$date = Get-Date -Format 'MM-dd-yyyy HH:MM'

#Input Email Information Here: $from (From Email) $smtp (SMTP Server Address) $port (SMTP Server Port)
$from = ''
$smtp = ''
$port = ''

#Set Connection Error Count to Zero
$connectionerrors = 0

#Build IssueTable Table for Servers with Connection Issues
$issuetable = New-Object System.Data.DataTable
$issuetable.Columns.Add('Servers with Connection Issues') | Out-Null
$row = $issuetable.NewRow()

#Gather List of Services and Servers from CSV
$CSV = Import-Csv -LiteralPath '' #Put Path to Services.csv here inside quotes

foreach ($server in $CSV)
    {
        $srv = $server.ServerName
        $servicename = $server.ServiceName
        $baserestartattempts = $server.RestartAttempts
        $restartattempts = [int]$server.RestartAttempts
        $to = $server.NotifyEmail
        
        Write-Host "Checking to see if $servicename is running on $srv"
        try {$service = Invoke-Command -ComputerName $srv -ScriptBlock {Get-Service -Name $using:servicename} -ErrorAction Stop}
        catch 
            {
                Write-Warning "Unable to retreive service status for $servicename on $srv"
                if ($issuetable.'Servers with Connection Issues' -notcontains $srv)
                    {
                        $row = $issuetable.NewRow()
                        $row.'Servers with Connection Issues'="$srv"
                        $issuetable.Rows.Add($row)
                    }
                $connectionerrors++
            }

        if (($service.Status -ne 'Running') -and ($row.'Servers with Connection Issues' -notcontains $srv))
            {
                do 
                    {
                        #Attempt Service Restart
                        Write-Warning "$servicename Stopped on $srv, Attempting to Start"
                        Invoke-Command -ComputerName $srv -ScriptBlock {Get-Service -Name $using:servicename | Start-Service -Confirm:$false}
                        $restartattempts--
                        Start-Sleep 5
                        $svcchk = Invoke-Command -ComputerName $srv -ScriptBlock {Get-Service -Name $using:servicename}
                        if ($svcchk.Status -eq 'Running')
                            {
                                Write-Host "$servicename Restored on $srv"
                                $body = "$date - The $servicename Service on $srv Has been successfully restarted"
                                #Put Path to ServerMonAlert.ps1 here
                            }
                        if ($restartattempts -eq '0')
                            {
                                $body = "An Attempt has been made to Restart $servicename on $srv $baserestartattempts times, Please Investigate!"
                                #Put Path to ServerMonAlert.ps1 here
                            }
                    }
                until (($svcchk.Status -eq 'Running') -or ($restartattempts -eq '0'))
            }
        else 
            {
                Write-Host "$servicename Service is running and Issue Table doesn't contain $srv"
            }   
    }

if ($connectionerrors -gt '0')
    {
        Write-Warning "Connection Errors Found, Sending Email with Table"
        $connectiontable = $issuetable | select 'Servers with Connection Issues'
        #Put Path to ConnectionIssueAlert.ps1 here
    }

Stop-Transcript
