

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
        # Display the sorted members with custom colors in a table-like format
        Write-Host "`nName                            PrimarySmtpAddress" -ForegroundColor White
        Write-Host "-------------------------------- --------------------" -ForegroundColor White
        foreach ($Member in $GroupMembers) {
            # Format output with color
            Write-Host ($Member.Name.PadRight(30)) -ForegroundColor Green -NoNewline
            Write-Host " " -NoNewline
            Write-Host ($Member.PrimarySmtpAddress) -ForegroundColor Blue
        }
    } else {
        Write-Host "The group '$GroupName' has no members." -ForegroundColor Yellow
    }

} catch {
    Write-Host "Error: $($_.Exception.Message)" -ForegroundColor Red
}
