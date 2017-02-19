@echo off
set /p AIDP=Quelle est l'adresse IP de la machine ?
netsh interface ip set address "Connexion au r‚seau local 2" static %AIDP% 255.255.0.0 172.16.0.1 1

echo L'adresse IP de la machine  … ‚t‚ modifi‚e avec succŠs
echo.

echo Changement des DNS en cours
echo.

netsh interface ip add dns "Connexion au r‚seau local 2" 172.16.0.6 1>nul
netsh interface ip add dns "Connexion au r‚seau local 2" 172.16.0.5 1>nul

echo Ajout des DNS au WINS
echo.
netsh interface ip add wins "Connexion au r‚seau local 2" 172.16.0.6 1 1>nul
netsh interface ip add wins "Connexion au r‚seau local 2" 172.16.0.5 2 1>nul

echo Configuration DNS effectu‚e avec succŠs
echo.

pause
cls

wmic nicconfig get caption,index

set /p NIX=Quel est l'index de la carte r‚seau sur laquelle activer NetBIOS sur TCP/IP ?


wmic nicconfig where index=%NIX% call SetTcpipNetbios 1 1>nul
echo NetBIOS sur TCP/IP activ‚
echo.
pause
cls

echo Activation du compte Administrateur
echo.

net user administrateur /active:yes 1>nul

set /P MDPA=Quel mot de passe attribuer au compte administrateur?
net user administrateur %MDPA% 1>nul

echo Suppression de l'utilisateur actif
echo.
net user %username% /delete 1>nul

echo Configuration utilisateur effectu‚e
echo.

pause
cls

echo Fermeture de la session...
echo Veuillez lancer Script_admin.bat dans la session administrateur
pause

shutdown /l






