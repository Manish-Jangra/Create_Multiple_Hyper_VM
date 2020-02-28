Copy-Item -Path "\\Server\Share\WinPE_Images\RestoreImage_x64.iso" -Destination "C:\Users\$ENV:UserName\Documents" -Force -Verbose

$VMNames = Get-Content -Path "C:\Users\username\Documents\vms.json"
ForEach ($VMName in $VMNames) {
    New-VM -Name $VMName -Generation 1 -MemoryStartupBytes 8GB -NewVHDPath "C:\Hyper-V\VHD\$($VMName).vhdx" -NewVHDSizeBytes 70GB -SwitchName "Network_Switch"
    Set-VM -Name $VMName -ProcessorCount 2
    Set-VMDvdDrive -VMName $VMName  -Path "C:\Users\manikuma\Documents\RestoreImage_x64.iso"
    Get-VM -Name $VMName | Set-VMBios -StartupOrder @("IDE","CD","LegacyNetworkAdapter","Floppy")
    Start-VM -Name $VMName
} 
