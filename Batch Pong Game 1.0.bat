@echo off
@title Batch Pong Game v1.0  ^|  Created by Psi505
@setlocal enabledelayedexpansion
::+4
cd files
batbox /h 0

:: Menu //
@mode 65,22
color 0c
echo.
echo.
echo.
echo    ÛÛÜ    ÛÛ   ÛÛÛÛÛ  ÜÛßßÜ Û  Û   ÛßÜ   ÜÛÛÜ  ÛÛ    Û  ÜÛÛÛÜ
echo    Û  Û  Û  Û    Û   Üß     Û  Û   Û  Û Üß  ßÜ Û Û   Û Üß   ß
echo    ÛþÛ  ÜÛÛÛÛÜ   Û   Û      ÛÛÛÛ   ÛÜß  Û    Û Û  Û  Û Û   ÜÜ
echo    Û  Û Û    Û   Û   ßÜ     Û  Û   Û    ßÜ  Üß Û   Û Û ßÜ   Û
echo    ÛÛß  Û    Û   Û    ßÛÜÜß Û  Û   Û     ßÛÛß  Û    ÛÛ  ßÛÛÛß
echo.
echo.
echo                     ÜÛÛÛÜ   ÛÛ   ÛÜ   ÜÛ ÛÛÛÛ
echo                    Üß   ß  Û  Û  Û Û Û Û Û
echo                    Û   ÜÜ ÜÛÛÛÛÜ Û  Û  Û ÛÛÛÛ
echo                    ßÜ   Û Û    Û Û     Û Û
echo                     ßÛÛÛß Û    Û Û     Û ÛÛÛÛ   v1.0
batbox /c 0x0b /g 13 18 /d "This Game Was Created By Psi505 (C) July 2019"
pause>nul
:://

@mode 90,37
:: prameters //
set Ball=O
set Raklng=10
call :racket
call :Dimcon yc xc
:GAME_BG
set Life=
set lifec=3
:RESTART
color 07 & cls
set /a xrp=(((xc/2)-(Raklng/2))/4)*4 , xrp1=0 , yrp= yc - 2
set /a xbp=0 , ybp=3
set /a xrp_max= xc - Raklng - 3
set /a ybp_max= yc - 2
set /a xbp_max= xc - 1
set /a score=0
set tscore=true
set /a delay=10
set "spd=|"
set finallscore=0
:://
set "sp1="
for /l %%i in (1,1,%xc%) do (set sp1=_!sp1!)
batbox /g 0 2 /d "!sp1!"


:screen
if %tscore%==true (
    batbox /c 0x07 /g 1 1 /d "Score :" /c 0x0a /g 9 1 /d "%score%"
    batbox /c 0x07 /g 15 1 /d "Life :" /c 0x0c /g 22 1 /d "%life%"
    batbox /c 0x07 /g 29 1 /d "speed :" /c 0x0e /g 37 1 /d "%spd%"
)
set tscore=false
:: racket mvt
if not %xrp%==%xrp1% (batbox /c 0x07 /g %xrp1% %yrp% /d "!Racket!")
batbox /c 0x70 /g %xrp% %yrp% /d "!Racket!"
set /a xrp1=xrp

:: ball mvt
if %xbp%==0 (set opx=+) & if not %score%==0 (start wscript PS.vbs Pong.wav)
if %ybp%==3 (set opy=+) & if not %score%==0 (start wscript PS.vbs Pong.wav)
if %xbp%==%xbp_max% (set opx=- & start wscript PS.vbs Pong.wav)
if %ybp%==%ybp_max% (call :lose & set opy=-)
call :test_pos
set /a xbp%opx%=1, ybp%opy%=1
batbox /c 0x07 /g %xbp1% %ybp1% /d " "
batbox /c 0x0b /g %xbp% %ybp% /d "O"
set /a xbp1=xbp , ybp1=ybp
batbox /w %delay%

:vf
batbox /k_
if %errorlevel%==32 (batbox /k)
if %errorlevel%==330 (call :left)
if %errorlevel%==332 (call :right)
goto screen


:: functions //
:left
if %xrp%==0 (goto vf)
set /a xrp-=4
exit /b

:right
if %xrp% gtr %xrp_max% (goto vf)
set /a xrp+=4
exit /b

:racket
for /l %%i in (1,1,%Raklng%) do (set sp= !sp!)
set racket=!sp!
exit /b

:Dimcon
For /f "Skip=3 tokens=2" %%a in ('mode con') do (set/a s+=1 & set "_!s!=%%a")
Endlocal && Set "%~1=%_1%" && Set "%~2=%_2%"
exit /b

:test_pos
set /a xrp_1=xrp , xrp_2= xrp + Raklng
set /a ybp_1= ybp_max - 1
if %ybp%==%ybp_1%  if %xbp% geq %xrp_1%  if %xbp% leq %xrp_2% (
    set /a score+=1
    set tscore=true
    set opy=-
    start wscript PS.vbs Pong.wav
    :: speed
    set /a spdt=%score% %% 10 + 1
    if !spdt!==10 (
        set /a delay-=2
        set "spd=|%spd%"
    )
)
exit /b

:lose
set /a score_!lifec! = score
set /a lifec-=1
start wscript PS.vbs Mist.wav
set life=!life:~0,%lifec%!
if %lifec%==0 (
    set /a finalscore= score_1 + score_2 + score_3
    batbox /c 0x07 /g 15 1 /d "Life :  "
    batbox /c 0x0c
    batbox /g 20 15 /a 32 /a 220 /a 219 /a 219 /a 219 /a 220 /a 32 /a 32 /a 32 /a 219 /a 219 /a 32 /a 32 /a 32 /a 219 /a 220 /a 32 /a 32 /a 32 /a 220 /a 219 /a 32 /a 219 /a 219 /a 219 /a 219 /a 32 /a 32 /a 32 /a 32 /a 32 /a 220 /a 219 /a 219 /a 220 /a 32 /a 32 /a 219 /a 32 /a 32 /a 32 /a 32 /a 32 /a 219 /a 32 /a 219 /a 219 /a 219 /a 219 /a 32 /a 219 /a 223 /a 220 
    batbox /g 20 16 /a 220 /a 223 /a 32 /a 32 /a 32 /a 223 /a 32 /a 32 /a 219 /a 32 /a 32 /a 219 /a 32 /a 32 /a 219 /a 32 /a 219 /a 32 /a 219 /a 32 /a 219 /a 32 /a 219 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 220 /a 223 /a 32 /a 32 /a 223 /a 220 /a 32 /a 219 /a 32 /a 32 /a 32 /a 32 /a 32 /a 219 /a 32 /a 219 /a 32 /a 32 /a 32 /a 32 /a 219 /a 32 /a 32 /a 219 
    batbox /g 20 17 /a 219 /a 32 /a 32 /a 32 /a 220 /a 220 /a 32 /a 220 /a 219 /a 219 /a 219 /a 219 /a 220 /a 32 /a 219 /a 32 /a 32 /a 219 /a 32 /a 32 /a 219 /a 32 /a 219 /a 219 /a 219 /a 219 /a 32 /a 32 /a 32 /a 32 /a 219 /a 32 /a 32 /a 32 /a 32 /a 219 /a 32 /a 32 /a 219 /a 32 /a 32 /a 32 /a 219 /a 32 /a 32 /a 219 /a 219 /a 219 /a 219 /a 32 /a 219 /a 254 /a 219 
    batbox /g 20 18 /a 223 /a 220 /a 32 /a 32 /a 32 /a 219 /a 32 /a 219 /a 32 /a 32 /a 32 /a 32 /a 219 /a 32 /a 219 /a 32 /a 32 /a 32 /a 32 /a 32 /a 219 /a 32 /a 219 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 32 /a 223 /a 220 /a 32 /a 32 /a 220 /a 223 /a 32 /a 32 /a 32 /a 219 /a 32 /a 219 /a 32 /a 32 /a 32 /a 219 /a 32 /a 32 /a 32 /a 32 /a 219 /a 32 /a 32 /a 219 
    batbox /g 20 19 /a 32 /a 223 /a 219 /a 219 /a 219 /a 223 /a 32 /a 219 /a 32 /a 32 /a 32 /a 32 /a 219 /a 32 /a 219 /a 32 /a 32 /a 32 /a 32 /a 32 /a 219 /a 32 /a 219 /a 219 /a 219 /a 219 /a 32 /a 32 /a 32 /a 32 /a 32 /a 223 /a 219 /a 219 /a 223 /a 32 /a 32 /a 32 /a 32 /a 32 /a 219 /a 32 /a 32 /a 32 /a 32 /a 219 /a 219 /a 219 /a 219 /a 32 /a 219 /a 32 /a 32 /a 32 /a 219 
    batbox /c 0x0e /g 32 22 /d "Press any key to restart" /c 0x0b /g 32 23 /d "Press escape to exit" /c 0x07 /g 32 25 /d "Note : Press space key to pause the game"
    batbox /c 0x07 /g 52 1 /d "Your final score is :" /g 74 1 /c 0x0a /d "!finalscore!"
    batbox /k
    if !errorlevel!==27 (exit)
    goto :GAME_BG
) else (
    batbox /c 0x0a /g 52 1 /d "Press any key to continue"
    batbox /k
    )
goto RESTART
:://