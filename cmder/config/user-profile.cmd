:: use this file to run your own startup commands
:: use  in front of the command to prevent printing the command

:: uncomment this to have the ssh agent load when cmder starts
call "%GIT_INSTALL_ROOT%/cmd/start-ssh-agent.cmd"

:: uncomment this next two lines to use pageant as the ssh authentication agent
:: SET SSH_AUTH_SOCK=/tmp/.ssh-pageant-auth-sock
:: call "%GIT_INSTALL_ROOT%/cmd/start-ssh-pageant.cmd"

:: you can add your plugins to the cmder path like so
:: set "PATH=%CMDER_ROOT%\vendor\whatever;%PATH%"

@echo off
ssh-agent | grep -v echo | sed -e "s/^/@set /" | sed -e "s/;.*$//" - > call.cmd
call call.cmd
del call.cmd
ssh-add "%HOME%\.ssh\id_rsa"
