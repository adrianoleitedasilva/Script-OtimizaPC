@echo off
setlocal enabledelayedexpansion
title Ferramenta de Otimizacao do Windows

:: Verifica se esta rodando como administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Este script precisa ser executado como Administrador.
    pause
    exit /b 1
)

:menu
cls
echo ===============================================
echo   FERRAMENTA DE OTIMIZACAO DO WINDOWS
echo ===============================================
echo.
echo  1. Verificar integridade do sistema (SFC)
echo  2. Verificar disco (CHKDSK)
echo  3. Limpar cache DNS
echo  4. Limpar arquivos temporarios
echo  5. Limpar cache de atualizacoes do Windows
echo  6. Desfragmentar/Otimizar disco (C:)
echo  7. Limpar logs de eventos antigos
echo  8. Gerenciar/Limpar Pontos de Restauracao
echo  9. Reiniciar servico especifico (spooler, etc.)
echo  10. Liberar RAM/cache do sistema
echo  11. Executar tarefas basicas (1-5)
echo  0. Sair
echo.
set "opcao="
set /p "opcao=Escolha uma opcao: "

if "%opcao%"=="1"  (call :sfc           & echo. & pause & goto menu)
if "%opcao%"=="2"  (call :chkdsk        & echo. & pause & goto menu)
if "%opcao%"=="3"  (call :dns           & echo. & pause & goto menu)
if "%opcao%"=="4"  (call :temp          & echo. & pause & goto menu)
if "%opcao%"=="5"  (call :wuclean       & echo. & pause & goto menu)
if "%opcao%"=="6"  (call :defrag        & echo. & pause & goto menu)
if "%opcao%"=="7"  (call :eventlogs     & echo. & pause & goto menu)
if "%opcao%"=="8"  (call :restorepoints & echo. & pause & goto menu)
if "%opcao%"=="9"  (call :services      & echo. & pause & goto menu)
if "%opcao%"=="10" (call :ramclean      & echo. & pause & goto menu)
if "%opcao%"=="11" (call :todas         & echo. & pause & goto menu)
if "%opcao%"=="0" goto fim

echo.
echo Opcao invalida.
pause
goto menu

:sfc
echo.
echo [SFC] Verificando integridade do sistema...
sfc /scannow
goto :eof

:chkdsk
echo.
echo [CHKDSK] Verificando disco...
chkdsk C: /scan
goto :eof

:dns
echo.
echo [DNS] Limpando cache DNS...
ipconfig /flushdns
goto :eof

:temp
echo.
echo [TEMP] Limpando arquivos temporarios...
del /q /f /s "%temp%\*" >nul 2>&1
del /q /f /s "%windir%\Temp\*" >nul 2>&1
echo Concluido.
goto :eof

:wuclean
echo.
echo [WINDOWS UPDATE] Limpando cache de atualizacoes...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
if exist "%windir%\SoftwareDistribution" (
    rd /s /q "%windir%\SoftwareDistribution"
)
net start bits >nul 2>&1
net start wuauserv >nul 2>&1
echo Concluido.
goto :eof

:defrag
echo.
echo [DEFRAG] Otimizando disco C:...
echo Isso pode demorar bastante dependendo do tamanho e uso do disco.
defrag C: /O
goto :eof

:eventlogs
echo.
echo [LOGS] Esta acao vai limpar TODOS os logs de eventos do Windows.
echo Isso e irreversivel e pode dificultar diagnosticos futuros.
set "confirma="
set /p "confirma=Digite CONFIRMAR para continuar: "
if /i not "%confirma%"=="CONFIRMAR" (
    echo Operacao cancelada.
    goto :eof
)
for /f "tokens=*" %%G in ('wevtutil el') do (
    wevtutil cl "%%G" >nul 2>&1
)
echo Logs de eventos limpos.
goto :eof

:restorepoints
echo.
echo [RESTAURACAO] Gerenciar Pontos de Restauracao
echo.
echo  1. Excluir o ponto de restauracao mais antigo
echo  2. Excluir TODOS os pontos de restauracao
echo  0. Voltar
echo.
set "subopcao="
set /p "subopcao=Escolha uma opcao: "

if "%subopcao%"=="1" (
    vssadmin delete shadows /for=C: /oldest
    goto :eof
)
if "%subopcao%"=="2" (
    echo.
    echo Isso vai apagar TODOS os pontos de restauracao do sistema.
    set "confirma="
    set /p "confirma=Digite CONFIRMAR para continuar: "
    if /i "!confirma!"=="CONFIRMAR" (
        vssadmin delete shadows /for=C: /all /quiet
        echo Pontos de restauracao removidos.
    ) else (
        echo Operacao cancelada.
    )
)
goto :eof

:services
echo.
echo [SERVICOS] Reiniciar servico especifico
echo.
echo  1. Fila de Impressao (Spooler)
echo  2. Transferencia Inteligente - BITS
echo  3. Windows Search (WSearch)
echo  4. Windows Audio (Audiosrv)
echo  5. Cliente DNS (Dnscache)
echo  6. Digitar nome do servico manualmente
echo  0. Voltar
echo.
set "svcopcao="
set /p "svcopcao=Escolha uma opcao: "

set "svcnome="
if "%svcopcao%"=="1" set "svcnome=Spooler"
if "%svcopcao%"=="2" set "svcnome=BITS"
if "%svcopcao%"=="3" set "svcnome=WSearch"
if "%svcopcao%"=="4" set "svcnome=Audiosrv"
if "%svcopcao%"=="5" set "svcnome=Dnscache"
if "%svcopcao%"=="6" set /p "svcnome=Digite o nome do servico (ex: Spooler): "
if "%svcopcao%"=="0" goto :eof

if not defined svcnome (
    echo Opcao invalida.
    goto :eof
)

echo.
echo Reiniciando servico "%svcnome%"...
net stop "%svcnome%"
net start "%svcnome%"
echo Concluido.
goto :eof

:ramclean
echo.
echo [RAM] Liberando memoria e caches do sistema...
echo Obs: o Windows gerencia a RAM automaticamente; isto apenas executa
echo tarefas ociosas do sistema e reinicia o Explorer (libera cache de
echo icones/thumbnails). Nao e um "otimizador magico" de memoria.
echo.
echo Executando tarefas ociosas do sistema (pode demorar um pouco)...
rundll32.exe advapi32.dll,ProcessIdleTasks
echo.
echo Reiniciando o Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo Concluido.
goto :eof

:todas
call :sfc
call :chkdsk
call :dns
call :temp
call :wuclean
echo Tarefas basicas concluidas!
goto :eof

:fim
echo.
echo Saindo...
timeout /t 2 >nul
exit /b 0
