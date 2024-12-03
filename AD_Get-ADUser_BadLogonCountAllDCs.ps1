####################################################################################
## This will show the BadLogonCount for each doman controller for specified users ##
####################################################################################

$UserList = "bhaight", "tech2"

$DCs = (Get-ADDomainController -Filter *).Name

$Combined = foreach ($User in $UserList)
{
    $DCarray = [ordered] @{}
    foreach ($DC in $DCs)
    {
        $DCresponse = Get-ADUser $User -Properties SamAccountName, BadLogonCount -Server $DC | Select-Object Name, SamAccountName, BadLogonCount
        if (-not $DCarray.Contains("Name")) { $DCarray.Add("Name", $DCresponse.Name) }
        if (-not $DCarray.Contains("SamAccountName")) { $DCarray.Add("SamAccountName", $DCresponse.SamAccountName) }
        if (-not $DCarray.Contains($DC)) { $DCarray.Add($DC, $DCresponse.BadLogonCount) }
    }
    $Return = New-Object -TypeName psobject
    foreach ($Key in $DCarray.Keys)
    {
        $Each = $DCarray[$Key]
        $Return | Add-Member -MemberType NoteProperty -Name $Key -Value $Each
    }
    $Return
}

$Combined | Format-Table -AutoSize
