@echo on
echo 正在执行一键部署文章，请稍等...
start powershell.exe -ExecutionPolicy RemoteSigned -File "D:\Personal Blog\hexo-config\一键部署文章.ps1"
:wait
timeout /t 1 >nul
tasklist /FI "IMAGENAME eq powershell.exe" | find /i "powershell.exe" >nul && goto wait
echo 一键部署文章执行完毕，正在执行一键同步，请稍等...
start "" "D:\Personal Blog\hexo-config\一键同步.bat"
echo 一键同步执行完毕。
echo 程序已完成!
pause
exit
