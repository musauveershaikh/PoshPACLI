#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repository Root folder
$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

BeforeAll {

	#$Script:RequestBody = $null

}

AfterAll {

	#$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Context "Default" {

			BeforeEach {

				$InputObj = [PSCustomObject]@{
					vault = "SomeVault"
					user = "SomeUser"
				}

				Mock Invoke-PACLICommand -MockWith {
					[PSCustomObject]@{
						StdOut="SomeOutput"
						ExitCode=0
					}
				}

			}

			It "executes without exception" {

				{$InputObj | Unlock-PVUser} | Should Not throw

			}

			It "invokes expected pacli command" {

				$InputObj | Unlock-PVUser -password $(ConvertTo-SecureString SomePassword -AsPlainText -Force)

				Assert-MockCalled Invoke-PACLICommand -Times 1 -Exactly -Scope It -ParameterFilter {

					$PacliCommand -eq "UNLOCK"

				}

			}

		}

	}

}