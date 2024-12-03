# Get all mailboxes
$mailboxes = Get-Mailbox -ResultSize Unlimited

# Loop through each mailbox and get the folder statistics for Sync Issues\Conflicts
foreach ($mailbox in $mailboxes) {
    # Get the statistics for the Sync Issues\Conflicts folder
    $folderStats = Get-MailboxFolderStatistics -Identity $mailbox.Alias | Where-Object { $_.FolderPath -like "*Conflicts*" }

    # Check if the folder exists and display the size
    if ($folderStats) {
        $folderSize = $folderStats.FolderAndSubfolderSize
        Write-Host -ForeGroundColor Cyan "Mailbox: " -NoNewLine
        Write-Host -ForeGroundColor Green "$($mailbox.Alias), " -NoNewLine
        Write-Host -ForeGroundColor Yellow "Sync Issues\Conflicts Size: " -NoNewLine
        Write-Host -ForeGroundColor Red "$folderSize"
    } else {
        Write-Host -ForeGroundColor Gray "Mailbox: $($mailbox.Alias), Sync Issues\Conflicts folder not found"
    }
}
