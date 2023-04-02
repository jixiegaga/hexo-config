@echo on
echo 正在执行一键部署文章,请稍等...
start powershell.exe -ExecutionPolicy RemoteSigned -File "D:\Personal Blog\hexo-config\一键部署文章.ps1"
:wait
timeout /t 1 >nul
tasklist /FI "IMAGENAME eq powershell.exe" | find /i "powershell.exe" >nul && goto wait
echo 一键部署文章执行完毕,正在上传hexo配置,请稍等...
set "sourcePath=D:\Personal Blog\hexo"
set "destinationPath=D:\Personal Blog\hexo-config"
xcopy /s /i /y "%sourcePath%\scaffolds" "%destinationPath%\scaffolds"
xcopy /s /i /y "%sourcePath%\source" "%destinationPath%\source"
xcopy /s /i /y "%sourcePath%\themes" "%destinationPath%\themes"
xcopy /i /y "%sourcePath%\.gitignore" "%destinationPath%"
xcopy /i /y "%sourcePath%\_config.butterfly.yml" "%destinationPath%"
xcopy /i /y "%sourcePath%\_config.landscape.yml" "%destinationPath%"
xcopy /i /y "%sourcePath%\db.json" "%destinationPath%"
xcopy /i /y "%sourcePath%\_config.yml" "%destinationPath%"
xcopy /i /y "%sourcePath%\package.json" "%destinationPath%"
xcopy /i /y "%sourcePath%\package-lock.json" "%destinationPath%"
cd /d "%destinationPath%"
git add .
git commit -m "auto update"
git push origin master
echo hexo配置上传完毕!
echo 一键部署并上传完毕!
pause
exit
