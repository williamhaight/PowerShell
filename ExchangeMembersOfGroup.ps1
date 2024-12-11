

# $GroupName = Write-Host "Please enter a Group Name: " -ForeGroundColor Green

# Get-DistributionGroupMember -Identity Bingham | Select-Object Name, PrimarySmtpAddress | Sort-Object Name | Format-Table -AutoSize

param(
    [string]$GroupName = (Read-Host "Group Name")
)

try {
    # Check if the group exists
    $Group = Get-DistributionGroup -Identity $GroupName -ErrorAction Stop

    # Retrieve, sort, and display group members
    Write-Host "Retrieving members of the group: $GroupName..." -ForegroundColor Green
    $GroupMembers = Get-DistributionGroupMember -Identity $GroupName |
        Select-Object Name, PrimarySmtpAddress |
        Sort-Object Name

    if ($GroupMembers) {
        # Display the sorted members with colored output
        foreach ($Member in $GroupMembers) {
            Write-Host "$($Member.Name)" -ForegroundColor Green -NoNewline
            Write-Host " -" -ForegroundColor DarkYellow -NoNewline
            Write-Host "  $($Member.PrimarySmtpAddress)" -ForegroundColor DarkCyan
        }
    } else {
        Write-Host "The group '$GroupName' has no members." -ForegroundColor Yellow
    }

} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
