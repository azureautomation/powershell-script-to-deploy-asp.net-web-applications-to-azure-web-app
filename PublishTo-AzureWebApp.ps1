<#
.SYNOPSIS
    .Script to deploy ASP.NET Web Applications (.NET) to Azure web app.
.DESCRIPTION
    .This script deploys ASP.NET Web Applications (.NET) to Azure web apps. It uses the publish settings file which needs to be downloaded from Azure portal and the Publish profile
    of Visual Studio. 
    The Scirpt mainly invokes MS build as a part of core activity for the deployment hence the MS Build needs to be installed on the machine executing this script.

.PARAMETER WebAppPublishProfileFilePath
    Mandatory parameter. Specify the publish settings file path of the Azure web app.

.PARAMETER SolutionPath
    Mandatory parameter. Specify the solution file path of the web application to be deployed to Azure web app.

.PARAMETER DeploymentXmlFilePath
    Mandatory parameter. Specify the path of publish profile created from Visual Studio Publish Wizard. (Sample file attached)

#>

Param
     (
         [Parameter(Mandatory=$true)]
         [string]
         $WebAppPublishProfileFilePath,

         [Parameter(Mandatory=$true)]
         [string]
         $SolutionPath ,

         [Parameter(Mandatory=$true)]
         [string]
         $DeploymentXmlFilePath

     )

try{

    # Read the Publush profile
    [Xml]$fileXml = Get-Content $WebAppPublishProfileFilePath
    if (!$fileXml) {
        throw "Error: Cannot find a web app publish profile file for the $WebAppUrl."
    }
    
    # Extract web app password from publish settings file
    $password = $fileXml.publishData.publishProfile.userPWD[0]
    
    # Extract web app Url from publish settings file
    $WebAppUrl = $fileXml.publishData.publishProfile.destinationAppUrl[0]

    # Build and publish the project via web deploy package using msbuild.exe 
    Write-Host "Deployment started on $WebAppUrl" -ForegroundColor Green

    # Init deployment procedure Run MSBuild to publish the project
    & "$env:windir\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" $SolutionPath `
    /p:VisualStudioVersion=14.0 `
    /p:DeployOnBuild=true `
    /p:PublishProfile=$DeploymentXmlFilePath `
    /p:Password=$password

    Write-Host "Deployment completed on $WebAppUrl" -ForegroundColor Green
   
}
catch{

    write-host "Caught an exception:" -ForegroundColor Red
    write-host "Exception Type: $($_.Exception.GetType().FullName)" -ForegroundColor Red
    write-host "Exception Message: $($_.Exception.Message)" -ForegroundColor Red
}