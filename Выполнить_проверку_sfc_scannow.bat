::�।�⢮ �஢�ન ��⥬��� 䠩��� �������� �஢���� ���ᨨ ��� ���饭��� 䠩���. 
::�᫨ �� �஢�થ ��⥬��� 䠩��� �����㦨������, �� ���饭�� 䠩� �� �������, � �� ��������� ��� ��室��� ���ᨥ�.

@echo off >nul
 Chcp 866 >nul
  title �஢�ઠ 楫��⭮�� ��⥬��� 䠩��� / 0.7.5  [ SafeZone.cc ]
   ::SetLocal EnableExtensions EnableDelayedExpansion 

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

	:: ���� �ਯ�: 
	:: setting: ����᪠�� ����ன�� setting,��।����騥 ����稥 �ࠢ,�맮� ���� � ��᫥���騥 ����樨
	::
	::
	::
	::
	::
	:: 
   
 :: ��६����:
cd /d %~dp0

set log=%windir%\Logs\CBS\sfcdoc.log
set log2=%windir%\Logs\CBS\sfcdoc2.log
set log3=%WinDir%\Logs\CBS\CheckSUR.log
set eventlog=%windir%\Logs\CBS\eventlog.log 
set dismlog=%windir%\Logs\DISM\dism.log
set cod86=chcp 866>nul
set cod12=chcp 1251>nul
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: ��뢠�� ��楤��� �஢�ન  ���ᨨ ��⥬�

call :veros
exit /b


	::��楤�� ���।������ ���ᨨ ��⥬� �  �맮�� ����樨,ᮮ⢥�����饩 �� 
	
:veros
   
SET Version=Unknown

VER | FINDSTR /IL "5.0" > NUL
IF %ERRORLEVEL% EQU 0 ( SET Version="Windows 2000" 
													call :XP) 

VER | FINDSTR /IL "5.1." > NUL
IF %ERRORLEVEL% EQU 0 ( SET Version="Windows XP" 
													call :XP) 

VER | FINDSTR /IL "5.2." > NUL
IF %ERRORLEVEL% EQU 0 ( SET Version="Windows 2003" 
													call :XP) 

VER | FINDSTR /IL "6.0." > NUL
IF %ERRORLEVEL% EQU 0 ( SET Version="Windows Vista" 
											set os=1 
												call :CheckAdmin
													call :os1 )	
VER | FINDSTR /IL "6.1." > NUL
IF %ERRORLEVEL% EQU 0 ( SET Version="Windows 7" 
											set os=1 
												call :CheckAdmin
													call :os1 )
												
VER | FINDSTR /IL "6.2." > NUL
IF %ERRORLEVEL% EQU 0 ( SET Version="Windows 8" 
											set os=0
												call :CheckAdmin
												  call :os0	)
																
VER | FINDSTR /IL "6.3." > NUL
IF %ERRORLEVEL% EQU 0 ( SET Version="Windows 8.1" 
											 set os=0
												call :CheckAdmin
												  call :os0	)						  
												  
												  
VER | FINDSTR /IL "6.4." > NUL
IF %ERRORLEVEL% EQU 0 ( SET Version="Windows 10" 
											 set os=0
												call :CheckAdmin
												  call :os0	)
												  

VER | FINDSTR /IL "10.0." > NUL
IF %ERRORLEVEL% EQU 0 ( SET Version="Windows 10" 
											 set os=0
												call :CheckAdmin
												  call :os0	)					  


												  
exit /b 





 :: �஢��塞 �� ����� �� ���� �� ������⢨� �ࠢ ����㯠 � ����� CBS\CBS
 
 
 :TestElevate
	echo. >> "%log%"  && (echo ...���� �ࠢ� ����㯠 � ��� 䠩���... >> %log%
	echo. > "%log2%"	) || (
	set log=%tmp%\sfcdoc.log
	set log2=%tmp%\sfcdoc2.log
		echo. >> "%log%"
		echo. >> "%log%"
		echo  ===TestElevate=== > "%log%"
		echo  ===TestElevate=== > "%log%2"
		echo  ===TestElevate===
		echo �஢�ઠ ����㯠 � 䠩��� ����� >> "%log%"
		echo �����㦥�� ������⢨� �ࠢ ����㯠 � ��⠫��� %windir%\Logs\CBS, �㤥� �����祭 �६���� ��⠫�� >> "%log%"
		echo. >> "%log%"
		cls)
		
 exit /b 
 
 
 :CheckAdmin
IF EXIST "%ProgramFiles(x86)%" (set arhitektura=64) else (set arhitektura=32)
net continue winmgmt 2>&1 |>NUL find "5" && (
	echo .........sfco ErrorLevel[ %ErrorLevel% ].........��� �ࠢ ����㯠!
    Echo �ॡ����� �ࠢ� �����������.
    Echo.
    echo ����室��� �������� �業�਩ �� ����� �����������
    echo �ࠢ�� ������� ��� �� 䠩�� - �㭪� 
	echo "�������� �� ����� �����������"
    echo.
    echo ��� ��室� ������ ������� ENTER
    pause>nul
	goto Exite
) || (
   > "%log%" (
	
    echo.
    echo ::::::::  %Userprofile%  
    echo ::::::::  %DATE%  / %TIME%
    echo ::::::::  %VERSION%  / ���⥪���: %arhitektura%
	echo ::::::::  ����� �ਯ� / 0.7.5 [15.12.2018]
	echo ::::::::  SafeZone.cc
    echo.
    echo.
    echo :::::::::::::::::::::::::::::::::::::::::::::::::::::
    echo.
    echo ... �ࠢ� ����������� ����祭�...
	echo .........sfco ErrorLevel [ %ErrorLevel% ] 
	echo.
	echo ......����騩 ��⠫��:  %cd% ......
	)
)			
	call :TestElevate
exit /b 
 
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

 
 
										
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

 
:os1

cls
echo ��� �롮� ������ ���� � ������ ������� ENTER
echo.
echo.

call :choice "�������� �⠭������ �஢���" "�������� ���७��� ��楤��� �஢�ન � ᡮ� �����" "������ १����� ��᫥����� ᪠��஢����" "��ࠢ��" "��室" 

if %ErrorLevel% EQU 1 ( Call :sfco
							call :open 
								call :os1 )

if %ErrorLevel% EQU 2 ( call :Restorehealth1
							Call :sfco 
								call :pcinfo
									call :open 
										call :os1 )
																		
if %ErrorLevel% EQU 3 ( Call :findstrlog 
							call :pcinfo
								call :open 
									call :os1 )

if %ErrorLevel% EQU 4 ( Call :Help 
							call :os1 )

if %ErrorLevel% EQU 6 ( Call :Exite ) 

exit /b


:os0
		
cls	
echo ��� �롮� ������ ���� � ������ ������� ENTER
echo.
echo.
		
set options="�������� �⠭������ �஢���" "�������� ���७��� ��楤��� �஢�ન � ����⠭�������" "������ �࠭���� ��������⮢"

if exist %log% (
    set options=%options% "������ १����� ��᫥����� ᪠��஢����"
)

set options=%options% "��ࠢ��" "��室"

call :choice %options%

if %ErrorLevel% EQU 1 ( Call :sfco
							call :open 
								call :os0 )
									
if %ErrorLevel% EQU 2 ( call :Restorehealth  
							Call :sfco 
							    call :pcinfo
									call :open 
										call :os0 )
if %ErrorLevel% EQU 3 ( Call :Clearhealth 
								call :os0 )

if exist %log% (
    if %ErrorLevel% EQU 4 (
							Call :findstrlog 
							call :pcinfo 
							call :open 
							call :os0 
						)
					)

if %ErrorLevel% EQU 5 ( Call :Help 
								call :os0 )

if %ErrorLevel% EQU 6 ( Call :Exite ) 						 
										
exit /b




:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 


:sfco

echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: >>"%log%"
Echo. >>"%log%"
echo ------ SFCDoc parsing (start process) ------ >>"%log%"
cls
Echo.
Echo ��������!
Echo.
Echo ����� �㤥� ����饭� �஢�ઠ ��⥬��� 䠩��� �� 楫��⭮���.
Echo �� �몫�砩� �������� � �� ����뢠�� ���� ���᮫� 
echo ���� �� ��������� �஢�ઠ.
echo.
tasklist | find /i "TiWorker.exe"  >nul
if %errorlevel% EQU = 0 ( taskkill /f /im "TiWorker.exe" 
   ( 
>>"%log%" (
echo ......... �����襭�� ����� TiWorker.exe [ 0 ] [ �ᯥ� ] 
echo ......... ErrorLevel[ %ErrorLevel% ] 
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: 
echo.
	)
	 )
	  )
sfc/scannow
echo .........sfco ErrorLevel [ %ErrorLevel% ] >>"%log%"
Echo. >>"%log%"
Echo. >>"%log%"
echo �஢�ઠ �����襭�.
Echo �஢�ઠ �����襭� >>"%log%"
echo.
echo.
call :findstrlog

exit /b



:findstrlog

cls
echo ����騩 ��⠫�� %cd%
Echo. >>"%log%"
Echo. >>"%log%"
:: ��������
copy /y %windir%\Logs\CBS\CBS.LOG CBS.LOG 
< "CBS.LOG" find /i "[SR]" | find /v /i "[SR] Verify complete" | find /v /i "[SR] Verifying 100" | find /v /i "[SR] Beginning Verify and Repair transaction" >>"%log%"


Echo. >>"%log%"
Echo. >>"%log%"
echo .........find ErrorLevel[ %ErrorLevel% ] >>"%log%"

Echo �ᯮ�짮���� �������⥫�� ��ࠬ����: >>"%log%"
Echo. >>"%log%"
Echo. >>"%log%"
type "%log2%" >>"%log%" 
if %os% EQU 1 type "%log3%" >>"%log%" 
exit /b

:pcinfo

echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: >>"%log%"
Echo. >>"%log%"
Echo. >>"%log%"
Echo ����஫�� �窨 ����⠭�������: >>"%log%"
Echo. >>"%log%"
wmic shadowcopy get InstallDate /value | find "." >>"%log%"
Echo. >>"%log%"
Echo. >>"%log%"
echo �������� � ��: >>"%log%" 
Echo. >>"%log%"

SYSTEMINFO /FO LIST >>"%log%"   
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: >>"%log%"    

wmic qfe list > t
chcp 866 >NUL
cmd /d /a /c type t >>"%log%"
del t

exit /b


:open

copy /y %windir%\Logs\CBS\sfcdoc.log sfcdoc.log
Echo. >>"%log%"
explorer.exe %~dp0
Echo ......����⨥ �����... >>"%log%"
Echo. >>"%log%"
Echo. >>"%log%"
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: >>"%log%"
Echo. >>"%log%"
echo SafeZone.cc , @ ��ਫ� >>"%log%" 
Echo. >>"%log%"                                
echo ������ ��ன� ����� � 䠩��� ���� [ %CD% ]
echo �᫨ ��� �� ���뫠�� ��⮬���᪨.
echo �ਪ९�� 䠩�� sfcdoc.log � CBS.log �� ��� � ��襬� ᮮ�饭��,
echo �᫨ ��� �㦭� ������ � ������� ����� ��� ����⠭�������
echo ���०������ ��⥬��� 䠩���.
echo.
echo ����� 䠩��� ��室���� ⠪�� � ��⠫���: 
echo %windir%\Logs\CBS
echo.
:: ������ "����" ���� �ணࠬ��� ��-㬮�砭��
start "" "%CD%"
start "" "sfcdoc.log"
del /q %log%
del /q %log2%
echo ������ ������� ENTER �⮡� �த������...
pause > nul
exit /b

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::   
	
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::							 
								 
:XP
echo ����� ��襩 ����樮���� ��⥬�: %VERSION%
for %%i in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%i:\WIN51 set CDROM=%%i:
if not exist %cdrom%\win51.* (
 echo. 
  echo.
   echo.
    cls
     echo ��� ����室��� ��⠢��� ��� � ��襩 ������ Windows 
      echo ���� ᬮ��஢��� ��ࠧ ��᪠ � ����㠫�� �ਢ��.& call :cdopen
       ) else (call :koz)

exit /b
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::	

:cdopen 
  set m.msg=^
  �� - ��� � Windows ��⠢��� (��� ��ࠧ ᬮ��஢��)^&^
  ��� - ��室 �� �ணࠬ�� (�� ��᪠ �� ��ࠧ� ���)
 
  cmd /U /C echo Wscript.Echo Msgbox^(replace^(Wscript.Arguments^(0^),"&",vbLF^),67,"�஢�ઠ ��᪠"^)>"msgbox.vbs"
  for /f %%a in ('cscript "msgbox.vbs" "%m.msg%"^& del "msgbox.vbs"') do set err=%%a
  if "%err%"=="2"  call :Exite
  if "%err%"=="6"  call :XP
  if "%err%"=="7"  call :Exite
 call :Exite
 
 exit /b

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 
 
:koz
   echo.
   echo.
   echo ���࠭�� १�ࢭ�� ����� ॥���...
   reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup" %systemdrive%\install.reg
   echo.
   echo ��⠭������� ���祭�� ॥���...
   echo.
   echo ����ਡ�⨢ �����㦥�...
   reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup" /v ServicePackSourcePath /t reg_sz /d %cdrom%\ /f
   reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup" /v "Installation Sources" /t reg_sz /d %cdrom%\ /f
   reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup" /v SourcePath /t reg_sz /d %cdrom%\ /f
   sfc/scannow
   reg import %systemdrive%\install.reg 
   del /q %systemdrive%\install.reg 
   echo.
   echo.
   ping -n 5 127.0.0.1 > NUL
   cls
   echo �஢�ઠ 楫��⭮�� ��⥬��� 䠩��� ����.
   echo �������� ����砭�� �஢�ન.
   md %windir%\Logs\CBS
   wevtutil qe Application /q:*[System[(EventID=64021)]] /f:text /rd:true /c:2 >>"%log%"
   SYSTEMINFO /FO LIST >>"%log%" 
   :: ������ "����" ���� �ணࠬ��� ��-㬮�砭��
	rundll32 shell32.dll,ShellExec_RunDLL "%log%"
	Echo. >>"%log%"
	explorer.exe %~dp0
   ping -n 15 127.0.0.1 > NUL
   call :Exite
exit /b
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

					 
						
						
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: �業�� ���ﭨ� �࠭���� ��������⮢ �� �।��� ���०�����

:recbd

tasklist | find /i "TiWorker.exe"  >nul
if %errorlevel% EQU = 0 ( taskkill /f /im "TiWorker.exe" 
   ( 
>"%log2%" (
echo ......... �����襭�� ����� TiWorker.exe [ 0 ] [ �ᯥ� ] 
echo ......... ErrorLevel[ %ErrorLevel% ] 
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: 
echo. 
echo. 
echo. 
echo ... �஢�ઠ �࠭���� ������ ...  
echo. 
	) 
	 )
	  )
cls
echo ...�஢���� ���ﭨ� �࠭���� ������...
echo.
echo.


echo ...... �஢�ઠ ���ﭨ� ��������⮢ �࠭���� >>"%log2%"
    Dism /Online /Cleanup-Image /CheckHealth
		echo ......... ErrorLevel[ %ErrorLevel% ] >>"%log2%"
		if %ErrorLevel% EQU 0 (
		echo ......... ���०����� �࠭���� ��������⮢ �� �����㦥�� >>"%log2%"
		) else ( 
		echo. >>"%log2%"
		echo ...... �����㦥�� ���०����� �࠭���� ��������⮢ >>"%log2%" 
		)
exit /b		


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: �業�� ���ﭨ� �࠭���� ��������⮢ �� �।��� ����室����� ���⪨

:Clearanalize		
		
echo. >"%log2%"
echo. >>"%log2%"
echo.
echo.
echo ��楤�� ����� ������� �� 10 �����.
echo �������...
echo.
echo.
echo ...... �業�� ᢮������� ���� �࠭����...
echo ...... �業�� ᢮������� ���� �࠭����... >>"%log2%"
	Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore >>"%log2%"
		echo ......... ErrorLevel[ %ErrorLevel% ] >>"%log%"
		if %ErrorLevel% EQU 0 (
		echo ......... �ॡ���� ���⪠ WinSxS >>"%log2%" 
		) else ( echo ......... ���⪠ WinSxS �� �ॡ���� >>"%log2%"  )
		
echo.
echo.
echo. >>"%log2%"
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: >>"%log2%" 
echo. >>"%log2%" 
echo. >>"%log2%" 
echo ::::::::  %DATE%  / %TIME% >>"%log2%"
exit /b
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:Restorehealth

cls
echo ����...
echo.
echo.
echo ...... ��楤�� ����⠭������� �࠭����...
echo ......... ��楤�� ����⠭������� �࠭����... >"%log2%" 
	Dism.exe /Online /Cleanup-Image /Restorehealth 
	
		echo ......... ErrorLevel[ %ErrorLevel% ] >>"%log2%"
		if %ErrorLevel% EQU 0 (
		echo ......... ����⠭������� ��������⮢ �࠭���� �����襭� ���४⭮ >>"%log2%"		
		) else (
		echo ����⠭������� �࠭���� ������ ��諮 �����४⭮.
		echo ������ � �஡���� ᯥ樠���⠬ SafeZone 
		echo ......... ����⠭������� ��������⮢ �࠭���� �����襭� �� ���४⭮ >>"%log2%" )
		
	
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: >>"%log2%" 
echo. >>"%log2%" 
echo. >>"%log2%" 
echo  >>"%log2%" 
echo ::::::::  %DATE%  / %TIME% >>"%log2%"
echo ������ ������� ENTER �⮡� �த������
pause > nul
exit /b

:Restorehealth1

echo.
		echo �������...
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" /f  "KB2966583" /k

	if %ErrorLevel% EQU 0 (
		cls 
			echo ����� �㤥� �ந������� ����⠭������� �࠭���� ��������⮢ Windows
			echo ��������, �� �� ������祭� � �� ���୥� � �������� �����襭�� 
			echo ����樨 ����⠭�������
				DISM /Online /Cleanup-Image /ScanHealth
					(if %ErrorLevel% EQU 0 (
						echo ����⠭������� �࠭���� ������ ��諮 ���४⭮.
						echo ......... ����⠭������� ��������⮢ �࠭���� �����襭� ���४⭮ >>"%log2%"		
							) else ( echo ......... ����⠭������� ��������⮢ �࠭���� �����襭� �� ���४⭮ >>"%log2%" ))
		)  else (
			
			cls
			echo.
			echo ��� ����᪠ ��楤��� ����⠭������� ����室��� ��⠭����� ��������� KB2966583
			echo �������� ��뫪�, �᫨ ��࠭�� ����㧪� �� ���뫠�� ��⮬���᪨
			echo ��ன� � ��㧥� � ᪠砩�, ��⥬ �ந������ ��⠭����
			echo ��᫥ ��⠭���� ���������� ��१���㧨� �������� � ������ ��ᯮ������ 
			echo ����� �ਯ⮬.
			echo.
			
				(if %arhitektura% EQU 32 (
					start https://www.microsoft.com/ru-RU/download/details.aspx?id=43524
						echo https://www.microsoft.com/ru-RU/download/details.aspx?id=43524
						echo ......... ��������! �� ��⠭������ ���������� KB2966583 >>"%log2%" 
						echo ......... https://www.microsoft.com/ru-RU/download/details.aspx?id=43524 >>"%log2%" 
						echo.
						pause
					Call :Exite	
				) else (
					start https://www.microsoft.com/ru-RU/download/details.aspx?id=43484
						echo https://www.microsoft.com/ru-RU/download/details.aspx?id=43484
						echo ......... ��������! �� ��⠭������ ���������� KB2966583 >>"%log2%" 
						echo ......... https://www.microsoft.com/ru-RU/download/details.aspx?id=43524 >>"%log2%" )) 
						echo.
						pause
					Call :Exite
				)
		pause
		exit /b

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ���⪠ �࠭���� ��������⮢

:Clearhealth

cls
tasklist | find /i "TiWorker.exe"  >nul
if %errorlevel% EQU = 0 ( taskkill /f /im "TiWorker.exe" 
   ( 
>"%log2%" (
echo ......... �����襭�� ����� TiWorker.exe [ 0 ] [ �ᯥ� ] 
echo ......... ErrorLevel[ %ErrorLevel% ] 
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: 
echo. 
	) 
	 )
	  )
echo ����...
echo.
echo.
echo ...... ��楤�� ���⪨ �࠭����...
echo ......... ��楤�� ���⪨ �࠭����... >>"%log2%" 
	Dism.exe /Online /Cleanup-Image /StartComponentCleanup 
		echo ......... ErrorLevel[ %ErrorLevel% ] >>"%log2%"
		if %ErrorLevel% EQU 0 (
		echo ......... ���⪠ �࠭���� �����襭� ���४⭮ >>"%log2%"		
		) else (
		echo ��楤�� ���⪨ �࠭���� ������ ��諮 �����४⭮.
		echo ������ � �஡���� ᯥ樠���⠬ SafeZone 
		echo .........��楤�� ���⪨ �࠭���� ��������⮢ �����襭� �� ���४⭮ >>"%log2%" )
		
	
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: >>"%log2%" 
echo. >>"%log2%" 
echo. >>"%log2%"
echo ::::::::  %DATE%  / %TIME% >>"%log2%"
echo ������ ������� ENTER �⮡� �த������
pause > nul
exit /b

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::  

:: ����᪠�� ������ ᮧ����� �窨 ����⠭������� ��� ����⠭������� ��⥬�
:SystemRestore
 rundll32.exe shell32.dll,Control_RunDLL sysdm.cpl,,4
exit /b 


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::FixIt Easy List::
:FixIt
cls
echo.
echo ����� ��������� ��㧥� �� 㬮�砭�� � ��࠭�� ����㧪�
echo �।�⢠ ���࠭���� ��������� Windows FixItEasy.
echo ���⢥न� ������ ����㧪�, �᫨ ���ॡ����
echo � ������� ᪠砭�� 䠩�. �� �����襭�� ����樨 
echo 㡥�����, �� �஡���� ���࠭���.
echo �᫨ �� �� ⠪, � � ���� �।�⢠ FixItEasy �� ��᫥����
echo �⠯� ������ ��뫪� "��ᬮ���� �������⥫�� ��ࠬ����"
echo ��⥬ �뤥��� ��誮� ⥪�� 㪠������ �஡����, �������
echo � ����� �������⨪� � ᪮����� ��᫥����⥫�� ����⨥� 
echo ������ ^( ���� Ctrl � ������ � ^), ��⥬ ��⠢�� 
echo ᪮��஢���� ⠪�� ��ࠧ�� ⥪�� � ᮮ�饭�� ��� ⥪�⮢� 
echo 䠩�, �⮡� �������� ��� ⥬, �� ������� ࠧ�������, �᫨ 
echo �� ���� �� ᬮ��� �⮣� ᤥ���� ᠬ����⥫쭮.
pause

set UrlKey=UrlKey
:: ���࠭���� ���������, ����� ����� ����� �ࠢ��쭮� ࠡ�� �ਫ������ �� Microsoft Store 101
	if %zero% EQU 101 ( set UrlKey=http://aka.ms/diag_apps10 ) 
	
::���� � ��ࠢ����� �஡��� � ���ந��������� ��㪠 102
	if %zero% EQU 102 ( set UrlKey=http://aka.ms/diag_audio10 )

::���� � ��ࠢ����� �஡��� � ������� ��㪠 103	
	if %zero% EQU 103 ( set UrlKey=http://aka.ms/diag_audio10r ) 

::���� � ��ࠢ����� �஡���, ����� ����� ����� �믮������ 䮭����� ᪠稢���� 䠩��� 104
	if %zero% EQU 104 ( set UrlKey=http://aka.ms/diag_bits10 ) 

::���࠭���� �஡��� � ���ன�⢠�� � �ਭ�ࠬ� 105
	if %zero% EQU 105 ( set UrlKey=http://aka.ms/diag_devicec ) 

::���� � ���࠭���� �஡��� � ����㤮������ � ���ன�⢠�� 106
	if %zero% EQU 106 ( set UrlKey=http://aka.ms/diag_device ) 

::���� � ���࠭���� �஡��� � �ந�����⥫쭮���� Internet Explorer 107
	if %zero% EQU 107 ( set UrlKey=http://aka.ms/diag_iebrowser ) 

::���� � ���࠭���� �஡��� � �।�⢠�� ������᭮�� � ���䨤��樠�쭮�� � Internet Explorer 108	
	if %zero% EQU 108 ( set UrlKey=http://aka.ms/diag_iesecurity10 ) 

::���� � ���⪠ ���ᯮ��㥬�� 䠩��� � ��몮�, � ⠪�� �믮������ ����� �� ���㦨����� 109
	if %zero% EQU 109 ( set UrlKey=http://aka.ms/diag_maintenance10 ) 

::���� � ��ࠢ����� �஡��� � ������祭��� � ���୥�� ��� ���-ᠩ⠬ 110
	if %zero% EQU 110 ( set UrlKey=http://aka.ms/diag_networking10 ) 

::���� � ���࠭���� �஡��� � ����㯮� � 䠩��� � ������ �� ��㣨� ��������� 111
	if %zero% EQU 111 ( set UrlKey=http://aka.ms/diag_networking10 ) 

::���� � ���࠭���� �஡��� � ��ᬮ�஬ �������஢ ��� ���� 䠩��� � ����譥� ��㯯� 112	
	if %zero% EQU 112 ( set UrlKey=http://aka.ms/diag_networking10 ) 

::���� � ���࠭���� �஡��� � ���஢���묨 � ��㣨�� �⥢묨 �����ࠬ� 113
	if %zero% EQU 113 ( set UrlKey=http://aka.ms/diag_networking10 ) 

::���� � ���࠭���� �஡��� � �室�騬� ������祭�ﬨ �������஢ � �࠭�����஬ Windows 114
	if %zero% EQU 114 ( set UrlKey=http://aka.ms/diag_networking10 ) 

::���� � ���࠭���� �஡��� � ������祭��� � ࠡ�祩 �� � ������� DirectAccess 115
	if %zero% EQU 115 ( set UrlKey=http://aka.ms/diag_networking10 ) 

::���� � ���࠭���� �஡��� � ����᪮� ����� �ணࠬ� � �⮩ ���ᨨ Windows 116
	if %zero% EQU 116 ( set UrlKey=http://aka.ms/diag_pcw10 ) 

::���� � ���࠭���� �஡��� ��� ��⨬���樨 ����த���⢨� � �ந�����⥫쭮�� Windows 117
	if %zero% EQU 117 ( set UrlKey=http://aka.ms/diag_performance10 ) 

::���� � ���࠭���� �஡��� � ��ࠬ��ࠬ� ���ய�⠭�� �������� ��� �࣮ᡥ०���� � 㢥��祭�� �६��� ࠡ��� ���२ 118
	if %zero% EQU 118 ( set UrlKey=http://aka.ms/diag_power10 ) 

::���� � ���࠭���� �஡��� � ������ 119
	if %zero% EQU 119 ( set UrlKey=http://aka.ms/diag_printer10 ) 

::���� � ���࠭���� �஡��� �㦡� Windows Search 120
	if %zero% EQU 120 ( set UrlKey=http://aka.ms/diag_search10 ) 

::���� � ���࠭���� �஡��� � ���ந��������� 䨫쬮�, ⥫���।�� � ����� 121
	if %zero% EQU 121 ( set UrlKey=http://aka.ms/diag_video10 ) 

::���� � ���࠭���� �஡��� � ��ࠬ��ࠬ� �ந��뢠⥫� Windows Media 122
	if %zero% EQU 122 ( set UrlKey=http://aka.ms/diag_wmpc10 ) 

::���� � ���࠭���� �஡��� � ������⥪�� �ந��뢠⥫� Windows Media 123
	if %zero% EQU 123 ( set UrlKey=http://aka.ms/diag_wmpl10 ) 

::���� � ���࠭���� �஡��� � ���ந��������� DVD-��᪮� � �ந��뢠⥫� Windows Media 124
	if %zero% EQU 124 ( set UrlKey=http://aka.ms/diag_wmpdvd10 )

::���࠭���� �訡�� ����� ���������� Windows 125
	if %zero% EQU 125 ( 
						if %Version%=="Windows 7" ( set UrlKey=http://aka.ms/diag_wu ) 
							if %Version%=="Windows 8" ( set UrlKey=https://aka.ms/diag_wu )
								if %Version%=="Windows 10" ( set UrlKey=https://aka.ms/wudiag )
									if %Version%=="Windows 8.1" ( echo ����㧨� � ��⠭���� �� ����������:
										echo https://support.microsoft.com/ru-ru/help/3173424/servicing-stack-update-for-windows-8-1-and-windows-server-2012-r2-july 
											set UrlKey=https://support.microsoft.com/ru-ru/help/3173424/servicing-stack-update-for-windows-8-1-and-windows-server-2012-r2-july
												echo. )
														)
	
start %UrlKey%
echo.
echo �᫨ ����ᮢ �� �������, � ����� �������
echo �� ����, ����� ���� �������...
pause
exit /b

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


::FixIt Easy List Local::
::FixIt ����� ���஥����� � ��⥬� �।�⢠::

:FixItLocal
cls
echo.
echo ����� ��������� �।�⢮ ���࠭���� ���������.
echo ������ �������� � ���᪠���� ��  
echo ��᫥����� �⠯�.
echo �� ��᫥���� �⠯� ������ ��뫪� 
echo "��ᬮ���� �������⥫�� ��ࠬ����"
echo ��⥬ �뤥��� ��誮� ⥪�� 㪠������ �஡����, �������
echo � ����� �������⨪� � ᪮����� ��᫥����⥫�� ����⨥� 
echo ������ ^( ���� Ctrl � ������ � ^), ��⥬ ��⠢�� 
echo ᪮��஢���� ⠪�� ��ࠧ�� ⥪�� � ᮮ�饭�� ��� ⥪�⮢� 
echo 䠩�, �⮡� �������� ��� ⥬, �� ������� ࠧ�������, �᫨ 
echo �� ���� �� ᬮ��� �⮣� ᤥ���� ᠬ����⥫쭮.
pause


:: 201 ���࠭���� ���������, �⮡ࠦ���� ��䥪�� Aero, ⠪�� ��� �஧�筮���. �ॡ���� ����稥 Windows Aero 
:: /Windows 7; /

	if %zero% EQU 201 ( msdt /id AeroDiagnostic ) 
	
:: 202 ���࠭���� ���������, �易���� � ������祭��� � �� �� ࠡ�祬 ���� �१ ���୥� � ������� DirectAccess.
:: �ॡ���� ��⠭������� directaccess 
:: /Windows 7; 8; 8.1; 10; RT; Server 2008 + 2012 /

	if %zero% EQU 202 ( msdt /id NetworkDiagnosticsDA )

:: 203 ���࠭���� ��������� � �ᯮ�짮������ �������� �।�� � ���ன�� ����㯠, ������祭��� � ���������.	
:: ����� �ᯮ�짮���� ��� �������⨪� �� �।��� ����⠭�������� ��� �ਢ�� �ࠩ��஢
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 203 ( msdt /id DeviceDiagnostic ) 

:: 204 ���࠭���� ��������� �� ��ᬮ�� �������஢ ��� ���� 䠩��� � ����譥� ��㯯�.
::�� Windows ������� ��㯯� ������ ���� ����஥�� 
:: /Windows 7; 8; 8.1; 10; RT; /	
	
	if %zero% EQU 204 ( msdt /id HomeGroupDiagnostic ) 

:: 205 ���࠭���� ���������, ���������� ��㣨� �������ࠬ ����������⢮���� � 楫��� �������஬ �१ �࠭������ Windows.
:: /Windows 7; 8; 8.1; RT; Server 2008 + 2012 /

	if %zero% EQU 205 ( msdt /id NetworkDiagnosticsInbound ) 

:: 206 ���࠭���� ��������� �� ������祭�� � ���୥�� ��� �� ��।������� ���-ᠩ�.
:: /Windows 7; 8; 8.1; RT; Server 2008 + 2012 /

	if %zero% EQU 206 ( msdt /id NetworkDiagnosticsWeb ) 

:: 207 �������� ���짮��⥫� �।������ �������⥫�� �஡���� � ��⨬���஢��� �६���� 䠩�� � ������祭��.
:: �ॡ���� ��⠭������� Internet Explorer 
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 207 ( msdt /id IEBrowseWebDiagnostic ) 

:: 208 �������� ���짮��⥫� �।������ �।���᭮� ��, �ᯫ뢠�騥 ���� � ������-�⠪�.
:: �ॡ���� ��⠭������� Internet Explorer 
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 208 ( msdt /id IESecurityDiagnostic ) 

:: 209 ���࠭���� ��������� � Ethernet, ���஢���묨 ��� ��㣨�� �⥢묨 �����ࠬ�.
:: /Windows 7; 8; 8.1; RT; /

	if %zero% EQU 209 ( msdt /id NetworkDiagnosticsNetworkAdapter ) 

:: 210 �������� ���짮��⥫� ����ந�� ��ࠬ���� ��� ����襭�� ᪮��� � �ந�����⥫쭮�� ����樮���� ��⥬�.
:: /Windows 7; /

	if %zero% EQU 210 ( msdt /id PerformanceDiagnostic ) 

:: 211 ���࠭���� ��������� �� ���ந�������� ��㪮� � ��㣨� �㤨�䠩���.
:: ��� Windows ������ ���� ��⠭������ ���ன�⢮ �뢮�� �㤨�ᨣ����
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 211 ( msdt /id AudioPlaybackDiagnostic ) 

:: 212 ���࠭���� ��������� �� ����.
:: /Windows 7; 8; 8.1; RT; /

	if %zero% EQU 212 ( msdt /id PrinterDiagnostic ) 

:: 213 �������� ���짮��⥫� ����ந�� ���� �ணࠬ��, �⮡� ��� ����� ����᪠���� � ⥪�饩 ���ᨨ Windows.
:: /Windows 7; 8; 8.1; 10; RT; Server 2008 + 2012/

	if %zero% EQU 213 ( msdt /id PCWDiagnostic ) 

:: 214 ���࠭���� ��������� �� ����� ��㪠 � ����䮭� ��� ��㣮�� ���筨��.
:: ��⠭������ ���ன�⢮ ����� �㤨�
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 214 ( msdt /id AudioRecordingDiagnostic ) 

:: 215 ���࠭���� ��������� �� ���᪥ � ������஢���� � ������� Windows Search.
:: ���� � ������஢���� ������ ���� ����祭�
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 215 ( msdt /id SearchDiagnostic ) 

:: 216 ���࠭���� ���������, �易���� � ����㯮� � ��騬 䠩��� � ������ �� ��㣨� ��������� �� ��.
:: /Windows 7; 8; 8.1; 10; RT; Server 2008 + 2012/

	if %zero% EQU 216 ( msdt /id NetworkDiagnosticsFileShare ) 

:: 217 �������⨪� � �।���饭�� ��������� �� ��������
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 217 ( msdt /id MaintenanceDiagnostic ) 

:: 218 ���࠭���� ���������, ����� �� ��������� Windows Update �믮����� ����� ����������.
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 218 ( msdt /id WindowsUpdateDiagnostic ) 


echo.
echo �᫨ ����ᮢ �� �������, � ����� �������
echo �� ����, ����� ���� �������...
pause >nul
exit /b


	   
:Help
cls


if %os% EQU 1 (
echo :::::::::::: %Version% :::::::::::::
echo.
echo �� ������ ����⠭�������� ��� �業�਩ ?
echo.
echo ����� ���饭��� ��⥬��� 䠫��, ����室���� ���
echo ��ଠ�쭮� ࠡ��� Windows � �� ��������⮢.
echo � ��砥, �᫨ �� �� �⮣� �஢�ન ����稫� 
echo ᮮ�饭�� ��������� ⠪���:
echo "���� ����ᮢ Windows �����㦨�� ����襭�� 
echo 楫��⭮�� ��⥬��� 䠩���, �� �� ����� 
echo ����⠭����� ������� �� ���"
echo �����, 䠩� ���०��� ��� � ��⥬��� ��⠫����, 
echo ⠪ � � �࠭���� ��������⮢.
echo �� ����� ��������� ��稭�� �������� �஡��� �
echo ࠡ�� ��⥬� ��� �ਫ������, �᫨ ⠪��� 
echo �஡���� �������. �᫨ � ��� ��� ��४���� � ࠡ��
echo ��襩 ����樮���� ��⥬�, � ����� �� 
echo �����稢����� � ����⠭�������� ��室��� 䠩���,
echo ⠪ ��� �� �� ⠪ � ����.
echo. 
echo �᫨ �� �� �� �訫��� ���������� � ����⠭�����
echo �� ��� ��������, � ��� ����室��� ��ᬮ���� 
echo ���ଠ�� � ⮬, ����� �����⭮ 䠩�� ���०����.
echo ��� �⮣� ��� ����������� ������ 䠩�� 
echo sfcdoc.log � cbs.log
echo �᫨ �� ���뫨 �� 䠩��, � �� ᮢᥬ ���﫨 �� 
echo ⠬ ᬮ����, � � ����ᠫ ��� � ������ 
echo ��� ⠪�� �����⥫��� �����-�ࠢ��:
echo.
echo �᫨ � ��᫥ ���⥭�� ������樨 ��� �� ࠢ�� 
echo �� ����⭮ ��� ��� ���ॢ��� ����,� �� �����
echo �������� �� ������� � ��� �� ��� safezone.cc �
echo �� ��� ������� ᮢ��襭�� ��ᯫ�⭮. 
echo �㪢��쭮 �� ᯠᨡ�.
echo ������, �� ����� ���ᨨ ����⠭����������� ���� 
echo 䠩�� ������ ᮮ⢥�⢮���� ���㠫쭮� ���ᨨ,
echo ����� ����� ���� ��������� ��।�� �����������,
echo ���⮬� �⮨� ���� ᮮ⢥������� ����� ��*****
echo �� ᠩ� microsoft � ��ᬮ���� ����� ����� 䠩�� ��� �㦭�.
echo ���祭� ��⠭�������� ����������� �� ⠪ �� �����
echo 㢨���� � 䠩�� sfcdoc.log ��᫥ �⠭���⭮� �஢�ન.
echo ���ᨡ� �� �������� � �ᯥ客^!)



if %os% EQU 0 ( 
echo :::::::::::: %Version% :::::::::::::
echo.
echo �� ������ ����⠭�������� ��� �業�਩ ?
echo.
echo ����� ���饭��� ��⥬��� 䠫��, ����室���� ���
echo ��ଠ�쭮� ࠡ��� Windows � �� ��������⮢.
echo � ��砥, �᫨ �� �� �⮣� �஢�ન ����稫� 
echo ᮮ�饭�� ��������� ⠪���:
echo "���� ����ᮢ Windows �����㦨�� ����襭�� 
echo 楫��⭮�� ��⥬��� 䠩���, �� �� ����� 
echo ����⠭����� ������� �� ���"
echo �����, 䠩� ���०��� ��� � ��⥬��� ��⠫����, 
echo ⠪ � � �࠭���� ��������⮢.
echo �� ����� ��������� ��稭�� �������� �஡��� �
echo ࠡ�� ��⥬� ��� �ਫ������, �᫨ ⠪��� 
echo �஡���� �������. �᫨ � ��� ��� ��४���� � ࠡ��
echo ��襩 ����樮���� ��⥬�, � ����� �� 
echo �����稢����� � ����⠭�������� ��室��� 䠩���,
echo ⠪ ��� �� �� ⠪ � ����.
echo. 
echo �᫨ �� �� �� �訫��� ���������� � ����⠭�����
echo �� ��� ��������, � ��� ����室��� ��ᬮ���� 
echo ���ଠ�� � ⮬, ����� �����⭮ 䠩�� ���०����.
echo ��� �⮣� ��� ����������� ������ 䠩�� 
echo sfcdoc.log � cbs.log
echo �᫨ �� ���뫨 �� 䠩��, � �� ᮢᥬ ���﫨 �� 
echo ⠬ ᬮ����, � � ����ᠫ ��� � ������ 
echo ��� ⠪�� �����⥫��� �����-�ࠢ��:
echo.
echo �᫨ � ��᫥ ���⥭�� ������樨 ��� �� ࠢ�� 
echo �� ����⭮ ��� ��� ���ॢ��� ����,� �� �����
echo �������� �� ������� � ��� �� ��� safezone.cc �
echo �� ��� ������� ᮢ��襭�� ��ᯫ�⭮. 
echo �㪢��쭮 �� ᯠᨡ�.
echo ������, �� ����� ���ᨨ ����⠭����������� ���� 
echo 䠩�� ������ ᮮ⢥�⢮���� ���㠫쭮� ���ᨨ,
echo ����� ����� ���� ��������� ��।�� �����������,
echo ���⮬� �⮨� ���� ᮮ⢥������� ����� ��*****
echo �� ᠩ� microsoft � ��ᬮ���� ����� ����� 䠩�� ��� �㦭�.
echo ���祭� ��⠭�������� ����������� �� ⠪ �� �����
echo 㢨���� � 䠩�� sfcdoc.log ��᫥ �⠭���⭮� �஢�ન.
echo.
echo ���᪠�� ������� � ������������ �ਯ�.
echo �㭪� �1 
echo "�������� �⠭������ �஢���"    ����᪠��
echo �⠭������ �஢��� 楫��⭮�� ��⥬��� 䠩��� �,
echo �᫨ ��������, ����⠭�������� �� �� �࠭���� ��������⮢. 
echo.
echo �㭪� �2 
echo "�������� ���७��� ��楤��� �஢�ન � ����⠭�������" 
echo ����᪠�� ����।�� ����⠭������� �࠭���� ��������⮢ 
echo ^( ���୥� ������ ���� ������祭 ^)  , � ��⥬ �⠭������
echo �஢��� 楫��⭮�� ��⥬��� 䠩���. �� ������ ������� 
echo ����� �६���, �� ��� ���� ����������� ��⮬���᪨ 
echo ��ࠢ��� ����襭�� 楫��⭮�� ��⥬��� 䠩���.
echo.
echo �㭪� �3 
echo "������ �࠭���� ��������⮢"     ����᪠�� 
echo ��������� ��楤��� ���⪨ �࠭���� ��������⮢, 
echo � ���� ����� winsxs.
echo.
echo ��⠫�� �㭪��, �㬠�, ������ � ��� ���ᠭ��.
echo p.s. ����筮, ��� ������� �� � ����� ����������,
echo �� ��� ᯥ樠�쭮 ����� ������� �� �� ������ ����,
echo ���⮬� �᫨ �� �� ��諨 ��� ��� ���짮������,
echo � �� ��訢��� ...
echo.
echo ���ᨡ� �� �������� � �ᯥ客^! 
										)
echo.
pause
echo.
exit /b


:choice
echo.
setlocal
if "%~1"=="" (
  set result=0
  pause
  goto choice_3
)
set count=0
:choice_1
set /a count+=1
echo %count%. %~1
shift
if not "%~1"=="" goto choice_1
:choice_2
set /p result=��� �롮� (1-%count%): 
for /l %%i in (1, 1, %count%) do if "%result%"=="%%i" goto choice_3
if "%result%"=="77" (call :secretlist )
if "%result%"=="78" (call :secretlistinput )
goto choice_2
:choice_3
endlocal & exit /b %result%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 

:: ������ ��樨 ᯨ᮪ �㭪⮢

:secretlist

cls
echo ��� �롮� ������ ���� � ������ ������� ENTER
echo.
echo.

call :choice "������ ���ﭨ� �࠭���� ��������⮢" "��楤�� ���⪨ �࠭���� ��������⮢" "��楤�� ����⠭������� �࠭���� ��������⮢"^
 "������� ��� ����⠭�������" "���᮪ ����㯭�� ᯥ檮���� 78"  "��室" 

if %ErrorLevel% EQU 1 ( Call :sfco )
																		
if %ErrorLevel% EQU 2 ( Call :Clearhealth )

if %ErrorLevel% EQU 3 ( Call :Restorehealth ) 

if %errorlevel% EQU 4 ( Call :SystemRestore )

if %ErrorLevel% EQU 5 ( 
		echo �஬� ᢮������� ����� ����㯭� ᫥���騥 ᯥ檮�����:
		echo.
		echo ���࠭���� ���������, ����� ����� ����� �ࠢ��쭮�
		echo ࠡ�� �ਫ������ �� Microsoft Store 101
		echo ���� � ��ࠢ����� �஡��� � ���ந��������� ��㪠 102
		echo ���� � ��ࠢ����� �஡��� � ������� ��㪠 103	
		echo ���� � ��ࠢ����� �஡���, ����� ����� �����
		echo �믮������ 䮭����� ᪠稢���� 䠩��� 104
		echo ���࠭���� �஡��� � ���ன�⢠�� � �ਭ�ࠬ� 105
		echo ���� � ���࠭���� �஡��� � ����㤮������ � ���ன�⢠�� 106
		echo ���� � ���࠭���� �஡��� � �ந�����⥫쭮����
		echo		Internet Explorer 107
		echo ���� � ���࠭���� �஡��� � �।�⢠�� ������᭮�� �
		echo ���䨤��樠�쭮�� � Internet Explorer 108	
		echo ���� � ���⪠ ���ᯮ��㥬�� 䠩��� � ��몮�, � ⠪��
		echo �믮������ ����� �� ���㦨����� 109
		echo ���� � ��ࠢ����� �஡��� � ������祭��� �
		echo ���୥�� ��� ���-ᠩ⠬ 110
		echo ���� � ���࠭���� �஡��� � ����㯮� � 䠩��� � 
		echo ������ �� ��㣨� ��������� 111
		echo ���� � ���࠭���� �஡��� � ��ᬮ�஬ �������஢ ���
		echo ���� 䠩��� � ����譥� ��㯯� 112	
		echo ���� � ���࠭���� �஡��� � ���஢���묨 �
		echo		��㣨�� �⥢묨 �����ࠬ� 113
		echo ���� � ���࠭���� �஡��� � �室�騬� ������祭�ﬨ
		echo �������஢ � �࠭�����஬ Windows 114
		echo ���� � ���࠭���� �஡��� � ������祭��� � ࠡ�祩 ��
		echo � ������� DirectAccess 115
		echo ���� � ���࠭���� �஡��� � ����᪮� ����� �ணࠬ� 
		echo � �⮩ ���ᨨ Windows 116
		echo ���� � ���࠭���� �஡��� ��� ��⨬���樨 ����த���⢨�
		echo � �ந�����⥫쭮�� Windows 117
		echo ���� � ���࠭���� �஡��� � ��ࠬ��ࠬ� ���ய�⠭��
		echo �������� ��� �࣮ᡥ०���� � 㢥��祭�� �६��� ࠡ��� ���२ 118
		echo ���� � ���࠭���� �஡��� � ������ 119
		echo ���� � ���࠭���� �஡��� �㦡� Windows Search 120
		echo ���� � ���࠭���� �஡��� � ���ந��������� 䨫쬮�,
		echo ⥫���।�� � ����� 121
		echo ���� � ���࠭���� �஡��� � ��ࠬ��ࠬ� 
		echo �ந��뢠⥫� Windows Media 122
		echo ���� � ���࠭���� �஡��� � ������⥪��
		echo �ந��뢠⥫� Windows Media 123
		echo ���� � ���࠭���� �஡��� � ���ந��������� DVD-��᪮�
		echo � �ந��뢠⥫� Windows Media 124
		echo ���࠭���� �訡�� ����� ���������� Windows 125
	pause 
	cls ) 

if %ErrorLevel% EQU 6 ( Call :Exite )

exit /b

:secretlistinput

set /p zero="������ �������:"
if %zero% EQU 77 ( Call :secretlist )

if %zero% GTR 100 ( 
	if %zero% LSS 126 ( 
		call :FixIt ) else ( 
			echo ������� �� �ᯮ�����
				)) else ( echo ������� �� �ᯮ����� )
					:: ᯨ᮪ ����㯭�� ������

if %zero% GTR 200 ( 
	if %zero% LSS 219 ( 
		call :FixItLocal ) else ( 
			echo ������� �� �ᯮ�����78
				)) else ( echo ������� �� �ᯮ����� & call :secretlistinput)


exit /b


   
:Exite
cls
  Echo ====== ����� �ਯ� �����襭� ======
  Echo.
  Echo.
  Echo �業�਩ �����⮢��: ��ਫ�
  Echo ����: SafeZone.cc 
  Echo E-mail: Fire@safezone.cc
  Echo.
  Echo======================================================================
  Echo ��ᯫ�⭮� ��祭�� ���������� ����ᮢ � �襭�� �஡��� � ࠡ�� ��
  Echo.
  Echo ��ࠦ�� ��஬��� �������୮��� ������⨢� � ���⭨��� ��㬠 SafeZone.cc 
  Echo �� ��⨢��� ���⨥ � ������ � ᮧ����� ������� �஥��!
    ping -n 15 127.0.0.1 > NUL  
  Exit

 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  
:UNKNOWN
 cls
 Echo =====  ERROR!  ===== 
 Echo ����� �業�਩ �� �।�����祭 ��� ��襩 ����樮���� ��⥬�,
 Echo ��ᯮ������ ᮮ⢥�����騬 ���ᨨ ��襩 ����樮���� ��⥬� �業�ਥ�
 Echo ��� ������� �� ������� �� ���: SafeZone.cc
 ping -n 10 127.0.0.1 > NUL  
Exit
