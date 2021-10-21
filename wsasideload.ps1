Add-Type -AssemblyName System.Windows.Forms

$FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
    InitialDirectory = [Environment]::GetFolderPath('Desktop') 
    Filter = 'Android App (*.apk)|*.apk'
}
$null = $FileBrowser.ShowDialog()

push-location "$PSScriptRoot\platform-tools"

$prefix = [io.path]::GetFileNameWithoutExtension("$($FileBrowser.FileName)")
$dir = [io.path]::GetDirectoryName("$($FileBrowser.FileName)")

$prefix

$packages = foreach ( $item in (Get-item "$dir\$($prefix)*" | Sort-Object -Property Name).Name ) {'"'+"$dir\$item"+'"'}
$packagelist = $packages -join " "

write-host $packagelist

Start-Process .\adb -argumentlist 'install-multiple', $packagelist -NoNewWindow -Wait

Pop-Location