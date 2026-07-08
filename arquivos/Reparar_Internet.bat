@echo off
title Reparo de Rede - Windows
color 0A

echo ==========================================
echo        REPARO AUTOMATICO DE REDE
echo ==========================================
echo.

:: Verifica se esta sendo executado como Administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo Este script precisa ser executado como ADMINISTRADOR.
    echo Clique com o botao direito e escolha:
    echo "Executar como administrador".
    pause
    exit
)

echo [1/9] Liberando endereco IP...
ipconfig /release

echo.
echo [2/9] Renovando endereco IP...
ipconfig /renew

echo.
echo [3/9] Limpando cache DNS...
ipconfig /flushdns

echo.
echo [4/9] Registrando DNS...
ipconfig /registerdns

echo.
echo [5/9] Redefinindo Winsock...
netsh winsock reset

echo.
echo [6/9] Redefinindo TCP/IP...
netsh int ip reset

echo.
echo [7/9] Redefinindo IPv4...
netsh int ipv4 reset

echo.
echo [8/9] Redefinindo IPv6...
netsh int ipv6 reset

echo.
echo [9/9] Removendo configuracoes de Proxy...
netsh winhttp reset proxy

echo.
echo ==========================================
echo        INFORMACOES DA REDE
echo ==========================================
ipconfig /all

echo.
echo ==========================================
echo        TESTANDO CONECTIVIDADE
echo ==========================================

echo.
echo Gateway:
ipconfig | findstr "Gateway"

echo.
echo Testando Google DNS (8.8.8.8)...
ping -n 4 8.8.8.8

echo.
echo Testando resolucao de nomes...
ping -n 4 google.com

echo.
echo ==========================================
echo Reparo concluido.
echo.
choice /C SN /M "Deseja reiniciar o computador agora"

if errorlevel 2 goto fim
shutdown /r /t 5

:fim
echo.
echo Reinicializacao cancelada.
pause