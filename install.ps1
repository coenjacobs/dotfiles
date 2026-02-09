# Dotfiles installation script for Windows
# Installs development tools via winget and sets up configurations

#Requires -Version 5.1
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$DotfilesDir = $PSScriptRoot

Write-Host "Installing dotfiles from $DotfilesDir" -ForegroundColor Cyan
Write-Host ""

# =============================================================================
# Winget Check
# =============================================================================

function Test-Winget {
    try {
        $null = Get-Command winget -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

if (-not (Test-Winget)) {
    Write-Host "Error: winget is not installed." -ForegroundColor Red
    Write-Host ""
    Write-Host "Winget comes pre-installed on Windows 11 and recent Windows 10 versions."
    Write-Host "If missing, install it from the Microsoft Store (App Installer) or from:"
    Write-Host "https://github.com/microsoft/winget-cli/releases"
    exit 1
}

Write-Host "Winget is available" -ForegroundColor Green
Write-Host ""

# =============================================================================
# Package Installation via Winget
# =============================================================================

Write-Host "Installing packages from winget.json..." -ForegroundColor Cyan

$WingetJson = Join-Path $DotfilesDir "packages\winget.json"

if (Test-Path $WingetJson) {
    # Import packages from JSON file
    winget import --import-file $WingetJson --accept-package-agreements --accept-source-agreements

    if ($LASTEXITCODE -ne 0) {
        Write-Host "Warning: Some packages may have failed to install" -ForegroundColor Yellow
    }
}
else {
    Write-Host "Warning: winget.json not found at $WingetJson" -ForegroundColor Yellow
}

Write-Host ""

# =============================================================================
# Refresh PATH
# =============================================================================

# Refresh PATH to pick up newly installed tools
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# =============================================================================
# NPM Global Packages
# =============================================================================

Write-Host "Installing npm global packages..." -ForegroundColor Cyan

try {
    $null = Get-Command npm -ErrorAction Stop
    npm install -g @anthropic-ai/claude-code opencode-ai
}
catch {
    Write-Host "Warning: npm not found. Claude Code will need to be installed manually after Node.js is available in PATH." -ForegroundColor Yellow
    Write-Host "Run: npm install -g @anthropic-ai/claude-code opencode-ai" -ForegroundColor Yellow
}

Write-Host ""

# =============================================================================
# Configuration Setup
# =============================================================================

Write-Host "Setting up configurations..." -ForegroundColor Cyan

# Helper function to create symlink or copy (symlinks require admin on Windows)
function Set-ConfigLink {
    param(
        [string]$Source,
        [string]$Destination,
        [switch]$IsDirectory
    )

    # Create parent directory if needed
    $ParentDir = Split-Path $Destination -Parent
    if (-not (Test-Path $ParentDir)) {
        New-Item -ItemType Directory -Path $ParentDir -Force | Out-Null
    }

    # Backup existing file/directory if it's not a symlink
    if (Test-Path $Destination) {
        $item = Get-Item $Destination -Force
        if ($item.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            # It's a symlink, remove it
            Remove-Item $Destination -Force -Recurse
        }
        else {
            # It's a real file/directory, backup it
            $BackupPath = "$Destination.backup"
            Write-Host "  Backing up $Destination to $BackupPath"
            Move-Item $Destination $BackupPath -Force
        }
    }

    # Try to create symlink (requires admin or developer mode)
    try {
        if ($IsDirectory) {
            New-Item -ItemType SymbolicLink -Path $Destination -Target $Source -Force | Out-Null
        }
        else {
            New-Item -ItemType SymbolicLink -Path $Destination -Target $Source -Force | Out-Null
        }
        Write-Host "  Linked: $Source -> $Destination" -ForegroundColor Green
    }
    catch {
        # Fall back to copying
        Write-Host "  Symlink failed (admin required), copying instead..." -ForegroundColor Yellow
        if ($IsDirectory) {
            Copy-Item $Source $Destination -Recurse -Force
        }
        else {
            Copy-Item $Source $Destination -Force
        }
        Write-Host "  Copied: $Source -> $Destination" -ForegroundColor Yellow
    }
}

# Neovim config: $env:LOCALAPPDATA\nvim
$NvimSource = Join-Path $DotfilesDir "nvim"
$NvimDest = Join-Path $env:LOCALAPPDATA "nvim"
Set-ConfigLink -Source $NvimSource -Destination $NvimDest -IsDirectory

# Git global ignore
$GitIgnoreSource = Join-Path $DotfilesDir "git\.gitignore"
$GitIgnoreDest = Join-Path $HOME ".gitignore"
Set-ConfigLink -Source $GitIgnoreSource -Destination $GitIgnoreDest

# Configure git to use the global ignore file
try {
    $null = Get-Command git -ErrorAction Stop
    git config --global core.excludesfile $GitIgnoreDest
    Write-Host "  Configured git global excludesfile" -ForegroundColor Green
}
catch {
    Write-Host "  Warning: git not found in PATH yet. Run this after restart:" -ForegroundColor Yellow
    Write-Host "  git config --global core.excludesfile $GitIgnoreDest" -ForegroundColor Yellow
}

# Claude Code settings
$ClaudeDir = Join-Path $HOME ".claude"
if (-not (Test-Path $ClaudeDir)) {
    New-Item -ItemType Directory -Path $ClaudeDir -Force | Out-Null
}

$ClaudeSettingsSource = Join-Path $DotfilesDir "claude\settings.json"
$ClaudeSettingsDest = Join-Path $ClaudeDir "settings.json"
Set-ConfigLink -Source $ClaudeSettingsSource -Destination $ClaudeSettingsDest

Write-Host ""
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Restart your terminal to pick up new PATH entries"
Write-Host "  2. Open Neovim to let plugins install automatically"
Write-Host ""
Write-Host "Notes:"
Write-Host "  - Tmux is not available on Windows (use Windows Terminal tabs instead)"
Write-Host "  - Bash configs are not linked (use PowerShell profile instead)"
Write-Host "  - If symlinks failed, configs were copied instead of linked"
Write-Host ""
Write-Host "Secrets (SSH keys, API keys) must be set up manually."
Write-Host ""
