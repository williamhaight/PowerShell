#######################################################################################################
## This script will show the Lockout status for all users in the domain sorted by the lockout status ##
#######################################################################################################

Get-ADUser -Filter 'enabled -eq $true' -Properties SamAccountName, LockedOut | Sort-Object LockedOut |  Select-Object SamAccountName, LockedOut