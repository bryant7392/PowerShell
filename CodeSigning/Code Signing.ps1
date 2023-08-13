$codecert = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert

#Put Path to Scripts Here
$scriptpath = ''

#Sign All Scripts at \\192.168.1.9\scripts
$scriptsroot = Get-ChildItem -Path $scriptpath -Recurse `
| Where-Object {($_.Name -like '*.ps1*')}

foreach ($script in $scriptsroot)
    {
        $scriptdir = $script | select -ExpandProperty Directory
        $scriptfile = $script | select -ExpandProperty Name
        Set-AuthenticodeSignature -FilePath "$scriptdir\$scriptfile" -Certificate $codecert
    }
