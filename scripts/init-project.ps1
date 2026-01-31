<#
.SYNOPSIS
    Initialize a new project with AI development configuration

.DESCRIPTION
    This script sets up a new project with shared AI development tools,
    including skills, agents, workflows, and platform-specific configurations.

.PARAMETER ProjectPath
    The path to the target project directory

.PARAMETER Platform
    The AI platform to configure (claude, cursor, windsurf, kiro, codex, copilot, antigravity, all)

.EXAMPLE
    .\init-project.ps1 -ProjectPath "C:\Projects\my-app" -Platform all
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectPath,

    [Parameter(Mandatory=$false)]
    [ValidateSet("claude", "cursor", "windsurf", "kiro", "codex", "copilot", "antigravity", "all")]
    [string]$Platform = "all"
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ConfigRoot = Split-Path -Parent $ScriptDir
$CoreSource = Join-Path $ConfigRoot "core"
$AdaptersSource = Join-Path $ConfigRoot "adapters"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  AI Dev Config - Project Initializer  " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Validate source exists
if (-not (Test-Path $CoreSource)) {
    Write-Host "Error: core directory not found at $CoreSource" -ForegroundColor Red
    exit 1
}

# Create project directory if not exists
if (-not (Test-Path $ProjectPath)) {
    Write-Host "Creating project directory: $ProjectPath" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $ProjectPath -Force | Out-Null
}

# Copy core directory
Write-Host "Copying core directory..." -ForegroundColor Green
$DestCore = Join-Path $ProjectPath "core"
if (Test-Path $DestCore) {
    Write-Host "  core already exists, skipping..." -ForegroundColor Yellow
} else {
    Copy-Item -Path $CoreSource -Destination $DestCore -Recurse
    Write-Host "  Done!" -ForegroundColor Green
}

# Create .agent directory with junctions (for Antigravity)
Write-Host "Creating .agent directory with junctions..." -ForegroundColor Green
$AgentDir = Join-Path $ProjectPath ".agent"
if (-not (Test-Path $AgentDir)) {
    New-Item -ItemType Directory -Path $AgentDir -Force | Out-Null
}

$Junctions = @("skills", "agents", "workflows", "templates")
foreach ($dir in $Junctions) {
    $JunctionPath = Join-Path $AgentDir $dir
    $TargetPath = Join-Path $DestCore $dir

    if (Test-Path $JunctionPath) {
        Write-Host "  $dir junction already exists, skipping..." -ForegroundColor Yellow
    } else {
        cmd /c mklink /J $JunctionPath $TargetPath | Out-Null
        Write-Host "  Created junction: $dir -> core/$dir" -ForegroundColor Green
    }
}

# Platform-specific configurations
Write-Host "Creating platform configurations..." -ForegroundColor Green

function Create-PlatformConfig {
    param(
        [string]$Platform,
        [string]$FileName,
        [string]$TemplateName
    )
    
    $FilePath = Join-Path $ProjectPath $FileName
    $TemplateDir = Join-Path $AdaptersSource "$Platform\templates"
    $TemplatePath = Join-Path $TemplateDir $TemplateName
    
    if (Test-Path $FilePath) {
        Write-Host "  $FileName already exists, skipping..." -ForegroundColor Yellow
    } elseif (Test-Path $TemplatePath) {
        # Create parent directory if needed
        $ParentDir = Split-Path -Parent $FilePath
        if (-not (Test-Path $ParentDir)) {
            New-Item -ItemType Directory -Path $ParentDir -Force | Out-Null
        }
        Copy-Item -Path $TemplatePath -Destination $FilePath
        Write-Host "  Created $FileName" -ForegroundColor Green
    } else {
        Write-Host "  Template not found for $Platform, skipping..." -ForegroundColor Yellow
    }
}

switch ($Platform) {
    "claude" {
        Create-PlatformConfig "claude" "CLAUDE.md" "base.md"
        # Create .claude directory
        $ClaudeDir = Join-Path $ProjectPath ".claude"
        if (-not (Test-Path $ClaudeDir)) {
            New-Item -ItemType Directory -Path $ClaudeDir -Force | Out-Null
        }
        # Create skills junction
        $ClaudeSkills = Join-Path $ClaudeDir "skills"
        if (-not (Test-Path $ClaudeSkills)) {
            $TargetPath = Join-Path $DestCore "skills"
            cmd /c mklink /J $ClaudeSkills $TargetPath | Out-Null
            Write-Host "  Created .claude/skills junction" -ForegroundColor Green
        }
    }
    "cursor" {
        Create-PlatformConfig "cursor" ".cursorrules" "base.md"
    }
    "windsurf" {
        Create-PlatformConfig "windsurf" ".windsurfrules" "base.md"
    }
    "kiro" {
        Create-PlatformConfig "kiro" ".kiro\steering\project.md" "project.md"
    }
    "codex" {
        Create-PlatformConfig "codex" "AGENTS.md" "agents.md"
    }
    "copilot" {
        Create-PlatformConfig "copilot" ".github\copilot-instructions.md" "instructions.md"
    }
    "antigravity" {
        Write-Host "  Antigravity configured via .agent/ junctions" -ForegroundColor Green
    }
    "all" {
        # Claude
        Create-PlatformConfig "claude" "CLAUDE.md" "base.md"
        $ClaudeDir = Join-Path $ProjectPath ".claude"
        if (-not (Test-Path $ClaudeDir)) {
            New-Item -ItemType Directory -Path $ClaudeDir -Force | Out-Null
        }
        $ClaudeSkills = Join-Path $ClaudeDir "skills"
        if (-not (Test-Path $ClaudeSkills)) {
            $TargetPath = Join-Path $DestCore "skills"
            cmd /c mklink /J $ClaudeSkills $TargetPath | Out-Null
            Write-Host "  Created .claude/skills junction" -ForegroundColor Green
        }
        
        # Others
        Create-PlatformConfig "cursor" ".cursorrules" "base.md"
        Create-PlatformConfig "windsurf" ".windsurfrules" "base.md"
        Create-PlatformConfig "kiro" ".kiro\steering\project.md" "project.md"
        Create-PlatformConfig "copilot" ".github\copilot-instructions.md" "instructions.md"
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
Write-Host "  ├── core/              (skills, agents, workflows)" -ForegroundColor Gray
Write-Host "  ├── .agent/            (symlinks to core)" -ForegroundColor Gray
if ($Platform -eq "all" -or $Platform -eq "claude") {
    Write-Host "  ├── CLAUDE.md          (Claude Code config)" -ForegroundColor Gray
    Write-Host "  ├── .claude/skills/    (symlink to core/skills)" -ForegroundColor Gray
}
if ($Platform -eq "all" -or $Platform -eq "cursor") {
    Write-Host "  ├── .cursorrules       (Cursor config)" -ForegroundColor Gray
}
if ($Platform -eq "all" -or $Platform -eq "windsurf") {
    Write-Host "  ├── .windsurfrules     (Windsurf config)" -ForegroundColor Gray
}
if ($Platform -eq "all" -or $Platform -eq "kiro") {
    Write-Host "  ├── .kiro/             (Kiro config)" -ForegroundColor Gray
}
if ($Platform -eq "all" -or $Platform -eq "copilot") {
    Write-Host "  └── .github/           (Copilot config)" -ForegroundColor Gray
}
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. cd $ProjectPath" -ForegroundColor White
Write-Host "  2. Customize platform config files as needed" -ForegroundColor White
Write-Host "  3. Start development with your AI assistant" -ForegroundColor White
Write-Host ""
