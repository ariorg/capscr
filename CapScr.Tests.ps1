Describe "CapScr Test Group" {
    BeforeAll {
        . .\CapScr.ps1
    }

    Context 'Write-ScreenshotWin tests' {
        
        BeforeAll {
            Push-Location
            Set-Location $TestDrive
        }

        AfterAll { 
            Pop-Location
        }
        
        It 'should create current-datetime-named-screenshotfile if no filename supplied' {
            Set-Variable someDate -Option Constant -Value [DateTime]"07/06/2015 05:00:10" 

            mock -CommandName 'Get-Date' –MockWith {
                param($Format)
                Write-Host ($someDate).toString("yyyy-MM-dd")
                $someDate.toString($Format)
            }

            [String]$fileDateFormat = $someDate.toString($Format)
            [String]$screenShotFilename = "$fileDateFormat.jpg"

            $screenShotFilename | Should -Not -Exist
            Write-Screenshot
            $screenShotFilename | Should -Exist
        }
    }
}
