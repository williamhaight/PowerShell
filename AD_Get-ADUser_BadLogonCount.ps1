#############################################################################################################################
## This script will show the BadLogonCount for all users in the domain sorted so that users with a count are at the bottom ##
#############################################################################################################################

Get-ADUser -Filter 'enabled -eq $true' -Properties BadLogonCount, SamAccountName, LockedOut | Sort-Object BadLogonCount |  Select-Object BadLogonCount, SamAccountName, LockedOut
