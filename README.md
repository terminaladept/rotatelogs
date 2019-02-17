# Simple Log rotate Powershell script

### About

A simple Powerhsell script to rotate log files. Adds desired files to an archive bsed on their lastwritendate. Then deletes the original file. Script is quick and dirty, doesn't handle errors intelligently.

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
    - Then delete file after added to archive
    <br>
    - If month doesn't match print a warning and skip archive and delete step

### Possible improvements
- Try/Catch on deletion before deletion
- Compress/Delete blocks are quite repetitive, good candidate for building a function
- Limit gathering of files to archive on file extension (.txt, .log, etc), exclude containers.
- Proper logging
- email/slack notification on errors
