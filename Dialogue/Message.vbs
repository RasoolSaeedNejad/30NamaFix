' Set Variables for use in this visual basic script file.
Dim Message, Status, statusFile, String1, String2, String3, Title

' Set Strings for msgbox to show Dialogue.
String1="Download failed!"
String2="Please close and reopen the 30Nama application"
String3="And start download again and then click Retry"
Title="30Nama Downloader"

' Main command for show Dialogue.
Message=msgbox(String1 & vbcrlf & String2 & vbcrlf & String3 ,5 + 16, Title)

' Set Variables for check status of result.
' If it is "Retry", it means the program must continue.
' And if it is "Cancel", it means the program will stop.
If Message=vbRetry Then
    Status="Retry "
Else
    Status="Cancel "
End If

' In this section, the status is stored in a file called "Status",
' And another program (30NamaFix) its information can be used.
Set objFSO=CreateObject("Scripting.FileSystemObject")
statusFile="Status"
Set objFile=objFSO.CreateTextFile(statusFile,True)
objFile.Write (Status)
objFile.Close