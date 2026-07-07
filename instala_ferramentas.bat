@echo off
setlocal enabledelayedexpansion
title Instalador de Ferramentas de Trabalho

:: Verifica privilegios de administrador sem depender de servicos do Windows
:: nem do PowerShell (metodos anteriores podem falhar em alguns sistemas).
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Solicitando privilegios de administrador...
    goto UACPrompt
) else (
    goto GotAdmin
)

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\elevate_instala.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\elevate_instala.vbs"
"%temp%\elevate_instala.vbs"
del "%temp%\elevate_instala.vbs" >nul 2>&1
exit /b

:GotAdmin
pushd "%CD%"
cd /d "%~dp0"

:: Verifica se o winget esta disponivel
where winget >nul 2>&1
if %errorlevel% neq 0 (
    echo O "winget" ^(Windows Package Manager^) nao foi encontrado neste sistema.
    echo Instale o "App Installer" pela Microsoft Store e execute este script novamente.
    pause
    exit /b 1
)

:menu
cls
echo ===============================================
echo   INSTALADOR DE FERRAMENTAS DE TRABALHO
echo ===============================================
echo.
echo  1. Instalar Git
echo  2. Instalar Node.js (LTS)
echo  3. Instalar Visual Studio Code
echo  4. Instalar Brave Browser
echo  5. Instalar GitHub Desktop
echo  6. Instalar Obsidian
echo  7. Instalar Discord
echo  8. Instalar Winhance
echo  9. Instalar UniGetUI
echo  10. Instalar/Habilitar WSL2
echo  11. Instalar Docker Desktop
echo  12. Instalar FFmpeg
echo  13. Instalar tudo (1-12)
echo  14. Verificar/instalar atualizacoes disponiveis
echo  0. Sair
echo.
set "opcao="
set /p "opcao=Escolha uma opcao: "

if "%opcao%"=="1"  (call :git       & echo. & pause & goto menu)
if "%opcao%"=="2"  (call :node      & echo. & pause & goto menu)
if "%opcao%"=="3"  (call :vscode    & echo. & pause & goto menu)
if "%opcao%"=="4"  (call :brave     & echo. & pause & goto menu)
if "%opcao%"=="5"  (call :ghdesktop & echo. & pause & goto menu)
if "%opcao%"=="6"  (call :obsidian  & echo. & pause & goto menu)
if "%opcao%"=="7"  (call :discord   & echo. & pause & goto menu)
if "%opcao%"=="8"  (call :winhance  & echo. & pause & goto menu)
if "%opcao%"=="9"  (call :unigetui  & echo. & pause & goto menu)
if "%opcao%"=="10" (call :wsl2      & echo. & pause & goto menu)
if "%opcao%"=="11" (call :docker    & echo. & pause & goto menu)
if "%opcao%"=="12" (call :ffmpeg    & echo. & pause & goto menu)
if "%opcao%"=="13" (call :todas     & echo. & pause & goto menu)
if "%opcao%"=="14" (call :checkupdates & echo. & pause & goto menu)
if "%opcao%"=="0" goto fim

echo.
echo Opcao invalida.
pause
goto menu

:git
echo.
echo [GIT] Instalando Git...
winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements
goto :eof

:node
echo.
echo [NODE.JS] Instalando Node.js LTS...
winget install --id OpenJS.NodeJS.LTS -e --source winget --accept-package-agreements --accept-source-agreements
goto :eof

:vscode
echo.
echo [VS CODE] Instalando Visual Studio Code...
winget install --id Microsoft.VisualStudioCode -e --source winget --accept-package-agreements --accept-source-agreements
goto :eof

:brave
echo.
echo [BRAVE] Instalando Brave Browser...
winget install --id BraveSoftware.BraveBrowser -e --source winget --accept-package-agreements --accept-source-agreements
goto :eof

:ghdesktop
echo.
echo [GITHUB DESKTOP] Instalando GitHub Desktop...
winget install --id GitHub.GitHubDesktop -e --source winget --accept-package-agreements --accept-source-agreements
goto :eof

:obsidian
echo.
echo [OBSIDIAN] Instalando Obsidian...
winget install --id Obsidian.Obsidian -e --source winget --accept-package-agreements --accept-source-agreements
goto :eof

:discord
echo.
echo [DISCORD] Instalando Discord...
winget install --id Discord.Discord -e --source winget --accept-package-agreements --accept-source-agreements
goto :eof

:winhance
echo.
echo [WINHANCE] Instalando Winhance...
winget install --id memstechtips.Winhance -e --source winget --accept-package-agreements --accept-source-agreements
goto :eof

:unigetui
echo.
echo [UNIGETUI] Instalando UniGetUI...
winget install --id Devolutions.UniGetUI -e --source winget --accept-package-agreements --accept-source-agreements
goto :eof

:wsl2
echo.
echo [WSL2] Instalando/Habilitando o WSL2...
echo Isso pode exigir reinicializacao do computador para concluir.
wsl --install
wsl --set-default-version 2
goto :eof

:docker
echo.
echo [DOCKER] Instalando Docker Desktop...
echo Obs: o Docker Desktop usa o WSL2 como backend. Instale/habilite o WSL2
echo antes (opcao 10) e reinicie o computador se for a primeira instalacao.
winget install --id Docker.DockerDesktop -e --source winget --accept-package-agreements --accept-source-agreements
goto :eof

:ffmpeg
echo.
echo [FFMPEG] Instalando FFmpeg...
winget install --id Gyan.FFmpeg -e --source winget --accept-package-agreements --accept-source-agreements
goto :eof

:checkupdates
echo.
echo [ATUALIZACOES] Pacotes com atualizacao disponivel:
echo.
winget upgrade
echo.
set "confirma="
set /p "confirma=Deseja atualizar todos os pacotes listados acima? (S/N): "
if /i "%confirma%"=="S" (
    echo.
    echo Atualizando todos os pacotes...
    winget upgrade --all --accept-package-agreements --accept-source-agreements
) else (
    echo Operacao cancelada.
)
goto :eof

:todas
call :git
call :node
call :vscode
call :brave
call :ghdesktop
call :obsidian
call :discord
call :winhance
call :unigetui
call :wsl2
call :docker
call :ffmpeg
echo.
echo Instalacao concluida! Reinicie o computador se o WSL2/Docker exigirem.
goto :eof

:fim
echo.
echo Saindo...
timeout /t 2 >nul
exit /b 0
