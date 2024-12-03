##########################################################################################################
## This script will check all domain controllers to check the last login date for specified users ########
##########################################################################################################

$UserList = "bhaight", "mjensen", "dthomas"

$DCs = (Get-ADDomainController -Filter *).Name

$Combined = foreach ($User in $UserList)
{
    $DCarray = [ordered] @{}
    foreach ($DC in $DCs)
    {
        $DCresponse = Get-ADUser $User -Properties DisplayName, LastLogonDate -Server $DC | Select-Object Name, DisplayName, LastLogonDate
        if( -not $DCarray.Contains("Name")) { $DCarray.Add("Name",$DCresponse.name) }
        if( -not $DCarray.Contains("DisplayName")) { $DCarray.Add("DisplayName",$DCresponse.DisplayName) }
        if( -not $DCarray.Contains($DC)) { $DCarray.Add($DC,$DCresponse.LastLogonDate) }
    }
    $Return = New-Object -TypeName psobject
        foreach ($Key in $DCarray.keys)
        {
            $Each = $DCarray[$Key]
            
            $Return | Add-Member -MemberType NoteProperty -Name $Key -Value $Each
        }
    $Return
}

$Combined | Format-Table -AutoSize
