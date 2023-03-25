@echo on
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
echo Ç¨ÒÆ½Å±¾Íê³É!
exit