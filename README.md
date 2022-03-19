# PowerShell

This Repository contains several different useful powershell scripts that i've written
to help with day to day monitoring and other activities.

#ServiceMonitor Folder
The ServiceMonitor Folder:  Contains files that are used for monitoring multiple different serviceson Multiple Different Servers.  The script will attemp to restart the service as many times as you specify in the CSV file and will email alerts to the designated email that you specify.  **Note requires the PSWriteHTML Module to be installed**

Command: Install-Module PSWriteHTML -Confirm:$false -AllowClobber
