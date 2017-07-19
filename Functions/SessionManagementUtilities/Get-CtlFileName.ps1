Function Get-CtlFileName{

    <#
    .SYNOPSIS
    	Returns the name of the Certificate Trust List (CTL) that was defined 
        during the Start-Pacli function.

    .DESCRIPTION
    	Exposes the PACLI Function: "CTLGETFILENAME"

    .PARAMETER sessionID
    	The ID number of the session. Use this parameter when working
        with multiple scripts simultaneously. The default is ‘0’.

    .EXAMPLE
    	A sample command that uses the function or script, optionally followed
    	by sample output and a description. Repeat this keyword for each example.

    .NOTES
    	AUTHOR: Pete Maan
    	LASTEDIT: July 2017
    #>
    
    [CmdLetBinding()]
    param(
        [Parameter(Mandatory=$False)][int]$sessionID
    )

    If(!(Test-ExePreReqs)){

            #$pacli variable not set or not a valid path

    }

    Else{

        #$PACLI variable set to executable path
                    
        $Return = Invoke-PACLICommand $pacli CTLGETFILENAME "$($PSBoundParameters.getEnumerator() | ConvertTo-ParameterString) OUTPUT (ALL,ENCLOSE)"
        
        if($Return.ExitCode){
            
            Write-Debug $Return.StdErr

        }
        
        else{
        
            #if result(s) returned
            if($Return.StdOut){
                
                #Convert Output to array
                $Results = (($Return.StdOut | Select-String -Pattern "\S") | ConvertFrom-PacliOutput)
                
                #Output Object
                [PSCustomObject] @{

                    "Name"=$Results[0]

                }
                
            }
            
        }
        
    }

}