Function Remove-CTLCert{

    <#
    .SYNOPSIS
    	Removes a certificate from the Certificate Trust List store.

    .DESCRIPTION
    	Exposes the PACLI Function: "CTLREMOVECERT"

    .PARAMETER ctlFileName
    	The name of the CTL file to remove from the CTL store. If this
        parameter is not supplied, the CTL file name that was supplied in
        the INIT function is used.

    .PARAMETER certFileName
        The full path and name of the certificate file.
        
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
        [Parameter(Mandatory=$False)][string]$ctlFileName,
        [Parameter(Mandatory=$False)][string]$certFileName,
        [Parameter(Mandatory=$False)][int]$sessionID
    )

    If(!(Test-ExePreReqs)){

            #$pacli variable not set or not a valid path

    }

    Else{

        #$PACLI variable set to executable path
                    
        $Return = Invoke-PACLICommand $pacli CTLREMOVECERT $($PSBoundParameters.getEnumerator() | ConvertTo-ParameterString)
        
        if($Return.ExitCode){
            
            Write-Debug $Return.StdErr
            $FALSE

        }
        
        else{
        
            $TRUE
            
        }
        
    }

}