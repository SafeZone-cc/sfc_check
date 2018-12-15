::Средство проверки системных файлов позволяет проверить версии всех защищенных файлов. 
::Если при проверке системных файлов обнаруживается, что защищенный файл был изменен, то он заменяется его исходной версией.

@echo off >nul
 Chcp 866 >nul
  title Проверка целостности системных файлов / 0.7.5  [ SafeZone.cc ]
   ::SetLocal EnableExtensions EnableDelayedExpansion 

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

	:: Карта скрипта: 
	:: setting: Запускаем настройки setting,определяющие наличие прав,вызов меню и последующие операции
	::
	::
	::
	::
	::
	:: 
   
 :: Переменные:
cd /d %~dp0

set log=%windir%\Logs\CBS\sfcdoc.log
set log2=%windir%\Logs\CBS\sfcdoc2.log
set log3=%WinDir%\Logs\CBS\CheckSUR.log
set eventlog=%windir%\Logs\CBS\eventlog.log 
set dismlog=%windir%\Logs\DISM\dism.log
set cod86=chcp 866>nul
set cod12=chcp 1251>nul
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Вызываем процедуру Проверки  версии системы

call :veros
exit /b


	::Процедура опеределения версии системы и  вызова операции,соответствующей ОС 
	
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





 :: Проверяем не имеет ли место бы отсутствие прав доступа к папке CBS\CBS
 
 
 :TestElevate
	echo. >> "%log%"  && (echo ...Есть права доступа к лог файлам... >> %log%
	echo. > "%log2%"	) || (
	set log=%tmp%\sfcdoc.log
	set log2=%tmp%\sfcdoc2.log
		echo. >> "%log%"
		echo. >> "%log%"
		echo  ===TestElevate=== > "%log%"
		echo  ===TestElevate=== > "%log%2"
		echo  ===TestElevate===
		echo Проверка доступа к файлам логов >> "%log%"
		echo Обнаружено отсутствие прав доступа к каталогу %windir%\Logs\CBS, будет назначен временный каталог >> "%log%"
		echo. >> "%log%"
		cls)
		
 exit /b 
 
 
 :CheckAdmin
IF EXIST "%ProgramFiles(x86)%" (set arhitektura=64) else (set arhitektura=32)
net continue winmgmt 2>&1 |>NUL find "5" && (
	echo .........sfco ErrorLevel[ %ErrorLevel% ].........нет прав доступа!
    Echo Требуются права Администратора.
    Echo.
    echo Необходимо запустить сценарий от имени Администратора
    echo Правой кнопкой мыши по файлу - пункт 
	echo "Запустить от имени Администратора"
    echo.
    echo Для выхода нажмите клавишу ENTER
    pause>nul
	goto Exite
) || (
   > "%log%" (
	
    echo.
    echo ::::::::  %Userprofile%  
    echo ::::::::  %DATE%  / %TIME%
    echo ::::::::  %VERSION%  / Архитектура: %arhitektura%
	echo ::::::::  Версия скрипта / 0.7.5 [15.12.2018]
	echo ::::::::  SafeZone.cc
    echo.
    echo.
    echo :::::::::::::::::::::::::::::::::::::::::::::::::::::
    echo.
    echo ... Права Администратора получены...
	echo .........sfco ErrorLevel [ %ErrorLevel% ] 
	echo.
	echo ......Текущий каталог:  %cd% ......
	)
)			
	call :TestElevate
exit /b 
 
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

 
 
										
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

 
:os1

cls
echo Для выбора введите цифру и нажмите клавишу ENTER
echo.
echo.

call :choice "Запустить стандартную проверку" "Запустить расширенную процедуру проверки и сбора логов" "Открыть результаты последнего сканирования" "Справка" "Выход" 

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
echo Для выбора введите цифру и нажмите клавишу ENTER
echo.
echo.
		
call :choice "Запустить стандартную проверку" "Запустить расширенную процедуру проверки и восстановления" "Очистить Хранилище компонентов"^
 "Открыть результаты последнего сканирования" "Справка" "Выход" 

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

if %ErrorLevel% EQU 4 ( Call :findstrlog 
							call :pcinfo
								call :open 
									call :os0 )

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
Echo ВНИМАНИЕ!
Echo.
Echo Сейчас будет запущена проверка системных файлов на целостность.
Echo Не выключайте компьютер и не закрывайте окно консоли 
echo пока не закончится проверка.
echo.
tasklist | find /i "TiWorker.exe"  >nul
if %errorlevel% EQU = 0 ( taskkill /f /im "TiWorker.exe" 
   ( 
>>"%log%" (
echo ......... Завершение процесса TiWorker.exe [ 0 ] [ успех ] 
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
echo Проверка завершена.
Echo Проверка завершена >>"%log%"
echo.
echo.
call :findstrlog

exit /b



:findstrlog

cls
echo Текущий каталог %cd%
Echo. >>"%log%"
Echo. >>"%log%"
:: Фильтрация
copy /y %windir%\Logs\CBS\CBS.LOG CBS.LOG 
< "CBS.LOG" find /i "[SR]" | find /v /i "[SR] Verify complete" | find /v /i "[SR] Verifying 100" | find /v /i "[SR] Beginning Verify and Repair transaction" >>"%log%"


Echo. >>"%log%"
Echo. >>"%log%"
echo .........find ErrorLevel[ %ErrorLevel% ] >>"%log%"

Echo Использованы дополнительные параметры: >>"%log%"
Echo. >>"%log%"
Echo. >>"%log%"
type "%log2%" >>"%log%" 
if %os% EQU 1 type "%log3%" >>"%log%" 
exit /b

:pcinfo

echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: >>"%log%"
Echo. >>"%log%"
Echo. >>"%log%"
Echo Контрольные точки восстановления: >>"%log%"
Echo. >>"%log%"
wmic shadowcopy get InstallDate /value | find "." >>"%log%"
Echo. >>"%log%"
Echo. >>"%log%"
echo Сведения о ПК: >>"%log%" 
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
Echo ......Открытие папки... >>"%log%"
Echo. >>"%log%"
Echo. >>"%log%"
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: >>"%log%"
Echo. >>"%log%"
echo SafeZone.cc , @ Кирилл >>"%log%" 
Echo. >>"%log%"                                
echo Теперь откройте папку с файлом лога [ %CD% ]
echo если она не открылась автоматически.
echo Прикрепите файлы sfcdoc.log и CBS.log на форум к вашему сообщению,
echo если вам нужна помощь в анализе логов или восстановлении
echo поврежденных системных файлов.
echo.
echo Копии файлов находятся также в каталоге: 
echo %windir%\Logs\CBS
echo.
:: Открыть "чистый" отчет программой по-умолчанию
start "" "%CD%"
start "" "%log%"
echo Нажмите клавишу ENTER чтобы продолжить...
pause > nul
exit /b

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::   
	
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::							 
								 
:XP
echo Версия Вашей операционной системы: %VERSION%
for %%i in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist %%i:\WIN51 set CDROM=%%i:
if not exist %cdrom%\win51.* (
 echo. 
  echo.
   echo.
    cls
     echo Вам необходимо вставить диск с вашей копией Windows 
      echo Либо смонтировать образ диска в виртуальный привод.& call :cdopen
       ) else (call :koz)

exit /b
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::	

:cdopen 
  set m.msg=^
  ДА - Диск с Windows вставлен (или образ смонтирован)^&^
  НЕТ - Выход из программы (ни диска ни образа нет)
 
  cmd /U /C echo Wscript.Echo Msgbox^(replace^(Wscript.Arguments^(0^),"&",vbLF^),67,"Проверка диска"^)>"msgbox.vbs"
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
   echo Сохраняю резервную копию реестра...
   reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup" %systemdrive%\install.reg
   echo.
   echo Устанавливаю значения реестра...
   echo.
   echo Дистрибутив обнаружен...
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
   echo Проверка целостности системных файлов начата.
   echo Дождитесь окончания проверки.
   md %windir%\Logs\CBS
   wevtutil qe Application /q:*[System[(EventID=64021)]] /f:text /rd:true /c:2 >>"%log%"
   SYSTEMINFO /FO LIST >>"%log%" 
   :: Открыть "чистый" отчет программой по-умолчанию
	rundll32 shell32.dll,ShellExec_RunDLL "%log%"
	Echo. >>"%log%"
	explorer.exe %~dp0
   ping -n 15 127.0.0.1 > NUL
   call :Exite
exit /b
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

					 
						
						
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Оценка состояния хранилища компонентов на предмет повреждения

:recbd

tasklist | find /i "TiWorker.exe"  >nul
if %errorlevel% EQU = 0 ( taskkill /f /im "TiWorker.exe" 
   ( 
>"%log2%" (
echo ......... Завершение процесса TiWorker.exe [ 0 ] [ успех ] 
echo ......... ErrorLevel[ %ErrorLevel% ] 
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: 
echo. 
echo. 
echo. 
echo ... Проверка хранилища данных ...  
echo. 
	) 
	 )
	  )
cls
echo ...Проверяю состояние хранилища данных...
echo.
echo.


echo ...... Проверка состояния компонентов хранилища >>"%log2%"
    Dism /Online /Cleanup-Image /CheckHealth
		echo ......... ErrorLevel[ %ErrorLevel% ] >>"%log2%"
		if %ErrorLevel% EQU 0 (
		echo ......... Повреждения хранилища компонентов не обнаружены >>"%log2%"
		) else ( 
		echo. >>"%log2%"
		echo ...... Обнаружено повреждение хранилища компонентов >>"%log2%" 
		)
exit /b		


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Оценка состояния хранилища компонентов на предмет необходимости очистки

:Clearanalize		
		
echo. >"%log2%"
echo. >>"%log2%"
echo.
echo.
echo Процедура может длиться до 10 минут.
echo Ожидайте...
echo.
echo.
echo ...... Оценка свободного места хранилища...
echo ...... Оценка свободного места хранилища... >>"%log2%"
	Dism.exe /Online /Cleanup-Image /AnalyzeComponentStore >>"%log2%"
		echo ......... ErrorLevel[ %ErrorLevel% ] >>"%log%"
		if %ErrorLevel% EQU 0 (
		echo ......... Требуется очистка WinSxS >>"%log2%" 
		) else ( echo ......... Очистка WinSxS не требуется >>"%log2%"  )
		
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
echo Ждите...
echo.
echo.
echo ...... Процедура восстановления хранилища...
echo ......... Процедура восстановления хранилища... >"%log2%" 
	Dism.exe /Online /Cleanup-Image /Restorehealth 
	
		echo ......... ErrorLevel[ %ErrorLevel% ] >>"%log2%"
		if %ErrorLevel% EQU 0 (
		echo ......... Восстановление компонентов хранилища завершено корректно >>"%log2%"		
		) else (
		echo Восстановление хранилища данных прошло некорректно.
		echo Сообщите о проблеме специалистам SafeZone 
		echo ......... Восстановление компонентов хранилища завершено НЕ корректно >>"%log2%" )
		
	
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: >>"%log2%" 
echo. >>"%log2%" 
echo. >>"%log2%" 
echo  >>"%log2%" 
echo ::::::::  %DATE%  / %TIME% >>"%log2%"
echo Нажмите клавишу ENTER чтобы продолжить
pause > nul
exit /b

:Restorehealth1

echo.
		echo Ожидайте...
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages" /f  "KB2966583" /k

	if %ErrorLevel% EQU 0 (
		cls 
			echo Сейчас будет произведено восстановление хранилища компонентов Windows
			echo Убедитесь, что вы подключены к сети Интернет и дождитесь завершения 
			echo операции восстановления
				DISM /Online /Cleanup-Image /ScanHealth
					(if %ErrorLevel% EQU 0 (
						echo Восстановление хранилища данных прошло корректно.
						echo ......... Восстановление компонентов хранилища завершено корректно >>"%log2%"		
							) else ( echo ......... Восстановление компонентов хранилища завершено НЕ корректно >>"%log2%" ))
		)  else (
			
			cls
			echo.
			echo Для запуска процедуры восстановления необходимо установить обовление KB2966583
			echo Скопируйте ссылку, если страница загрузки не открылась автоматически
			echo откройте в браузере и скачайте, затем произведите установку
			echo После установки обновления перезагрузите компьютер и заново воспользуйтесь 
			echo данным скриптом.
			echo.
			
				(if %arhitektura% EQU 32 (
					start https://www.microsoft.com/ru-RU/download/details.aspx?id=43524
						echo https://www.microsoft.com/ru-RU/download/details.aspx?id=43524
						echo ......... Внимание! Не установлено обновление KB2966583 >>"%log2%" 
						echo ......... https://www.microsoft.com/ru-RU/download/details.aspx?id=43524 >>"%log2%" 
						echo.
						pause
					Call :Exite	
				) else (
					start https://www.microsoft.com/ru-RU/download/details.aspx?id=43484
						echo https://www.microsoft.com/ru-RU/download/details.aspx?id=43484
						echo ......... Внимание! Не установлено обновление KB2966583 >>"%log2%" 
						echo ......... https://www.microsoft.com/ru-RU/download/details.aspx?id=43524 >>"%log2%" )) 
						echo.
						pause
					Call :Exite
				)
		pause
		exit /b

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Очистка хранилища компонентов

:Clearhealth

cls
tasklist | find /i "TiWorker.exe"  >nul
if %errorlevel% EQU = 0 ( taskkill /f /im "TiWorker.exe" 
   ( 
>"%log2%" (
echo ......... Завершение процесса TiWorker.exe [ 0 ] [ успех ] 
echo ......... ErrorLevel[ %ErrorLevel% ] 
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: 
echo. 
	) 
	 )
	  )
echo Ждите...
echo.
echo.
echo ...... Процедура очистки хранилища...
echo ......... Процедура очистки хранилища... >>"%log2%" 
	Dism.exe /Online /Cleanup-Image /StartComponentCleanup 
		echo ......... ErrorLevel[ %ErrorLevel% ] >>"%log2%"
		if %ErrorLevel% EQU 0 (
		echo ......... Очистка хранилища завершена корректно >>"%log2%"		
		) else (
		echo Процедура очистки хранилища данных прошло некорректно.
		echo Сообщите о проблеме специалистам SafeZone 
		echo .........Процедура очистки хранилища компонентов завершено НЕ корректно >>"%log2%" )
		
	
echo ::::::::::::::::::::::::::::::::::::::::::::::::::::: >>"%log2%" 
echo. >>"%log2%" 
echo. >>"%log2%"
echo ::::::::  %DATE%  / %TIME% >>"%log2%"
echo Нажмите клавишу ENTER чтобы продолжить
pause > nul
exit /b

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::  

:: Запускаем апплет создания точки восстановления или восстановления системы
:SystemRestore
 rundll32.exe shell32.dll,Control_RunDLL sysdm.cpl,,4
exit /b 


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::FixIt Easy List::
:FixIt
cls
echo.
echo Сейчас запустится браузер по умолчанию и страница загрузки
echo средства устранения неполадок Windows FixItEasy.
echo Подтвердите операцию загрузки, если потребуется
echo и запустите скачанный файл. По завершении операции 
echo убедитесь, что проблема устранена.
echo Если это не так, то в окне средства FixItEasy на последнем
echo этапе нажмите ссылку "Посмотреть дополнительные параметры"
echo затем выделите мышкой текст указанной проблемы, выявленной
echo в процессе диагностики и скопируйте последовательным нажатием 
echo клавиш ^( левый Ctrl и клавиша С ^), затем вставьте 
echo скопированный таким образом текст в сообщение или текстовый 
echo файл, чтобы показать его тем, кто поможет разобраться, если 
echo вы вдруг не сможете этого сделать самостоятельно.
pause

set UrlKey=UrlKey
:: Устранение неполадок, которые могут мешать правильной работе приложений из Microsoft Store 101
	if %zero% EQU 101 ( set UrlKey=http://aka.ms/diag_apps10 ) 
	
::Поиск и исправление проблем с воспроизведением звука 102
	if %zero% EQU 102 ( set UrlKey=http://aka.ms/diag_audio10 )

::Поиск и исправление проблем с записью звука 103	
	if %zero% EQU 103 ( set UrlKey=http://aka.ms/diag_audio10r ) 

::Поиск и исправление проблем, которые могут мешать выполнению фонового скачивания файлов 104
	if %zero% EQU 104 ( set UrlKey=http://aka.ms/diag_bits10 ) 

::Устранение проблем с устройствами и принтерами 105
	if %zero% EQU 105 ( set UrlKey=http://aka.ms/diag_devicec ) 

::Поиск и устранение проблем с оборудованием и устройствами 106
	if %zero% EQU 106 ( set UrlKey=http://aka.ms/diag_device ) 

::Поиск и устранение проблем с производительностью Internet Explorer 107
	if %zero% EQU 107 ( set UrlKey=http://aka.ms/diag_iebrowser ) 

::Поиск и устранение проблем со средствами безопасности и конфиденциальности в Internet Explorer 108	
	if %zero% EQU 108 ( set UrlKey=http://aka.ms/diag_iesecurity10 ) 

::Поиск и очистка неиспользуемых файлов и ярлыков, а также выполнение задач по обслуживанию 109
	if %zero% EQU 109 ( set UrlKey=http://aka.ms/diag_maintenance10 ) 

::Поиск и исправление проблем с подключением к Интернету или веб-сайтам 110
	if %zero% EQU 110 ( set UrlKey=http://aka.ms/diag_networking10 ) 

::Поиск и устранение проблем с доступом к файлам и папкам на других компьютерах 111
	if %zero% EQU 111 ( set UrlKey=http://aka.ms/diag_networking10 ) 

::Поиск и устранение проблем с просмотром компьютеров или общих файлов в домашней группе 112	
	if %zero% EQU 112 ( set UrlKey=http://aka.ms/diag_networking10 ) 

::Поиск и устранение проблем с беспроводными и другими сетевыми адаптерами 113
	if %zero% EQU 113 ( set UrlKey=http://aka.ms/diag_networking10 ) 

::Поиск и устранение проблем со входящими подключениями компьютеров и брандмауэром Windows 114
	if %zero% EQU 114 ( set UrlKey=http://aka.ms/diag_networking10 ) 

::Поиск и устранение проблем с подключением к рабочей сети с помощью DirectAccess 115
	if %zero% EQU 115 ( set UrlKey=http://aka.ms/diag_networking10 ) 

::Поиск и устранение проблем с запуском старых программ в этой версии Windows 116
	if %zero% EQU 116 ( set UrlKey=http://aka.ms/diag_pcw10 ) 

::Поиск и устранение проблем для оптимизации быстродействия и производительности Windows 117
	if %zero% EQU 117 ( set UrlKey=http://aka.ms/diag_performance10 ) 

::Поиск и устранение проблем с параметрами электропитания компьютера для энергосбережения и увеличения времени работы батареи 118
	if %zero% EQU 118 ( set UrlKey=http://aka.ms/diag_power10 ) 

::Поиск и устранение проблем с печатью 119
	if %zero% EQU 119 ( set UrlKey=http://aka.ms/diag_printer10 ) 

::Поиск и устранение проблем службы Windows Search 120
	if %zero% EQU 120 ( set UrlKey=http://aka.ms/diag_search10 ) 

::Поиск и устранение проблем с воспроизведением фильмов, телепередач и видео 121
	if %zero% EQU 121 ( set UrlKey=http://aka.ms/diag_video10 ) 

::Поиск и устранение проблем с параметрами проигрывателя Windows Media 122
	if %zero% EQU 122 ( set UrlKey=http://aka.ms/diag_wmpc10 ) 

::Поиск и устранение проблем с библиотекой проигрывателя Windows Media 123
	if %zero% EQU 123 ( set UrlKey=http://aka.ms/diag_wmpl10 ) 

::Поиск и устранение проблем с воспроизведением DVD-дисков в проигрывателе Windows Media 124
	if %zero% EQU 124 ( set UrlKey=http://aka.ms/diag_wmpdvd10 )

::Устранение ошибок Центра обновления Windows 125
	if %zero% EQU 125 ( 
						if %Version%=="Windows 7" ( set UrlKey=http://aka.ms/diag_wu ) 
							if %Version%=="Windows 8" ( set UrlKey=https://aka.ms/diag_wu )
								if %Version%=="Windows 10" ( set UrlKey=https://aka.ms/wudiag )
									if %Version%=="Windows 8.1" ( echo Загрузите и установите это обновление:
										echo https://support.microsoft.com/ru-ru/help/3173424/servicing-stack-update-for-windows-8-1-and-windows-server-2012-r2-july 
											set UrlKey=https://support.microsoft.com/ru-ru/help/3173424/servicing-stack-update-for-windows-8-1-and-windows-server-2012-r2-july
												echo. )
														)
	
start %UrlKey%
echo.
echo Если вопросов не имеется, то можно закрыть
echo это меню, нажав любую клавишу...
pause
exit /b

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


::FixIt Easy List Local::
::FixIt запуск встроенного в систему средства::

:FixItLocal
cls
echo.
echo Сейчас запустится средство устранения неполадок.
echo Следуйте инструкциям и подсказкам до  
echo последнего этапа.
echo На последнем этапе нажмите ссылку 
echo "Посмотреть дополнительные параметры"
echo затем выделите мышкой текст указанной проблемы, выявленной
echo в процессе диагностики и скопируйте последовательным нажатием 
echo клавиш ^( левый Ctrl и клавиша С ^), затем вставьте 
echo скопированный таким образом текст в сообщение или текстовый 
echo файл, чтобы показать его тем, кто поможет разобраться, если 
echo вы вдруг не сможете этого сделать самостоятельно.
pause


:: 201 Устранение неполадок, отображающих эффекты Aero, такие как прозрачность. Требуется наличие Windows Aero 
:: /Windows 7; /

	if %zero% EQU 201 ( msdt /id AeroDiagnostic ) 
	
:: 202 Устранение неполадок, связанных с подключением к сети на рабочем месте через Интернет с помощью DirectAccess.
:: Требуется установленный directaccess 
:: /Windows 7; 8; 8.1; 10; RT; Server 2008 + 2012 /

	if %zero% EQU 202 ( msdt /id NetworkDiagnosticsDA )

:: 203 Устранение неполадок с использованием аппаратных средств и устройств доступа, подключенных к компьютеру.	
:: Можно использовать как диагностику на предмет неустановленных или кривых драйверов
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 203 ( msdt /id DeviceDiagnostic ) 

:: 204 Устранение неполадок при просмотре компьютеров или общих файлов в домашней группе.
::На Windows домашняя группа должна быть настроена 
:: /Windows 7; 8; 8.1; 10; RT; /	
	
	if %zero% EQU 204 ( msdt /id HomeGroupDiagnostic ) 

:: 205 Устранение неполадок, позволяющих другим компьютерам взаимодействовать с целевым компьютером через брандмауэр Windows.
:: /Windows 7; 8; 8.1; RT; Server 2008 + 2012 /

	if %zero% EQU 205 ( msdt /id NetworkDiagnosticsInbound ) 

:: 206 Устранение неполадок при подключении к Интернету или на определенном веб-сайте.
:: /Windows 7; 8; 8.1; RT; Server 2008 + 2012 /

	if %zero% EQU 206 ( msdt /id NetworkDiagnosticsWeb ) 

:: 207 Помогает пользователю предотвратить дополнительные проблемы и оптимизировать временные файлы и подключения.
:: Требуется установленный Internet Explorer 
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 207 ( msdt /id IEBrowseWebDiagnostic ) 

:: 208 Помогает пользователю предотвратить вредоносное ПО, всплывающие окна и онлайн-атаки.
:: Требуется установленный Internet Explorer 
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 208 ( msdt /id IESecurityDiagnostic ) 

:: 209 Устранение неполадок с Ethernet, беспроводными или другими сетевыми адаптерами.
:: /Windows 7; 8; 8.1; RT; /

	if %zero% EQU 209 ( msdt /id NetworkDiagnosticsNetworkAdapter ) 

:: 210 Помогает пользователю настроить параметры для повышения скорости и производительности операционной системы.
:: /Windows 7; /

	if %zero% EQU 210 ( msdt /id PerformanceDiagnostic ) 

:: 211 Устранение неполадок при воспроизведении звуков и других аудиофайлов.
:: Для Windows должно быть установлено устройство вывода аудиосигнала
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 211 ( msdt /id AudioPlaybackDiagnostic ) 

:: 212 Устранение неполадок при печати.
:: /Windows 7; 8; 8.1; RT; /

	if %zero% EQU 212 ( msdt /id PrinterDiagnostic ) 

:: 213 Помогает пользователю настроить старые программы, чтобы они могли запускаться в текущей версии Windows.
:: /Windows 7; 8; 8.1; 10; RT; Server 2008 + 2012/

	if %zero% EQU 213 ( msdt /id PCWDiagnostic ) 

:: 214 Устранение неполадок при записи звука с микрофона или другого источника.
:: Установлено устройство ввода аудио
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 214 ( msdt /id AudioRecordingDiagnostic ) 

:: 215 Устранение неполадок при поиске и индексировании с помощью Windows Search.
:: Поиск и индексирование должны быть включены
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 215 ( msdt /id SearchDiagnostic ) 

:: 216 Устранение неполадок, связанных с доступом к общим файлам и папкам на других компьютерах по сети.
:: /Windows 7; 8; 8.1; 10; RT; Server 2008 + 2012/

	if %zero% EQU 216 ( msdt /id NetworkDiagnosticsFileShare ) 

:: 217 Диагностика и предотвращение неполадок на компьютере
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 217 ( msdt /id MaintenanceDiagnostic ) 

:: 218 Устранение неполадок, которые не позволяют Windows Update выполнять задачи обновления.
:: /Windows 7; 8; 8.1; 10; RT; /

	if %zero% EQU 218 ( msdt /id WindowsUpdateDiagnostic ) 


echo.
echo Если вопросов не имеется, то можно закрыть
echo это меню, нажав любую клавишу...
pause >nul
exit /b


	   
:Help
cls


if %os% EQU 1 (
echo :::::::::::: %Version% :::::::::::::
echo.
echo Что именно восстанавливает этот сценарий ?
echo.
echo Часть защищенных системных фалов, необходимых для
echo нормальной работы Windows и ее компонентов.
echo В случае, если вы по итогу проверки получили 
echo сообщение наподобие такого:
echo "Защита ресурсов Windows обнаружила нарушение 
echo целостности системных файлов, но не может 
echo восстановить некоторые из них"
echo Значит, файл поврежден как в системных каталогах, 
echo так и в хранилище компонентов.
echo Это может оказаться причиной возникших проблем в
echo работе системы или приложений, если таковые 
echo проблемы имеются. Если у вас нет нареканий к работе
echo вашей операционной системы, то можете не 
echo заморачиваться с восстановлением исходных файлов,
echo так как это не так уж просто.
echo. 
echo Если вы все же решились заморочиться и восстановить
echo все как положено, то вам необходимо посмотреть 
echo информацию о том, какие конкретно файлы повреждены.
echo Для этого вам понадобится изучить файлы 
echo sfcdoc.log и cbs.log
echo Если вы открыли эти файлы, и не совсем поняли что 
echo там смотреть, то я написал вам в помощь 
echo вот такую замечательную статью-справку:
echo.
echo Если и после прочтения инструкции вам все равно 
echo не понятно или вас обуревает страх,то вы можете
echo обратиться за помощью к нам на форум safezone.cc и
echo мы вам поможем совершенно бесплатно. 
echo Буквально за спасибо.
echo Помните, что копии версии восстанавливаемого вами 
echo файла должна соотвествовать атктуальной версии,
echo которая могла быть обновлена очередным обновлением,
echo поэтому стоит найти соотвествующую статью КВ*****
echo на сайте microsoft и посмотреть какая версия файла вам нужна.
echo Перечень установленных обновлениий вы так же можете
echo увидеть в файле sfcdoc.log после стандартной проверки.
echo Спасибо за внимание и успехов^!)



if %os% EQU 0 ( 
echo :::::::::::: %Version% :::::::::::::
echo.
echo Что именно восстанавливает этот сценарий ?
echo.
echo Часть защищенных системных фалов, необходимых для
echo нормальной работы Windows и ее компонентов.
echo В случае, если вы по итогу проверки получили 
echo сообщение наподобие такого:
echo "Защита ресурсов Windows обнаружила нарушение 
echo целостности системных файлов, но не может 
echo восстановить некоторые из них"
echo Значит, файл поврежден как в системных каталогах, 
echo так и в хранилище компонентов.
echo Это может оказаться причиной возникших проблем в
echo работе системы или приложений, если таковые 
echo проблемы имеются. Если у вас нет нареканий к работе
echo вашей операционной системы, то можете не 
echo заморачиваться с восстановлением исходных файлов,
echo так как это не так уж просто.
echo. 
echo Если вы все же решились заморочиться и восстановить
echo все как положено, то вам необходимо посмотреть 
echo информацию о том, какие конкретно файлы повреждены.
echo Для этого вам понадобится изучить файлы 
echo sfcdoc.log и cbs.log
echo Если вы открыли эти файлы, и не совсем поняли что 
echo там смотреть, то я написал вам в помощь 
echo вот такую замечательную статью-справку:
echo.
echo Если и после прочтения инструкции вам все равно 
echo не понятно или вас обуревает страх,то вы можете
echo обратиться за помощью к нам на форум safezone.cc и
echo мы вам поможем совершенно бесплатно. 
echo Буквально за спасибо.
echo Помните, что копия версии восстанавливаемого вами 
echo файла должна соотвествовать атктуальной версии,
echo которая могла быть обновлена очередным обновлением,
echo поэтому стоит найти соотвествующую статью КВ*****
echo на сайте microsoft и посмотреть какая версия файла вам нужна.
echo Перечень установленных обновлениий вы так же можете
echo увидеть в файле sfcdoc.log после стандартной проверки.
echo.
echo Расскажу немного о возможностях скрипта.
echo Пункт №1 
echo "Запустить стандартную проверку"    запускает
echo стандартную проверку целостности системных файлов и,
echo если возможно, восстанавливает их из хранилища компонентов. 
echo.
echo Пункт №2 
echo "Запустить расширенную процедуру проверки и восстановления" 
echo запускает поочередно восстановление хранилища компонентов 
echo ^( интернет должен быть подключен ^)  , а затем стандартную
echo проверку целостности системных файлов. Это займет немного 
echo больше времени, но зато дает возможность автоматически 
echo исправить нарушения целостности системных файлов.
echo.
echo Пункт №3 
echo "Очистить Хранилище компонентов"     запускает 
echo безопасную процедуру очистки хранилища компонентов, 
echo то есть папки winsxs.
echo.
echo Остальные пункты, думаю, понятны и без описания.
echo p.s. Конечно, тут имеются еще и скрытые возможности,
echo но они специально скрыты подальше от не опытных глаз,
echo поэтому если вы не нашли как ими пользоваться,
echo то не спрашивайте ...
echo.
echo Спасибо за внимание и успехов^! 
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
set /p result=Ваш выбор (1-%count%): 
for /l %%i in (1, 1, %count%) do if "%result%"=="%%i" goto choice_3
if "%result%"=="77" (call :secretlist )
if "%result%"=="78" (call :secretlistinput )
goto choice_2
:choice_3
endlocal & exit /b %result%
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: 

:: Скрытые опции список пунктов

:secretlist

cls
echo Для выбора введите цифру и нажмите клавишу ENTER
echo.
echo.

call :choice "Анализ состояния хранилища компонентов" "Процедура очистки хранилища компонентов" "Процедура восстановления хранилища компонентов"^
 "Создать точку восстановления" "Список доступных спецкоманд 78"  "Выход" 

if %ErrorLevel% EQU 1 ( Call :sfco )
																		
if %ErrorLevel% EQU 2 ( Call :Clearhealth )

if %ErrorLevel% EQU 3 ( Call :Restorehealth ) 

if %errorlevel% EQU 4 ( Call :SystemRestore )

if %ErrorLevel% EQU 5 ( 
		echo Кроме свободного ввода доступны следующие спецкоманды:
		echo.
		echo Устранение неполадок, которые могут мешать правильной
		echo работе приложений из Microsoft Store 101
		echo Поиск и исправление проблем с воспроизведением звука 102
		echo Поиск и исправление проблем с записью звука 103	
		echo Поиск и исправление проблем, которые могут мешать
		echo выполнению фонового скачивания файлов 104
		echo Устранение проблем с устройствами и принтерами 105
		echo Поиск и устранение проблем с оборудованием и устройствами 106
		echo Поиск и устранение проблем с производительностью
		echo		Internet Explorer 107
		echo Поиск и устранение проблем со средствами безопасности и
		echo конфиденциальности в Internet Explorer 108	
		echo Поиск и очистка неиспользуемых файлов и ярлыков, а также
		echo выполнение задач по обслуживанию 109
		echo Поиск и исправление проблем с подключением к
		echo Интернету или веб-сайтам 110
		echo Поиск и устранение проблем с доступом к файлам и 
		echo папкам на других компьютерах 111
		echo Поиск и устранение проблем с просмотром компьютеров или
		echo общих файлов в домашней группе 112	
		echo Поиск и устранение проблем с беспроводными и
		echo		другими сетевыми адаптерами 113
		echo Поиск и устранение проблем со входящими подключениями
		echo компьютеров и брандмауэром Windows 114
		echo Поиск и устранение проблем с подключением к рабочей сети
		echo с помощью DirectAccess 115
		echo Поиск и устранение проблем с запуском старых программ 
		echo в этой версии Windows 116
		echo Поиск и устранение проблем для оптимизации быстродействия
		echo и производительности Windows 117
		echo Поиск и устранение проблем с параметрами электропитания
		echo компьютера для энергосбережения и увеличения времени работы батареи 118
		echo Поиск и устранение проблем с печатью 119
		echo Поиск и устранение проблем службы Windows Search 120
		echo Поиск и устранение проблем с воспроизведением фильмов,
		echo телепередач и видео 121
		echo Поиск и устранение проблем с параметрами 
		echo проигрывателя Windows Media 122
		echo Поиск и устранение проблем с библиотекой
		echo проигрывателя Windows Media 123
		echo Поиск и устранение проблем с воспроизведением DVD-дисков
		echo в проигрывателе Windows Media 124
		echo Устранение ошибок Центра обновления Windows 125
	pause 
	cls ) 

if %ErrorLevel% EQU 6 ( Call :Exite )

exit /b

:secretlistinput

set /p zero="Введите команду:"
if %zero% EQU 77 ( Call :secretlist )

if %zero% GTR 100 ( 
	if %zero% LSS 126 ( 
		call :FixIt ) else ( 
			echo Команда не распознана
				)) else ( echo Команда не распознана )
					:: список доступных команд

if %zero% GTR 200 ( 
	if %zero% LSS 219 ( 
		call :FixItLocal ) else ( 
			echo Команда не распознана78
				)) else ( echo Команда не распознана & call :secretlistinput)


exit /b


   
:Exite
cls
  Echo ====== Работа скрипта завершена ======
  Echo.
  Echo.
  Echo Сценарий подготовил: Кирилл
  Echo Сайт: SafeZone.cc 
  Echo E-mail: Fire@safezone.cc
  Echo.
  Echo======================================================================
  Echo Бесплатное лечение компьютерных вирусов и решение проблем в работе ПК
  Echo.
  Echo Выражаю огромную благодарность коллективу и участникам форума SafeZone.cc 
  Echo за активное участие и помощь в создании данного проекта!
    ping -n 15 127.0.0.1 > NUL  
  Exit

 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  
:UNKNOWN
 cls
 Echo =====  ERROR!  ===== 
 Echo Данный сценарий не предназначен для Вашей операционной системы,
 Echo воспользуйтесь соответствующим версии Вашей операционной системы сценарием
 Echo или обратитесь за помощью на форум: SafeZone.cc
 ping -n 10 127.0.0.1 > NUL  
Exit
