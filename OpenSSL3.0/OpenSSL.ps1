$ImagePath = 'Path to Image File'
$CA_Link = "https://'InputCAHostNameHere'/certsrv/"
$OpenSSL_Link = 'https://slproweb.com/download/Win64OpenSSL-3_0_1.exe'

#This If Statement Checks to see if Open SSL 3.0 64bit is installed
if ((Get-ChildItem -Path 'C:\Program Files\OpenSSL-Win64\bin' | Select-Object -ExpandProperty Name) -contains 'openssl.exe')
    {
        do {
                #Selections for what you want to do
                $prompt = New-Prompt -Message 'Submit CSR Request to CA' -InputType Link -Group 'CA Link' -DefaultValue $CA_Link
                $selections = Show-AnyBox -Message 'Utimate SSL Menu!','','What do you want to do?' -Buttons `
                'Create Private Key','Decrypt Private Key','Create CSR','Create SAN CSR','Build CA Bundle','Create PFX' -Prompts $prompt `
                -FontSize 20 -BackgroundColor 'CornFlowerBlue' -ContentAlignment Center -ButtonRows 6 -Title 'SSL' -Image $ImagePath

                #If Create Private Key Button is clicked, process with Private Key Creation
                if ($selections['Create Private Key'] -eq 'True')
                    {
                        $prompt = New-Prompt -Name 'filepath' -Message 'Choose Where to Save Private Key' -InputType FileSave
                        $prompt2 = New-Prompt -Name 'keysize' -Message 'Select Key Size' -ValidateSet @('2048','4096')
                        $prompt3 = New-Prompt -Name 'encrypt' -Message 'Encrypt Key File' -InputType Checkbox
                        $privselect = Show-AnyBox -Message 'Create a Private Key' -Prompts $prompt,$prompt2,$prompt3 -Buttons 'Create Key' `
                        -FontSize 16 -BackgroundColor 'CornFlowerBlue' -ContentAlignment Center

                        if ($privselect['Create Key'] -eq 'True')
                            {
                                Set-Location 'C:\Program Files\OpenSSL-Win64\bin'
                                Write-Host "Generating KeyFile to $($privselect['filepath']) with KeySize of $($privselect['keysize'])"
                                if ($privselect['encrypt'] -eq 'True') {
                                    .\openssl.exe genrsa -aes256 -out $privselect['filepath'] $privselect['keysize']
                                }
                                else {.\openssl.exe genrsa -out $privselect['filepath'] $privselect['keysize']}
                            }
                    }
                
                if ($selections['Decrypt Private Key'] -eq 'True') {
                    $keydecryptsel = Show-AnyBox -Message 'Decrypt Private Key' -Buttons 'Decrypt' -FontSize 16 `
                    -BackgroundColor 'CornFlowerBlue' -ContentAlignment Center -Prompts @(
                        (New-Prompt -Name 'keypath' -Message 'Browse for Encrypted Private Key' -InputType FileOpen),
                        (New-Prompt -Name 'destkeypath' -Message 'Choose where to save Unencrypted Private Key' -InputType FileSave)
                    )

                        if ($keydecryptsel['Decrypt'] -eq 'True') {
                            Set-Location 'C:\Program Files\OpenSSL-Win64\bin'
                            Write-Host "Saving Unencrypted KeyFile to $($keydecryptsel['destkeypath'])"
                            .\openssl.exe rsa -in $keydecryptsel['keypath'] -out $keydecryptsel['destkeypath']
                        }
                }
                #If Create CSR Button is Clicked, process CSR Creation
                if ($selections['Create CSR'] -eq 'True')
                    {
                        $prompt = New-Prompt -Name 'csrpath' -Message 'Choose Where to Save CSR' -InputType FileSave
                        $prompt2 = New-Prompt -Name 'keyfile' -Message 'Select Private Key' -InputType FileOpen
                        $csrselect = Show-AnyBox -Message 'Create Certificate Request' -Prompts $prompt, $prompt2 -Buttons 'Create CSR' `
                        -FontSize 16 -BackgroundColor 'CornFlowerBlue' -ContentAlignment Center   

                        if ($csrselect['Create CSR'] -eq 'True')
                            {
                                Set-Location 'C:\Program Files\OpenSSL-Win64\bin'
                                Write-Host "Generating CSR..."
                                .\openssl.exe req -out $csrselect['csrpath'] -key $csrselect['keyfile'] -new
                            }
                    }
        
                #If the Create SAN CSR button is clicked proceed with the SAN CSR Creation
                if ($selections['Create SAN CSR'] -eq 'True')
                    {
                        #Ask to Create or Load a Config File, Further Options Below will behave based on selection
                        $loadsave = Show-AnyBox -Message 'Load Existing or Create','Config File for SAN Cert?' -Buttons 'Load','Create' `
                        -FontSize 18 -BackgroundColor 'CornFlowerBlue' -ContentAlignment Center

                        $prompt = New-Prompt -Name 'csrpath' -Message 'Choose Where to Save CSR' -Group 'Files/Paths' -InputType FileSave -ValidateNotEmpty
                        $prompt2 = New-Prompt -Name 'keyfile' -Message 'Select Private Key' -Group 'Files/Paths' -InputType FileOpen -ValidateNotEmpty
                        #If Creating a Config File, the FileSave is Defined for Prompt3 and all 5 prompts are shown in the csrselect
                        if ($loadsave['Create'] -eq 'True')
                            {
                                $prompt3 = New-Prompt -Name 'configfile' -Message 'Save Config Path' -Group 'Files/Paths' -InputType FileSave -ValidateNotEmpty
                                $prompt4 = New-Prompt -Name 'commonname' -Message 'Input Common Name' -Group 'Cert Details' -InputType Text -ValidateNotEmpty
                                $prompt5 = New-Prompt -Name 'DNSNames' -Message 'Input DNS Name/s EX: DNS:test.com, DNS:test2.com' -Group 'Cert Details' `
                                -InputType Text -ValidateNotEmpty
                                $csrselect = Show-AnyBox -Message 'Create Certificate Request w/Config' -Prompts $prompt, $prompt2, $prompt3, $prompt4, $prompt5 `
                                -FontSize 16 -BackgroundColor 'CornFlowerBlue' -ContentAlignment Center -Buttons 'Create CSR'
                            }
                        #If Loading a Config File, the FileOpen is Defined for Prompt3 and only promp, promp2, and promp3 are required to create the CSR
                        else
                            {
                                $prompt3 = New-Prompt -Name 'configfile' -Message 'Load Config Path' -Group 'Files/Paths' -InputType FileSave -ValidateNotEmpty
                                $csrselect = Show-AnyBox -Message 'Create Certificate Request w/Config' -Prompts $prompt, $prompt2, $prompt3 `
                                -FontSize 16 -BackgroundColor 'CornFlowerBlue' -ContentAlignment Center -Buttons 'Create CSR'
                            }

                        if ($csrselect['Create CSR'] -eq 'True')
                            {
                                #If Creating a Config File run the below, If Laoding a Config, don't run the below
                                if ($loadsave['Create'] -eq 'True')
                                    {
                                        #Config File Buildout
                                        $config = "distinguished_name = req_distinguished_name",
                                        "encrypt_key = no",
                                        "prompt = no",
                                        "string_mask = nombstr",
                                        "req_extensions = v3_req",
                                        "",
                                        "[ v3_req ]",
                                        "basicConstraints = CA:FALSE",
                                        "keyUsage = digitalSignature, keyEncipherment, dataEncipherment",
                                        "extendedKeyUsage = serverAuth, clientAuth",
                                        "subjectAltName = $($csrselect['DNSNames'])",
                                        "",
                                        "[ req_distinguished_name ]",
                                        "countryName = US",
                                        "stateOrProvinceName = Indiana",
                                        "localityName = Lafayette",
                                        "0.organizationName = SIA",
                                        "organizationalUnitName = IT",
                                        "commonName = $($csrselect['commonname'])"
                        
                                        #Output config file to ASCII (Required to work properly with OpenSSL)
                                        Write-Host "Outputting Configuration to $($csrselect['configfile'])"
                                        Out-File -FilePath $csrselect['configfile'] -Encoding ascii -InputObject $config
                                    }
                        
                                #Change directory to OpenSSL bin Directory in Program Files
                                Set-Location 'C:\Program Files\OpenSSL-Win64\bin'

                                #Generating SAN CSR based on the selections, information
                                Write-Host "Generating CSR to $($csrselect['csrpath'])"
                                .\openssl.exe req -new -key $csrselect['keyfile'] -out $csrselect['csrpath'] -config $($csrselect['configfile'])
                            }

                    }

                #If Build CA Bundle Button is Clicked, process CA Bundle Building
                if ($selections['Build CA Bundle'] -eq 'True')
                    {
                        $prompt = New-Prompt -Name 'interca' -Message 'Select Intermediate Cert' -InputType FileOpen
                        $prompt2 = New-Prompt -Name 'rootca' -Message 'Select Root Cert' -InputType FileOpen
                        $prompt3 = New-Prompt -Name 'savepath' -Message 'Where to Save' -InputType FileSave
                        $caselect = Show-AnyBox -Message 'Build CA Bundle' -Prompts $prompt, $prompt2, $prompt3 -Buttons 'Build' `
                        -FontSize 16 -BackgroundColor 'CornFlowerBlue' -ContentAlignment Center

                        if ($caselect['Build'] -eq 'True')
                            {
                                Write-Host "Building CA Bundle and Saving to $($caselect['savepath'])"
                                #& type $caselect['interca'],$caselect['rootca'] > $caselect['savepath'] (type is alias of Get-Content)
                                Get-Content $caselect['interca'],$caselect['rootca'] | Out-File $caselect['savepath'] -Encoding ascii
                            }
                    }

                #If Create PFX Button is clicked, process PFX Creation
                if ($selections['Create PFX'] -eq 'True')
                    {
                        $prompt = New-Prompt -Name 'privkey' -Message 'Select Private Key' -InputType FileOpen
                        $prompt2 = New-Prompt -Name 'cert' -Message 'Select Certificate' -InputType FileOpen
                        $prompt3 = New-Prompt -Name 'inter' -Message 'Select Intermediate Cert' -InputType FileOpen
                        $prompt4 = New-Prompt -Name 'root' -Message 'Select Root Cert' -InputType FileOpen
                        $prompt5 = New-Prompt -Name 'cabundle' -Message 'Choose Save Path for CA Bundle' -InputType FileSave
                        $prompt6 = New-Prompt -Name 'pfxpath' -Message 'Choose Save Path for PFX' -InputType FileSave

                        $pfxselect = Show-AnyBox -Message 'Create PFX' -Prompts $prompt, $prompt2, $prompt3, $prompt4, $prompt5, $prompt6 -Buttons 'Create PFX' `
                        -FontSize 16 -BackgroundColor 'CornFlowerBlue' -ContentAlignment Center

                        if ($pfxselect['Create PFX'] -eq 'True')
                            {
                                Set-Location 'C:\Program Files\OpenSSL-Win64\bin'

                                Write-Host "Creating CA Bundle"
                                #& type $pfxselect['inter'],$pfxselect['root'] > $pfxselect['cabundle'] (type is alias of Get-Content)
                                Get-Content $pfxselect['inter'],$pfxselect['root'] | Out-File $pfxselect['cabundle'] -Encoding ascii

                                Write-Host "Creating PFX to $($pfxselect['pfxpath'])"
                                .\openssl.exe pkcs12 -export -out $pfxselect['pfxpath'] -inkey $pfxselect['privkey'] -in $pfxselect['cabundle'] -in $pfxselect['cert']
                            }
                    }
                $another = Show-AnyBox -Message 'Another Open SSL Task?' -Buttons 'Yes','No' -FontSize 18 -BackgroundColor 'CornFlowerBlue' -ContentAlignment Center
            } #End Do Loop
            while ($another['Yes'] -eq 'True')
    }
else
    {
        $prompt = New-Prompt -Name 'link' -Message 'Click to Download Open SSL' -InputType Link -DefaultValue $OpenSSL_Link
        Show-AnyBox -Message 'WARNING: OpenSSL not Installed' -Prompts $prompt -Buttons 'Close' `
        -FontSize 18 -BackgroundColor 'Yellow' -ContentAlignment Center | Out-Null
    }