# Import the Active Directory module (if not already imported)
Import-Module ActiveDirectory

# Get all users in the domain and retrieve their PasswordLastSet property
$users = Get-ADUser -Filter * -Properties SamAccountName, PasswordLastSet

# Display the results
foreach ($user in $users) {
    Write-Host -ForeGroundColor Cyan "Password Last Set: " -NoNewLine 
    Write-Host -ForeGroundColor Red "$($user.PasswordLastSet)     " -NoNewline
    Write-Host -ForeGroundColor Cyan "For User: " -NoNewLine 
    Write-Host -ForeGroundColor Green "$($user.SamAccountName)     " 
     
} 
