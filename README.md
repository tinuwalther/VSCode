# VSCode
My Visual Studio Code samples

## Snippets

### Write functions in 3 seconds

Every time you need a new function in Visual Studio Code, enter mwa + tab, and you get a new function from my snippet.

To create your own snippet or to add my snippet, select Manage, User Snippets (Ctrl. + Shift + P) > Preferences > Configure User Snippets > PowerShell

Copy the content from Data/user-data/User/snippets/powershell.json to the new snippet.

Open a new File (Ctrl. + N), Select a language (Ctrl. K  wait and then press M) enter powershell, enter mwa + tab and here you have a cool function written in 3 seconds.

Change the name of the function to your own Verb-PrefixNoun and fill the code in the process section between the try-catch-statement.

````powershell
<#
.SYNOPSIS
    A short one-line action-based description, e.g. 'Tests if a function is valid'
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
.PARAMETER InputObject
    Specify the input of this parameter.
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.EXAMPLE
    New-MwaFunction @{Name='MyName';Value='MyValue'} -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>
function New-MwaFunction {
    [CmdletBinding(SupportsShouldProcess=$True)]
    param(
        #region parameter, to add a new parameter, copy and paste the Parameter-region
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            Position = 0
        )]
        [Object] $InputObject
        #endregion
    )

    begin{
        #region Do not change this region
        $StartTime = Get-Date
        $function = $($MyInvocation.MyCommand.Name)
        Write-Verbose $('[', (Get-Date -f 'yyyy-MM-dd HH:mm:ss.fff'), ']', '[ Begin   ]', $function -Join ' ')
        #endregion
    }

    process{
        Write-Verbose $('[', (Get-Date -f 'yyyy-MM-dd HH:mm:ss.fff'), ']', '[ Process ]', $function -Join ' ')
        foreach($item in $PSBoundParameters.keys){ $params = "$($params) -$($item) $($PSBoundParameters[$item])" }
        if ($PSCmdlet.ShouldProcess($params.Trim())){
            try{
                $ret = [PSCustomObject]$InputObject
                if($ret){
                    $ret
                }else{
                    throw 'There is something wrong in paradise'
                }
            }catch{
                Write-Warning $('ScriptName:', $($_.InvocationInfo.ScriptName), 'LineNumber:', $($_.InvocationInfo.ScriptLineNumber), 'Message:', $($_.Exception.Message) -Join ' ')
                $Error.Clear()
            }
        }
    }

    end{
        #region Do not change this region
        Write-Verbose $('[', (Get-Date -f 'yyyy-MM-dd HH:mm:ss.fff'), ']', '[ End     ]', $function -Join ' ')
        $TimeSpan  = New-TimeSpan -Start $StartTime -End (Get-Date)
        $Formatted = $TimeSpan | ForEach-Object {
            '{1:0}h {2:0}m {3:0}s {4:000}ms' -f $_.Days, $_.Hours, $_.Minutes, $_.Seconds, $_.Milliseconds
        }
        Write-Verbose $('Finished in:', $Formatted -Join ' ')
        #endregion
    }
}

New-MwaFunction -InputObject @{Firstname='Martin';Name='Walther'} -Verbose -WhatIf
````

If you prefere the old PowerShell ISE, then follow the instructions [here](https://github.com/tinuwalther/PowerShell_ISE).
