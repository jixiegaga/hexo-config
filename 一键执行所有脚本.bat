@echo on
echo ����ִ��һ���������£����Ե�...
start powershell.exe -ExecutionPolicy RemoteSigned -File "D:\Personal Blog\hexo-config\һ����������.ps1"
:wait
timeout /t 1 >nul
tasklist /FI "IMAGENAME eq powershell.exe" | find /i "powershell.exe" >nul && goto wait
echo һ����������ִ����ϣ�����ִ��һ��ͬ�������Ե�...
start "" "D:\Personal Blog\hexo-config\һ��ͬ��.bat"
echo һ��ͬ��ִ����ϡ�
echo ���������!
pause
exit
