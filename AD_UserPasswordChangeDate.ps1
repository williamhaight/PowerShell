# Import the Active Directory module (if not already imported)
Import-Module ActiveDirectory

# Specify the username of the account
Write-Host ""

# Specify the username of the account
$userName = Read-Host "User Name"

# Get the user's information, including the PasswordLastSet property
$user = Get-ADUser -Identity $userName -Properties PasswordLastSet

# Display the password last set date in green
Write-Host "User: $($user.SamAccountName)" -ForegroundColor Green
Write-Host "Password Last Set: $($user.PasswordLastSet)" -ForegroundColor Red

Write-Host ""
