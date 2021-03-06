﻿param ( 
    [parameter(Mandatory = $true)]
    [string]$TargetEnvironment,

    [parameter(Mandatory = $true)]
    [string]$ResourceGroupNamePrefix,

    [parameter(Mandatory = $true)]
    [string]$TemplatePath
)
Write-Host "Creating Resource Group {$($ResourceGroupNamePrefix)$($TargetEnvironment)}..." -NoNewLine
$rg = Get-AzureRMResourceGroup "$($ResourceGroupNamePrefix)$($TargetEnvironment)" -ErrorAction SilentlyContinue
if ($null -eq $rg)
{
    $rg = New-AzureRmResourceGroup -Name "$($ResourceGroupNamePrefix)$($TargetEnvironment)" -Location WestUS
}
Write-Host "Done" -ForegroundColor Green

$templateFile = "$TemplatePath/Demo/Demo/CollabSummit/SharePoint2019/azuredeploy.json"
Write-Host "Deploying ARM Template..."
New-AzureRmResourceGroupDeployment -Verbose `
    -ResourceGroupName $rg.ResourceGroupName `
    -TemplateFile $templateFile