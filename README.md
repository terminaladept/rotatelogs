# Simple Log rotate Powershell script

### About

A simple Powerhsell script to rotate log files. Adds desired files to an archive bsed on their lastwritendate. Then deletes the original file. Script is quick and dirty, doesn't handle errors intelligently.

### How to run

It is recommended this script is run locally on the target server using task scheduler <br>
Preferably on a daily basis. At least more frequently than every 21 days, to prevent oldest log files from falling out of the scope of the date sorting loop. <br>  
<br>
Although you can run this script manualy it seems pointless for all but emergency space clearing. <br>
As files are added and deleted in series this allows archival with only a small storage overhead. <br>

### This script assumes the following prerequisties

1. User running the script can escalate privileges
2. Powervsion Version 5 - not tested in previous versions
3. Scipt is run locally on the target server
4. The target server has adequately permissive networking

### Actions
1. Gather files in log folder last written to more than 7 days ago
2. Loop all gathered files, for each add to archive based on 
    - If Last written this month
    - If Last written last month & that month was not December
    - if Last written last month & that month was December
    <br>
3. Then delete file after added to archive
4. If month doesn't match print a warning and skip archive and delete step

### Possible improvements
- Try/Catch on archive before deletion
- Compress/Delete blocks are quite repetitive, good candidate for building a function
- Limit gathering of files to archive on file extension (.txt, .log, etc), exclude containers.
- Proper logging
- email/slack notification on errors
- More intelligent month/year checking
- Deletion of archives over retention policy (well out of scope)
- More intelligent checks for sucessful log-shipping (well out of scope)