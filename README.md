PowerShell Script to Deploy ASP.NET Web Applications to Azure Web App
=====================================================================

            

Azure Web Apps (PaaS) is a tremendously powerful service and can be considered as one stop shop for hosting almost all types of web applications to Azure.Since the evolution of Visual Studio Team Services the CI / CD has become quite an effortless job. But
 what if your TFS server is on premise? well, ofcourse there are ways to connect to your on premise TFS server from cloud but it takes time and some serious efforts are involved in it.


This scirpt focuses on simple agenda i.e. deploying ASP.NET web applications to Azure web apps. This further can be integrated with your on premise's server CI / CD build definition workflow by simply letting the workflow invoke this PS script.


Workflow of this script is quite simple, i.e. it builds the provided solution file path using MSBuild.exe and uses Azure web app's publish setting file and Visual Studio's Publish Profile to perform the deployment via script.


The script has three input mandatory parameters 


  *  Solution (.sln) file path  
  *  Azure web app's publish profile path (This needs to be downloaded from Azure poral, if you do not know how to do it then please go through this
[link](http://stackoverflow.com/questions/34191234/where-is-download-publish-profile-in-the-new-azure-portal/34191267)) 
  *  Visual Studio's Publish Profile Xml  (Sample file attached with this script.)


**Customizations needed in the Visual Studio Publish Profile Xml (If sample xml is downloaded from this section)**


If you have downloaded the attached Publish profile with this script, then you might need to do some changes in it as per your Azure web application's metadata.


  *  Update SiteUrlToLaunchAfterPublish node and set it's value to your Azure web app's Url.

  *  Update MSDeployServiceURL node and set it's value to your Azure web app's Url.

  *  Update DeployIisAppPath node to your web app's deployment slot name, note that this is name and not URL. (default production slot = web app name)

  *  Update UserName node to your Azure web application's name. (not URL) 
  *  In PublishDatabaseSettings node, update database contexts (if you are using) names and connection strings. Remove this section if not required in your scenario.


**Pre-requisite**


The machine executing this script needs to have following pre-requirsites installed


  *  Azure PowerShell (latest version preffered) 
  *  MSBuild.exe 
  *  Visual Studio 2015 (Since the script uses VS Tool's for publish activity) 

**Sample Usage**


.\PublishTo-AzureWebApp.ps1 -WebAppPublishProfileFilePath 'D:\Your_Web_App.PublishSettings' -SolutionPath 'D:\SampleWebApp.sln' -DeploymentXmlFilePath 'D:\VSPublish.xml' -Verbose


Note that VSPublish.xml used in example above is same file as provided in section below


**Disclaimer**
This script has undergone limitted testing with Azure web app containing default deployment slot. Feel free to customise the script the way you want it or as per your needs.


**Sample VS Publish Profile**


** **

** **




 


        
    
TechNet gallery is retiring! This script was migrated from TechNet script center to GitHub by Microsoft Azure Automation product group. All the Script Center fields like Rating, RatingCount and DownloadCount have been carried over to Github as-is for the migrated scripts only. Note : The Script Center fields will not be applicable for the new repositories created in Github & hence those fields will not show up for new Github repositories.
