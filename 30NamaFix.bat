Rem 30Nama Downloader Fix Program.
Rem A program to notify the user when downloading through the 30nama program fails.
Rem Author: Rasool SaeedNejad
Rem https://Github.com/RasoolSaeedNejad
@echo off

:section1
Rem Description at the beginning of the program.
cls
echo.
echo  ================================================
echo  = Welcome to "30Nama Downloader Check" Program =
echo  ================================================
echo.
echo  This program helps you, if the internal download manager of 30Nama has an error,
echo  And shows you a message to close the 30Nama program and reopen it.
echo. 
echo  NOTE: You can use CTRL-C to close the program. Or close the window
echo.
echo  Author: Rasool SaeedNejad
echo  Email: RasoolSaeedNejad@gmail.com
echo  Source: https://github.com/RasoolSaeedNejad
echo. 
echo  ============ Status:
echo.

:section2
Rem Variable for loop.
set number=1
Rem The first part of the program.
Rem Default record 0 for the variable, Because the output variable may not be normal.
Rem Create loop and go to the third part of the program.
set cinemaPid=0
set cinemadlPid=0
set connectionPid=0
if %number% gtr 0 (goto :section3)

:section3
Rem The third part of the program.
Rem Obtain the PID of the 30nama program (30nama.exe).
for /f "tokens=2 delims= " %%a in ('tasklist ^| findstr 30nama.exe') do set cinemaPid=%%a
Rem If the 30nama program is not running,
Rem This program will not run either and will display a message to the user.
if %cinemaPid%== 0 (
    echo  WARNING: First run the 30Nama program and then use this program.
    echo.
    echo  Press any key to exit...
    pause > nul
    goto :eof
)

:section4
Rem Obtain the PID of the 30nama program (30Downloader.exe).
for /f "tokens=2 delims= " %%b in ('tasklist ^| findstr 30Downloader') do set cinemadlPid=%%b
Rem If the 30dowloader process has a problem and the download is interrupted,
Rem The program will notify the user.
Rem Display a message on the screen while playing audio.
Rem Otherwise Section 6 will run.
if %cinemadlPid%==0 (
    echo  %date% %time% - Download failed...
    Start /wait Dialogue\Message.vbs
    Rem Section 5 is related to this section (4). In fact, it is a continuation of the condition.
    goto :section5
) else (goto :section6)

:section5
Rem This section is related to the previous section.
Rem After displaying the message, that dialog has saved a status of its own,
Rem And this section examines that situation.
for /f "tokens=1" %%e in ('type Status') do set statusPid=%%e
del Status
echo  Checking...
if %statusPid%==Retry (
    Rem Section 7 is the last part of the program,
    Rem And its job is to re-run the program from the beginning (for the loop).
    goto :section7
) else (
    Rem If the user cancels the program after the message is displayed,
    Rem The program will be stopped.
    for /f "tokens=2" %%d in ('date /t') do echo  %%d %time% - Abort by User.
    echo.
    echo  Press any key to exit...
    pause > nul
    goto :eof
)

:section6
Rem This section displays the status of the various sections of the application.
for /f "tokens=5 delims= " %%c in ('netstat -no ^| findstr %cinemadlPid% ^| findstr :80') do set  connectionPid=%%c
Rem If everything is OK but no download occurs,
Rem It means there is no download or the user has stopped it.
if %connectionPid%==0 (
    for /f "tokens=2" %%d in ('date /t') do echo  %%d %time% - No download at this time.
    echo  Cheking...
) else (for /f "tokens=2" %%d in ('date /t') do echo  %%d %time% - Downloding...)

:section7
Rem The last section of the Program.
Rem The program waits 10 seconds each time and checks again.
Rem And at the end, it goes back to the loop (First section) and the program runs again.
timeout /t 10 > nul
goto :section1

Rem Draft:
Rem echo  Press any key to exit...
Rem pause > nul
Rem goto :eof