Push-Location $PsScriptRoot

Add-Type -AssemblyName System.Windows.Forms

$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
    InitialDirectory = [Environment]::GetFolderPath('Desktop') 
    Filter = 'Android App (*.apk)|*.apk'
}
$null = $FileBrowser.ShowDialog()

.\platform-tools\adb install "$($FileBrowser.FileName)"

Pop-Location