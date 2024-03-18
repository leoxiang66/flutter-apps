Outfile "WeatherForecastTuningInstaller.exe"
InstallDir $PROGRAMFILES\WeatherForecastTuning
InstallDirRegKey HKCU "Software\WeatherForecastTuning" ""

Page directory
Page instfiles

Section "WeatherForecastTuning"
    SetOutPath $INSTDIR
    File /r "C:\Users\xiang\git\flutterapps\my_windows_project\build\windows\runner\Release\*"
    
    WriteUninstaller $INSTDIR\Uninstall.exe

    CreateDirectory $SMPROGRAMS\WeatherForecastTuning
    CreateShortCut "$SMPROGRAMS\WeatherForecastTuning\WeatherForecastTuning.lnk" "$INSTDIR\WeatherForecastTuning.exe"
    CreateShortCut "$SMPROGRAMS\WeatherForecastTuning\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
    CreateShortCut "$DESKTOP\WeatherForecastTuning.lnk" "$INSTDIR\WeatherForecastTuning.exe"
SectionEnd

Section "Uninstall"
    Delete $INSTDIR\Uninstall.exe
    RMDir /r $INSTDIR

    Delete $SMPROGRAMS\WeatherForecastTuning\WeatherForecastTuning.lnk
    Delete $SMPROGRAMS\WeatherForecastTuning\Uninstall.lnk
    RMDir $SMPROGRAMS\WeatherForecastTuning

    Delete $DESKTOP\WeatherForecastTuning.lnk

    DeleteRegKey /ifempty HKCU "Software\WeatherForecastTuning"
SectionEnd
