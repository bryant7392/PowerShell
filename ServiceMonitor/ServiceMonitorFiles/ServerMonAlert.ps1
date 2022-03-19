﻿Import-Module PSWriteHTML

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
        
        
# SIG # Begin signature block
# MIIPNAYJKoZIhvcNAQcCoIIPJTCCDyECAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUm7/KhVwV8U1DJc/nSwj1fS3H
# AwOgggygMIIGJDCCBAygAwIBAgITEwAAAAvEWrlgKwikUQAAAAAACzANBgkqhkiG
# 9w0BAQsFADAYMRYwFAYDVQQDEw1CU1MtUk9PVENBLUNBMB4XDTIxMDgxNTA0MDUz
# NloXDTMxMDYwNjIxMDYzOFowRjETMBEGCgmSJomT8ixkARkWA2ludDETMBEGCgmS
# JomT8ixkARkWA0JTUzEaMBgGA1UEAxMRQlNTLUJTUy1TVUItQ0EtQ0EwggIiMA0G
# CSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCwmkE/fmKeq/fpNkIbQiQqnOBCci2E
# J5SzZ0ZyPjWNlRezuOGthyU9k5X7sOZpt/y61+DnFnJ4faomqQVWA70NvgMvkWbY
# UmywkLC7T8JF7IC8map4QTEckhNvWLkxH71zNfHesOWmzShLwZ1Yr79E2p4lw7R0
# 0f8m4qAr3XejWCBmOfLZ468vEO3mIzKtJJNeC6lh/KtGYz1+qjNiU60ukK1Ynhze
# xia0Ct/Xtsbm4BVYJ/KbLy+L1E5QyxZfqOtvgwWPKTbgqGdnMJn6Qu9YXkVuZnYa
# R6hdTfkqyojoE1BERRTTM3CAwhDB0XSjNpM5jOVppyXvH/wQCRGFlTga/kjqP7cg
# blf5I0+KJkfvN4FulK6V/VhN2s4bl/wzpXn+SeKu0VkyyVOQwYJfnBal5byN+Iwu
# jJhHjvps1jrrTHURu/V2fPi8LXtBFANlePSIO+CUtzOMCQmLi5WhgYObkFM86Fvw
# ph8Z1iNztWk9Ma9aWS2M54E9oxbemhlhC4dIIfPDWWUZ6voHS/OxB9Q7gvYEKE2c
# mDPgsIt7Pfd01Fl+eVL4p2XhkGFK8RGtTD0Ch0rq1/n8He+KWxf/I5L6IfwQ5qqp
# RXJttbLUkE6woRbT3BihtZ+m048rCpqbR7Gx9Acszr8Vae/XiMTZIO2C0ibx2p64
# 0Rt9rSeS4nhlgQIDAQABo4IBNzCCATMwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0O
# BBYEFNpW+aKnaTV7h77qJnHHjYzHU9d4MBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIA
# QwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFP98
# deL9Ev/ZQO89oWjFyBBYUe/iMEcGA1UdHwRAMD4wPKA6oDiGNmh0dHA6Ly9CU1Mt
# U1VCLUNBLkJTUy5pbnQvQ2VydEVucm9sbC9CU1MtUk9PVENBLUNBLmNybDBdBggr
# BgEFBQcBAQRRME8wTQYIKwYBBQUHMAKGQWh0dHA6Ly9CU1MtU1VCLUNBLkJTUy5p
# bnQvQ2VydEVucm9sbC9CU1MtUk9PVENBX0JTUy1ST09UQ0EtQ0EuY3J0MA0GCSqG
# SIb3DQEBCwUAA4ICAQDeMEhCWL2TmJF066f9SfkHBaJrc/M/TgO6sZ67ESuqhqoi
# 1eGPwaFsxD8JlEuephUbAvhuN9GjvnHoBoLS7RVhNSEBOXxohh3EgCatP4+x2qQp
# jMeeA/VP/Qd23Y/mYc+bsl6lKpfq4K1h1x4H6G8jFTugYn63TtfrBcTS/8xDDxgx
# kx4npV9BXvU2VchSGAfcmBpIODNM89jTMea6ODgnQnXzyPTovvwWF6tWfaT2RzYp
# 9/MGwtbSUARnnl8qZJ7OLRHFa640rqFU8Xre8zC9+39x5ry5WLU321k9IFhJQUyf
# yD5T73RDjX43+qQ6hbLiMD1Cl3m7/AAONty2Uv3wwV3zL4s2GHOmNGzhuSVtR7t3
# b5KBSOIcS4+eJqcSLXP02SGjRVX+sKIQzUKcc813DEepPq8j/es5s+7AahLxAus6
# x150dg88v210C7DWoLWFv0EusNZMXKFU+H/SdGhQNEmnuOm69EyR8z8Qo1nESJ9c
# T5wPH2fU2jHfDGzoRkeQt0YQV1GIAL0asCvGOkldwDBYihiZcfq2uE5Pc9hvEF6I
# /bpeNDu20cvKCmPJOEoazyo18M8b13o17OpPTmCVUo/7c1sd6OPLNtj3RaX6Dhym
# vGCmBueJ74dYAVsD+06+5TEj6zqiUUQ0EfOGbSe7rlVSL2xXP9dqfyq7EHnVoDCC
# BnQwggRcoAMCAQICExAAAAAI9RVsHmJo6x8AAAAAAAgwDQYJKoZIhvcNAQENBQAw
# RjETMBEGCgmSJomT8ixkARkWA2ludDETMBEGCgmSJomT8ixkARkWA0JTUzEaMBgG
# A1UEAxMRQlNTLUJTUy1TVUItQ0EtQ0EwHhcNMjEwODE1MDQxNTU3WhcNMjIwODE1
# MDQxNTU3WjBRMRMwEQYKCZImiZPyLGQBGRYDaW50MRMwEQYKCZImiZPyLGQBGRYD
# QlNTMQ4wDAYDVQQDEwVVc2VyczEVMBMGA1UEAxMMQnJ5YW50IFNtaXRoMIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvlqzyLcrfrF4ZOB8VvgRpNfBZP3t
# 61k96Ak7t+yQsdEvbr6tIeQ2bbKNfo4vg7RAFnzzrwTfs5jlP4j+y1h6T9MdZZx6
# Ba2EV81fOj8MVjei2tcf1H0YcowFkf0FQccNyHNobaSng+ZbPgiBwa0pG/h7bUaD
# MHVAdaqFnwAUaGKcn+vbLJVIR3m5c8lDXpIyeLRREro23YiRAdcY5vSndOO9kjDg
# AteF30/h55L35JEPRT7n3jPZxafWUVN017t4zrQi0ICmCw8bUZkvCMo0Hi/VxX2E
# jkz5kJFQyS1hIawKy5xCDHdCRnjvTme6i5bi4TXmtsRQjE47/BPsyCE+4QIDAQAB
# o4ICTjCCAkowJQYJKwYBBAGCNxQCBBgeFgBDAG8AZABlAFMAaQBnAG4AaQBuAGcw
# EwYDVR0lBAwwCgYIKwYBBQUHAwMwDgYDVR0PAQH/BAQDAgeAMB0GA1UdDgQWBBRT
# Ll3PAslmF8Vuigx1UYhJ/QcJOjAfBgNVHSMEGDAWgBTaVvmip2k1e4e+6iZxx42M
# x1PXeDCBzgYDVR0fBIHGMIHDMIHAoIG9oIG6hoG3bGRhcDovLy9DTj1CU1MtQlNT
# LVNVQi1DQS1DQSxDTj1CU1MtU1VCLUNBLENOPUNEUCxDTj1QdWJsaWMlMjBLZXkl
# MjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPUJTUyxE
# Qz1pbnQ/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
# PWNSTERpc3RyaWJ1dGlvblBvaW50MIG/BggrBgEFBQcBAQSBsjCBrzCBrAYIKwYB
# BQUHMAKGgZ9sZGFwOi8vL0NOPUJTUy1CU1MtU1VCLUNBLUNBLENOPUFJQSxDTj1Q
# dWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
# aW9uLERDPUJTUyxEQz1pbnQ/Y0FDZXJ0aWZpY2F0ZT9iYXNlP29iamVjdENsYXNz
# PWNlcnRpZmljYXRpb25BdXRob3JpdHkwKQYDVR0RBCIwIKAeBgorBgEEAYI3FAID
# oBAMDmJyeWFudEBCU1MuaW50MA0GCSqGSIb3DQEBDQUAA4ICAQB7W90Wre6W7eUk
# YaGAETDAU4E548Z1ocToVXApxCzGH1d9nuXXPBfeIEV6aNAkRVOzj6vQG6qH3JoO
# I1UNsUs6EPS6P4aEz5ItAjWkm814Sty7NB8LjTk3hVJ6rPZmNmN+c9602wcao6J6
# Ct0seJgzKuCptLCxCP3MxyECnnWLH7TIafHkaSho9RJDrV08toePaIs5i00DihG1
# mBTTMNBKztBKghFbCYHMkv/tEr7iwc6NzSO0TU3Tisb2AO4g6Tqzkx5AGholZqKR
# NibroNPBcfTFQegXaGMYGaRGkc7yuLC8sbC3xRdXxm8a+dBY+HQP0lvc/yh3CV1P
# V2SHoQj1DiQfDq7t/eHeVxCxpliuYiW77619at1aZr+EZus/wIoVxKZEAzZMhfJU
# tqQjD51s7mUPypJRBJU5VpZJhkUZ1MhNa8JX+/foHIEGgmCoMeyD5tWdDuRdmKgB
# u0lOFoFL1QVlJQpU2clXVZXU2DFYpAx8JUYZB/5ea4M3RJiMexCvHuCM1epNHUet
# kjmgdH8JaE0GwKfMexWZqFImFhnP9xBU02U0dMHflonRMa540szkGOovR+MpWs6J
# QLaR2hceK1xrX+CN7JidHveEY0YrZKgMroC/bC+M3BTJHgGS3IyKouK/P4DIc8fM
# xVS9/swE5ijd13BKTrpZ0wTlevimDDGCAf4wggH6AgEBMF0wRjETMBEGCgmSJomT
# 8ixkARkWA2ludDETMBEGCgmSJomT8ixkARkWA0JTUzEaMBgGA1UEAxMRQlNTLUJT
# Uy1TVUItQ0EtQ0ECExAAAAAI9RVsHmJo6x8AAAAAAAgwCQYFKw4DAhoFAKB4MBgG
# CisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcC
# AQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYE
# FCHHhgqyoCSRL7ugOoiTcG2JkZIyMA0GCSqGSIb3DQEBAQUABIIBAFa4XDa+AtPP
# +S+0XfyYdolXxzbUaRCpSVyXK/voInb4WJpkxQ4tYkB4Rxv1t/mlyTecG4QKFdtY
# N0MrwnZ0m6ghSbhCtL5Au6rztDtd9LD9mueYTiDSbiYCWyzggjl51rT8x9mpomWY
# 8LFh2GA5mHxc0MMzkC0ZEk70eSaVYX0tVRNOdzk+u6m9QKVxrv9rumTmLVtkMoLC
# Pr8mxtYGGfl1LyAQI6hK4CnaGARRFWnIhDl1Bc+XOFjiA3OyFBmpiTl/N/RUe7Y7
# /X0cLwTURgG61mp+hB7s1b80DGQVn8koDfcZuywmJypYlMZIgFnBVGSn2c0VO28z
# nTAKVSfZ5U8=
# SIG # End signature block
