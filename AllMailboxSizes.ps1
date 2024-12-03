Get-MailboxStatistics -Server mail2019 | Sort-Object TotalItemSize | Select-Object DisplayName, @{expression = {$_.TotalItemSize.Value.ToMB()}; label="TotalItemSizeMB"}