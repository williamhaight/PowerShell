##########################################################################################################################################################
## If you need to send the content of the certificate renewal request file to the CA, use the following syntax to create a Base64 encoded request file: ##
##########################################################################################################################################################

$txtrequest = Get-ExchangeCertificate -Thumbprint A1D3D4AB3BF784ED9F4A38FD8162FF329596975F | New-ExchangeCertificate -GenerateRequest
[System.IO.File]::WriteAllBytes('C:\_admin\Exchange\cert\Sectigo_cert.req', [System.Text.Encoding]::Unicode.GetBytes($txtrequest))

########################################################################################################################################
## If you need to send the certificate renewal request file to the CA, use the following syntax to create a DER encoded request file: ##
########################################################################################################################################

$binrequest = Get-ExchangeCertificate -Thumbprint A1D3D4AB3BF784ED9F4A38FD8162FF329596975F | New-ExchangeCertificate -GenerateRequest -BinaryEncoded [-KeySize 2048] [-Server MAIL2019]
[System.IO.File]::WriteAllBytes('C:\_admin\Exchange\cert\Sectigo_cert.pfx', $binrequest.FileData)

########################################################################################################
## To find the thumbprint value of the certificate that you want to renew, run the following command: ##
########################################################################################################

Get-ExchangeCertificate | Where-Object {$_.Status -eq "Valid" -and $_.IsSelfSigned -eq $false} | Format-List FriendlyName,Subject,CertificateDomains,Thumbprint,NotBefore,NotAfter

$txtrequest = Get-ExchangeCertificate -Thumbprint A1D3D4AB3BF784ED9F4A38FD8162FF329596975F | New-ExchangeCertificate -GenerateRequest -PrivateKeyExportable $true -FriendlyName 'Microsoft Exchange' ;[System.IO.File]::WriteAllBytes(‘C:\_admin\Exchange\cert\emailRenewal.req’, [System.Text.Encoding]::Unicode.GetBytes($txtrequest))


A1D3D4AB3BF784ED9F4A38FD8162FF329596975F 

Get-ExchangeCertificate -Thumbprint A1D3D4AB3BF784ED9F4A38FD8162FF329596975F | New-ExchangeCertificate -GenerateRequest -RequestFile "C:\_admin\Exchange\cert"


$certrequest = Get-ExchangeCertificate -Thumbprint A1D3D4AB3BF784ED9F4A38FD8162FF329596975F | New-ExchangeCertificate -GenerateRequest -PrivateKeyExportable:$true
[System.IO.File]::WriteAllBytes('C:\_admin\Exchange\cert\certrequest.txt', [System.Text.Encoding]::Unicode.GetBytes($certrequest))





Get-ExchangeCertificate -Thumbprint "A1D3D4AB3BF784ED9F4A38FD8162FF329596975F" | New-ExchangeCertificate -Force -PrivateKeyExportable $false
