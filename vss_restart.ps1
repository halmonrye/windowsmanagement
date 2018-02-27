﻿<#
[System.Collections.ArrayList]$ServicesToRestart = @()
[System.Collections.ArrayList]$FailedVSSWriters = @()
[System.String]$writers = ""

function Custom-GetDependServices ($ServiceInput)
	[system.io.file]::WriteAllLines($Directory + "restart_"+ $ServicesFile, $ServicesToRestart)
	Write-Host "$(Get-Date -UFormat "%Y-%m-%d_%H:%M:%S") -------------------------------------------"
        $_.Context.PostContext[2].Trim() -ne "state: [1] stable" -or
        $_.Context.PostContext[3].Trim() -ne "last error: no error"
    } 
        $servicename = $_
   Custom-GetDependServices -ServiceInput $Service
   Custom-GetDependServices -ServiceInput $Service
   Custom-GetDependServices -ServiceInput $Service
   Custom-GetDependServices -ServiceInput $Service
}

Write-Host "$(Get-Date -UFormat "%Y-%m-%d_%H:%M:%S") -------------------------------------------"
    $ServicesToRestart = @{}
   
   custom-restartADFS
   custom-StartStop

   custom-CheckWriters
   if($FailedVSSWriters){

    } 
}

Stop-Transcript