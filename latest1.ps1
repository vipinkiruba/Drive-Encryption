if($($args.Count) -eq 0){
    Write-Output "No Drive Parameters passed for Encryption"
    Write-Output "Encryption Aborted"
    exit
}
elseif(($args[0] -eq 'all') -or ($args[0] -eq 'All') -or ($args[0] -eq 'ALL')){
    $Drive_Letters = get-wmiobject -Class Win32_Volume | where{$_.drivetype -eq '3'}
    ForEach ($Drives in $Drive_Letters.DriveLetter) {
        if($Drives.Length -ne 0){
            $Apath= $Drives.Substring(0,1)
            $Apath= "D:\DriveEncryptionKey\$Apath.txt" 
            Enable-Bitlocker -MountPoint $Drives -UsedSpaceOnly -SkipHardwareTest -RecoveryPasswordProtector 3> $Apath
        }
    }
}
else{
    for ($i=0; $i -lt $($args.Count); $i++)
    {
        $Apath= "D:\DriveEncryptionKey\$($args[$i]).txt" 
        Enable-Bitlocker -MountPoint $($args[$i]) -UsedSpaceOnly -SkipHardwareTest -RecoveryPasswordProtector 3> $Apath
    }
}
