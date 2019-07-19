;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here
e.=explorer .
ls=ls --show-control-chars -F --color $*
pwd=cd
clear=cls
history=cat "%CMDER_ROOT%\config\.history"
unalias=alias /d $1
vi=vim $*
cmderr=cd /d "%CMDER_ROOT%"
ll=ls -al --color 

;= git
gl="C:\Program Files\Git\cmd\git.exe" log --oneline --graph  
grpo="C:\Program Files\Git\cmd\git.exe" remote prune origin
gbr=for /f "delims=" %a in ('git rev-parse --abbrev-ref HEAD') do @set myvar=%a 
gpsup=for /f "delims=" %a in ('git rev-parse --abbrev-ref HEAD') do @set myvar=%a && "C:\Program Files\Git\cmd\git.exe" push --set-upstream origin %myvar%
gcd="C:\Program Files\Git\cmd\git.exe" checkout develop
gst="C:\Program Files\Git\cmd\git.exe" status

;= navigation
gowork=cd /d "C:\WS"
gotomy=cd /d "c:\users\catoan"
..=cd ../
...=cd ../../
....=cd ../../../

;= nvim
;=vim=nvim
