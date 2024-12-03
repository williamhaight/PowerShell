# Specify the mailbox for which you want to check the size
Write-Host ""
Write-Host "Please enter a Malbox Name: " -ForeGroundColor Yellow
$Mailbox = Read-Host " "

# Get the mailbox statistics
$MailboxStats = Get-MailboxStatistics -Identity $Mailbox

# Convert size to megabytes
$TotalSizeMB = [math]::round(($MailboxStats.TotalItemSize.Value.ToMB()), 2)

# Display the result
Write-Host ""
Write-Host -ForeGroundColor Yellow "The mailbox size of " -NoNewline
Write-Host -ForeGroundColor Green "$Mailbox " -NoNewLine 
Write-Host -ForeGroundColor Yellow "is " -NoNewline
Write-Host -ForeGroundColor Red -BackGroundColor Black "$TotalSizeMB MB"
Write-Host ""
