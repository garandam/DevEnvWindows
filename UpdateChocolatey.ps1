$here = Split-Path -parent $MyInvocation.MyCommand.Definition
$script = $MyInvocation.MyCommand.Name

$identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object System.Security.Principal.WindowsPrincipal($identity)
if (-not $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Not running with administrative rights. Attempting to elevate..."
    $command = "-ExecutionPolicy bypass -File `"$here\$script`""
    Start-Process powershell -verb runas -argumentlist $command
    Exit
}

Write-Host "`n========= Install or Update Packages ========="
$todo = Read-Host 'Install or Update Packages? install/update'

If(($todo -eq "install") -or ($todo -eq "Install") -or ($todo -eq "i") -or ($todo -eq "I")){

    Write-Host "`n========= Install packages... ========="
    & choco install git -y
    & choco install cmder -y
    & choco install jdk8 -y
    & choco install gradle -y 
    & choco install maven -y
    & choco install intellijidea-ultimate -y
    & choco install visualstudiocode -y
    & choco install sourcetree -y
    & choco install putty -y

    & choco install nodejs -y

    & choco install 7zip.install -y
    & choco install evernote -y
    & choco install keepass -y

    # VMs with Hyper-V
    & choco install docker-for-windows -y
    
    # HashiCorp
    & choco install vagrant -y
    & choco install packer -y
    & choco install terraform -y
    & choco install vault -y
    & choco install consul -y
    & choco install nomad -y


} Elseif (($todo -eq "update") -or ($todo -eq "Update") -or ($todo -eq "u") -or ($todo -eq "U")) {
    Write-Host "`n========= Updating chocolatey... ========="
    & choco upgrade -y all
}
else{ 
    Write-Host -BackgroundColor White -ForegroundColor Red "INVALID ENTRY! Please try again."
}

Write-Host "Press any key to continue..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")