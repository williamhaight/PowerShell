# Define the mailbox
Write-Host ""
$Mailbox = Read-Host "Please Enter a Mailbox Name: "

# Get all folders and subfolders for the Sync Issues
$SyncIssuesFolders = Get-MailboxFolderStatistics -Identity $Mailbox | Select-Object FolderPath, FolderSize, ItemsInFolder | Where-Object {$_.FolderPath -like "*Issues*"}

# Check if the "Conflicts" folder exists
if ($SyncIssuesFolders) {
    
    Write-Host ""
    Write-Host -ForeGroundColor Green "Mailbox: $Mailbox"
    Write-Host -ForeGroundColor Red "" -NoNewline
    $SyncIssuesFolders
    Write-Host ""
    

} else {
    Write-Host "The 'Sync Issues' folders are not found in the mailbox: $Mailbox"
}