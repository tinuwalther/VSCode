function Test-IsAdministrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

function prompt
{

    if (Test-IsAdministrator) {
        $color = 'Red'
    }
    else{
        $color = 'Green'
    }
    Import-Module -Name CompletionPredictor
    Set-PSReadLineOption -PredictionViewStyle ListView
    $vscode = (code --version)[0]
    $history = Get-History -ErrorAction Ignore
    $Version = "$($PSVersionTable.PSVersion.Major).$($PSVersionTable.PSVersion.Minor).$($PSVersionTable.PSVersion.Patch)"
    Write-Host "[$($history.count[-1])] " -NoNewline
    Write-Host "[$(($env:UserName).ToUpper())@$($env:COMPUTERNAME)] [VSCode $($vscode)] " -ForegroundColor $color -NoNewline
    Write-Host ("I ") -nonewline
    Write-Host (([char]9829) ) -ForegroundColor $color -nonewline
    Write-Host (" PS $Version ") -nonewline
    Write-Host ("$(get-location) ") -foregroundcolor $color -nonewline
    Write-Host (">") -nonewline
    return " "

}