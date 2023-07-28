function Test-IsAdministrator {
    [CmdletBinding()]
    param(
        $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    )
    return (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function prompt {
    [CmdletBinding()]
    param()

    if (Test-IsAdministrator) {
        $color = 'Red'
    }
    else{
        $color = 'Green'
    }
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Import-Module -Name CompletionPredictor
    Set-PSReadLineOption -PredictionViewStyle ListView
    $history = Get-History -ErrorAction Ignore
    $Version = "$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor).$($PSVersionTable.PSVersion.Patch)"
    Write-Host "[$($history.count[-1])] " -NoNewline
    if ($Host.Name -eq 'Visual Studio Code Host') {
        $vscode = (code --version)[0]
        Write-Host "[$(($env:UserName).ToUpper())@$($env:COMPUTERNAME)] [$($Host.Name) $($vscode)] $CurrentOS " -ForegroundColor $color -NoNewline
    }else{
        Write-Host "[$(($env:UserName).ToUpper())@$($env:COMPUTERNAME)] [$($Host.Name)] " -ForegroundColor $color -NoNewline
    }
    Write-Host ("I ") -nonewline
    Write-Host (([char]9829) ) -ForegroundColor $color -nonewline
    Write-Host (" PS $Version ") -nonewline
    Write-Host ("$(get-location) ") -foregroundcolor $color -nonewline
    Write-Host (">") -nonewline
    return " "

}