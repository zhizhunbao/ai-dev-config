<#
.SYNOPSIS
    Initialize a new project with AI development configuration

.DESCRIPTION
    This script sets up a new project with shared AI development tools,
    including skills, agents, workflows, and platform-specific configurations.

.PARAMETER ProjectPath
    The path to the target project directory

.PARAMETER Platform
    The AI platform to configure (claude, cursor, windsurf, kiro, all)

.EXAMPLE
    .\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform all
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,

    [Parameter(Mandatory=$false)]
    [ValidateSet("claude", "cursor", "windsurf", "kiro", "all")]
    [string]$Platform = "all"
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigRoot = Split-Path -Parent $ScriptDir
$SharedSource = Join-Path $ConfigRoot ".shared"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  AI Dev Config - Project Initializer  " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Validate source exists
if (-not (Test-Path $SharedSource)) {
    Write-Host "Error: .shared directory not found at $SharedSource" -ForegroundColor Red
    exit 1
}

# Create project directory if not exists
if (-not (Test-Path $ProjectPath)) {
    Write-Host "Creating project directory: $ProjectPath" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $ProjectPath -Force | Out-Null
}

# Copy .shared directory
Write-Host "Copying .shared directory..." -ForegroundColor Green
$DestShared = Join-Path $ProjectPath ".shared"
if (Test-Path $DestShared) {
    Write-Host "  .shared already exists, skipping..." -ForegroundColor Yellow
} else {
    Copy-Item -Path $SharedSource -Destination $DestShared -Recurse
    Write-Host "  Done!" -ForegroundColor Green
}

# Create .agent directory with junctions
Write-Host "Creating .agent directory with junctions..." -ForegroundColor Green
$AgentDir = Join-Path $ProjectPath ".agent"
if (-not (Test-Path $AgentDir)) {
    New-Item -ItemType Directory -Path $AgentDir -Force | Out-Null
}

$Junctions = @("skills", "agents", "workflows", "templates")
foreach ($dir in $Junctions) {
    $JunctionPath = Join-Path $AgentDir $dir
    $TargetPath = Join-Path $DestShared $dir

    if (Test-Path $JunctionPath) {
        Write-Host "  $dir junction already exists, skipping..." -ForegroundColor Yellow
    } else {
        cmd /c mklink /J $JunctionPath $TargetPath | Out-Null
        Write-Host "  Created junction: $dir -> .shared/$dir" -ForegroundColor Green
    }
}

# Create platform-specific configurations
Write-Host "Creating platform configurations..." -ForegroundColor Green
$RulesSource = Join-Path $DestShared "rules.md"

function Create-PlatformConfig {
    param($FileName, $PlatformName)
    $FilePath = Join-Path $ProjectPath $FileName
    if (Test-Path $FilePath) {
        Write-Host "  $FileName already exists, skipping..." -ForegroundColor Yellow
    } else {
        Copy-Item -Path $RulesSource -Destination $FilePath
        Write-Host "  Created $FileName for $PlatformName" -ForegroundColor Green
    }
}

switch ($Platform) {
    "claude" {
        Create-PlatformConfig "CLAUDE.md" "Claude Code"
    }
    "cursor" {
        Create-PlatformConfig ".cursorrules" "Cursor"
    }
    "windsurf" {
        Create-PlatformConfig ".windsurfrules" "Windsurf"
    }
    "kiro" {
        $KiroDir = Join-Path $ProjectPath ".kiro\steering"
        if (-not (Test-Path $KiroDir)) {
            New-Item -ItemType Directory -Path $KiroDir -Force | Out-Null
        }
        Create-PlatformConfig ".kiro\steering\project.md" "Kiro"
    }
    "all" {
        Create-PlatformConfig "CLAUDE.md" "Claude Code"
        Create-PlatformConfig ".cursorrules" "Cursor"
        Create-PlatformConfig ".windsurfrules" "Windsurf"
        $KiroDir = Join-Path $ProjectPath ".kiro\steering"
        if (-not (Test-Path $KiroDir)) {
            New-Item -ItemType Directory -Path $KiroDir -Force | Out-Null
        }
        $KiroFile = Join-Path $ProjectPath ".kiro\steering\project.md"
        if (-not (Test-Path $KiroFile)) {
            Copy-Item -Path $RulesSource -Destination $KiroFile
            Write-Host "  Created .kiro/steering/project.md for Kiro" -ForegroundColor Green
        }
    }
}

# Create .gitignore additions
Write-Host "Updating .gitignore..." -ForegroundColor Green
$GitignorePath = Join-Path $ProjectPath ".gitignore"
$GitignoreAdditions = @"

# AI Dev Config
.dev-state.yaml
*.local.yaml
"@

if (Test-Path $GitignorePath) {
    $Content = Get-Content $GitignorePath -Raw
    if ($Content -notmatch "AI Dev Config") {
        Add-Content -Path $GitignorePath -Value $GitignoreAdditions
        Write-Host "  Added AI Dev Config entries to .gitignore" -ForegroundColor Green
    }
} else {
    Set-Content -Path $GitignorePath -Value $GitignoreAdditions.TrimStart()
    Write-Host "  Created .gitignore" -ForegroundColor Green
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Initialization Complete!              " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Project structure:" -ForegroundColor White
Write-Host "  $ProjectPath" -ForegroundColor Gray
Write-Host "  ├── .shared/          (skills, agents, workflows)" -ForegroundColor Gray
Write-Host "  ├── .agent/           (symlinks to .shared)" -ForegroundColor Gray
if ($Platform -eq "all" -or $Platform -eq "claude") {
    Write-Host "  ├── CLAUDE.md         (Claude Code config)" -ForegroundColor Gray
}
if ($Platform -eq "all" -or $Platform -eq "cursor") {
    Write-Host "  ├── .cursorrules      (Cursor config)" -ForegroundColor Gray
}
if ($Platform -eq "all" -or $Platform -eq "windsurf") {
    Write-Host "  ├── .windsurfrules    (Windsurf config)" -ForegroundColor Gray
}
if ($Platform -eq "all" -or $Platform -eq "kiro") {
    Write-Host "  └── .kiro/            (Kiro config)" -ForegroundColor Gray
}
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. cd $ProjectPath" -ForegroundColor White
Write-Host "  2. Start development with /full-dev command" -ForegroundColor White
Write-Host ""
