Write-Host "Terraform AWS Web Architecture Setup"
Write-Host
Write-Host "This script will create a terraform.tfvars file with your configuration."
Write-Host

function Read-Input {
    param(
        [string]$Prompt,
        [string]$Default = $null,
        [switch]$AsSecureString
    )
    if ($AsSecureString) {
        $input = Read-Host -Prompt $Prompt -AsSecureString
        return [Runtime.InteropServices.Marshal]::PtrToStringAuto(
            [Runtime.InteropServices.Marshal]::SecureStringToBSTR($input)
        )
    }
    $line = Read-Host -Prompt $Prompt
    if ([string]::IsNullOrWhiteSpace($line) -and $Default) {
        return $Default
    }
    return $line
}

$projectName = Read-Input -Prompt "Enter project name (default: secure-web)" -Default "secure-web"

$awsAccessKey = Read-Input -Prompt "Enter AWS Access Key"
if (-not $awsAccessKey) {
    Write-Error "Error: AWS Access Key is required."
    exit 1
}

$awsSecretKey = Read-Input -Prompt "Enter AWS Secret Key" -AsSecureString
if (-not $awsSecretKey) {
    Write-Error "Error: AWS Secret Key is required."
    exit 1
}

$awsRegion = Read-Input -Prompt "Enter AWS Region (default: ap-south-1)" -Default "ap-south-1"

$gitRepo = Read-Input -Prompt "Link to public Git repo to be cloned (default: rlpvin/hello-world-page)" -Default "https://github.com/rlpvin/hello-world-page.git"

@"
project_name = "$projectName"
aws_access_key = "$awsAccessKey"
aws_secret_key = "$awsSecretKey"
aws_region     = "$awsRegion"
GIT_REPO        = "$env:GIT_REPO"
"@ | Out-File -FilePath terraform.tfvars -Encoding utf8

Write-Host
Write-Host "Success: terraform.tfvars created."
Write-Host
Write-Host "Next steps:"
Write-Host "1. Run: terraform init"
Write-Host "   Run: terraform validate"
Write-Host "2. Run: terraform plan"
Write-Host "3. Run: terraform apply"
Write-Host
Write-Host "Important: Keep terraform.tfvars secure as it contains sensitive AWS credentials."
