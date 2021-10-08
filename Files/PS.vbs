Set Sound = CreateObject("WMPlayer.OCX.7")
Sound.URL = WScript.Arguments(0)
Sound.Controls.play
do while Sound.currentmedia.duration = 0
wscript.sleep 1
loop
wscript.sleep (int(Sound.currentmedia.duration)+1)*1000


'how to use 
'start wscript PS.vbs xx.wav