@echo on
echo 正在从git上拉取配置, 请稍等...
git pull origin master
echo 配置拉取完成!
echo 正在更新本地hexo配置, 请稍等...
set "destinationPath=D:\Personal Blog\hexo"
set "sourcePath=D:\Personal Blog\hexo-config"
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
echo 一键更新本地hexo配置完成!
pause
exit