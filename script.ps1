New-Item -ItemType Directory -Path D:\ps1Scripting -Name DriveEncryptionKey

if($($args.Count) -le 0){
    $Drive_Letters = Get-WmiObject Win32_LogicalDisk
     ForEach ($Drives in $Drive_Letters.DeviceID) {
        $Apath= $Drives.Substring(0,1)
        $Apath= "D:\ps1Scripting\DriveEncryptionKey\$Apath.txt" 
        Enable-Bitlocker -MountPoint $Drives -UsedSpaceOnly -SkipHardwareTest -RecoveryPasswordProtector 3> $Apath
       #Write-Warning $Drives.Substring(0,1) 
    }
 }else {
    for ($i=0; $i -lt $($args.Count); $i++)
    {
        $Apath= "D:\ps1Scripting\DriveEncryptionKey\$($args[$i]).txt" 
        Enable-Bitlocker -MountPoint $($args[$i]) -UsedSpaceOnly -SkipHardwareTest -RecoveryPasswordProtector 3> $Apath
    }

 }
