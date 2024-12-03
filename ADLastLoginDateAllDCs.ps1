###########################################################################################################################################
## Looks at each Domain controller and returns the LastLogon from each of them converting the millisecond timing to normal date and time ##
###########################################################################################################################################

$UserList = "bhaight", "tech2"

$DCs = (Get-ADDomainController -Filter *).Name

$Combined = foreach ($User in $UserList)
{
    $DCarray = [ordered] @{}
    foreach ($DC in $DCs)
    {
        $DCresponse = Get-ADUser $User -Properties SamAccountName, LastLogon -Server $DC | Select-Object Name, SamAccountName, @{Name="LastLogon"; Expression={[System.DateTime]::FromFileTime($_.LastLogon)}}
        if (-not $DCarray.Contains("Name")) { $DCarray.Add("Name", $DCresponse.Name) }
        if (-not $DCarray.Contains("SamAccountName")) { $DCarray.Add("SamAccountName", $DCresponse.SamAccountName) }
        if (-not $DCarray.Contains($DC)) { $DCarray.Add($DC, $DCresponse.LastLogon) }
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
