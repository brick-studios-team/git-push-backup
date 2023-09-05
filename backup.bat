@echo off
setlocal enabledelayedexpansion

:: Ask the user for GitHub Organization and Personal Access Token
set /p organization=Enter GitHub Organization: 
set /p personal_access_token=Enter GitHub Personal Access Token: 

:: Use the for /d loop to enumerate subfolders
for /d %%i in ("%cd%\*") do (
    set "subfolders=%%~nxi"
    cd "%%i"
	
	echo Creating repository in folder "%%i"
    curl -X POST -H "Authorization: token %personal_access_token%" -d "{\"name\":\"!subfolders!\",\"private\":true}" https://api.github.com/orgs/%organization%/repos

    git remote remove push
    git remote add push https://github.com/%organization%/!subfolders!.git
    git push -u push
)

endlocal
