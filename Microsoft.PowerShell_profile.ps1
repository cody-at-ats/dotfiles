# Microsoft.PowerShell_profile.ps1

# --- Prompt ---

# use starship for consistency with WSL / fish
Invoke-Expression (&starship init powershell)

# oh-my-posh alternative (uncomment to use instead):
# oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/agnoster.omp.json' | Invoke-Expression


# --- Directory Navigation ---

function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }
function ..... { Set-Location ..\..\..\.. }
function bd { Set-Location - }
function home { Set-Location ~ }

# Create directory and cd into it
function mkdirg {
  param([string]$Path)
  New-Item -ItemType Directory -Path $Path -Force | Out-Null
  Set-Location $Path
}


# --- General Aliases ---

New-Alias -Force grep Select-String
function c { Clear-Host }
function da { Get-Date -Format "yyyy-MM-dd dddd HH:mm:ss" }
function n { notepad $args }
function e { code $args }

# Open this profile in editor
function profile { code $profile }

function chelp {
  $C = "`e[1;36m"; $Y = "`e[1;33m"; $R = "`e[0m"
  Write-Host ""
  Write-Host "${C}  ┌─────────────────────────────────────────────────────┐"
  Write-Host "  │           POWERSHELL CONFIG QUICK REFERENCE         │"
  Write-Host "  └─────────────────────────────────────────────────────┘${R}"

  Write-Host "${C}  NAVIGATION${R}"
  Write-Host "  ${Y}.. ... .... .....${R}  cd up 1-4 levels"
  Write-Host "  ${Y}bd${R}               cd to previous dir"
  Write-Host "  ${Y}home${R}             cd ~"
  Write-Host "  ${Y}mkdirg <dir>${R}     mkdir + cd"
  Write-Host ""

  Write-Host "${C}  GIT${R}"
  Write-Host "  ${Y}gs${R}               git status"
  Write-Host "  ${Y}ga / gaa${R}         git add / add --all"
  Write-Host "  ${Y}gc / gcm / gca${R}   commit / commit -m / amend"
  Write-Host "  ${Y}gp / gpf${R}         push / push --force-with-lease"
  Write-Host "  ${Y}gl${R}               pull"
  Write-Host "  ${Y}gf / gfa${R}         fetch / fetch --all"
  Write-Host "  ${Y}gd / gds${R}         diff / diff --staged"
  Write-Host "  ${Y}gco / gcb${R}        checkout / checkout -b"
  Write-Host "  ${Y}gb / gba / gbd${R}   branch / -a / -d"
  Write-Host "  ${Y}gm / grb${R}         merge / rebase"
  Write-Host "  ${Y}gst / gstp / gstl${R}   stash / pop / list"
  Write-Host "  ${Y}glog / gloga${R}     log graph / all branches"
  Write-Host "  ${Y}grs / grsh${R}       reset / reset --hard"
  Write-Host "  ${Y}gclean${R}           git clean -fd"
  Write-Host ""

  Write-Host "${C}  GIT FUNCTIONS${R}"
  Write-Host "  ${Y}Rename-GitBranch -New <name>${R}       rename current branch + remote"
  Write-Host "  ${Y}Remove-GitStaleLocalBranches${R}       prune branches with no upstream"
  Write-Host ""

  Write-Host "${C}  SEARCH & INFO${R}"
  Write-Host "  ${Y}dirs [pattern]${R}   recursive file list (like dir /s /b)"
  Write-Host "  ${Y}da${R}               current date/time"
  Write-Host "  ${Y}sha1/sha256 <f>${R}  file hashes"
  Write-Host "  ${Y}List-Functions${R}   show all user-defined functions"
  Write-Host ""

  Write-Host "${C}  EDITORS & APPS${R}"
  Write-Host "  ${Y}e <path>${R}         open in VS Code"
  Write-Host "  ${Y}n <path>${R}         open in Notepad"
  Write-Host "  ${Y}v${R}                open neovide (WSL)"
  Write-Host "  ${Y}profile${R}          open this profile in VS Code"
  Write-Host ""

  Write-Host "${C}  UTILITIES${R}"
  Write-Host "  ${Y}Remove-Bin <path>${R}              delete all bin/obj folders"
  Write-Host "  ${Y}Remove-EmptyDirectories <path>${R} remove empty dirs"
  Write-Host "  ${Y}Shrink-VHDX${R}                    compact WSL disk image"
  Write-Host "  ${Y}Restore-DatabaseBackups <dir>${R}  restore .bak files to SQL Server"
  Write-Host "  ${Y}Shrink-Database-Logs${R}           shrink SQL log files"
  Write-Host "  ${Y}Clear-AzureQueues${R}              cancel queued ADO builds (needs AZURE_DEVOPS_PAT)"
  Write-Host "  ${Y}New-AzDoWorkItem${R}               create ADO work item via python script"
  Write-Host "  ${Y}chelp${R}                          this help"
  Write-Host "  ${Y}Update-Dotfiles${R}                pull latest config from repo"
  Write-Host ""
}

# Launch neovide connected to WSL
function v { Set-Location \\wsl.localhost\Ubuntu\home\cody\git; neovide --wsl }

# Compute file hashes
function md5    { Get-FileHash -Algorithm MD5    $args }
function sha1   { Get-FileHash -Algorithm SHA1   $args }
function sha256 { Get-FileHash -Algorithm SHA256 $args }

# Recursive file listing (like dir /s /b)
function dirs {
  if ($args.Count -gt 0) {
    Get-ChildItem -Recurse -Include "$args" | ForEach-Object FullName
  } else {
    Get-ChildItem -Recurse | ForEach-Object FullName
  }
}

# List all user-defined functions in the session
function List-Functions {
  Get-Command -CommandType Function |
    Where-Object { $_.ModuleName -eq '' -and $_.Name -notmatch "^[A-Z]:" }
}


# --- Git Aliases ---
# Standardized with bash/fish configs: gl=pull, glog=log

function gs    { git status }
function ga    { git add @args }
function gaa   { git add --all }
function gc    { git commit }
function gcm   { git commit -m @args }
function gca   { git commit --amend }
function gp    { git push }
function gpf   { git push --force-with-lease }
function gl    { git pull }
function gf    { git fetch }
function gfa   { git fetch --all }
function gd    { git diff }
function gds   { git diff --staged }
function gco   { git checkout @args }
function gcb   { git checkout -b @args }
function gb    { git branch }
function gba   { git branch -a }
function gbd   { git branch -d @args }
function gm    { git merge @args }
function grb   { git rebase @args }
function gst   { git stash }
function gstp  { git stash pop }
function gstl  { git stash list }
function glog  { git log --oneline --graph --decorate }
function gloga { git log --oneline --graph --decorate --all }
function grs   { git reset @args }
function grsh  { git reset --hard @args }
function gclean { git clean -fd }

function Update-Dotfiles {
  # Check common repo locations
  $repoCandidates = @("C:\git\dotfiles", "$HOME\git\dotfiles")
  $repoDir = $repoCandidates | Where-Object { Test-Path "$_\.git" } | Select-Object -First 1
  $profileTarget = $PROFILE

  if ($repoDir) {
    Write-Host "Pulling latest dotfiles from $repoDir ..."
    git -C $repoDir pull
    $isSymlink = (Get-Item $profileTarget -ErrorAction SilentlyContinue).LinkType -eq 'SymbolicLink'
    if (-not $isSymlink) {
      Copy-Item "$repoDir\Microsoft.PowerShell_profile.ps1" $profileTarget
      Write-Host "Copied profile to $profileTarget"
    }
    . $profileTarget
    Write-Host "Done — profile reloaded."
  } else {
    Write-Host "Dotfiles repo not found. Clone it to one of:"
    $repoCandidates | ForEach-Object { Write-Host "  git clone git@github.com:cody-at-ats/dotfiles.git $_" }
  }
}
New-Alias -Force dotfiles-update Update-Dotfiles

# Rename current branch locally and on remote
function Rename-GitBranch {
  param(
    [Parameter(Mandatory = $true)]
    [string]$New
  )
  $Old = git rev-parse --abbrev-ref HEAD
  git branch -m $Old $New
  git push -u origin $New
  git push origin --delete $Old
}

# Delete local branches whose upstream no longer exists
function Remove-GitStaleLocalBranches {
  [CmdletBinding(SupportsShouldProcess = $true)]
  param(
    [string[]]$ProtectedBranches = @("main", "master", "develop")
  )

  if (-not (git rev-parse --is-inside-work-tree 2>$null)) {
    throw "Not inside a git repository."
  }

  git fetch --prune | Out-Null

  $currentBranch = git branch --show-current
  $validUpstreams = git for-each-ref --format="%(refname:short)" refs/remotes |
    ForEach-Object { $_.Trim() }

  git for-each-ref --format="%(refname:short)|%(upstream:short)" refs/heads |
    ForEach-Object {
      $p = $_ -split '\|'
      [PSCustomObject]@{ Branch = $p[0]; Upstream = $p[1] }
    } |
    Where-Object {
      ($_.Upstream -eq "" -or $_.Upstream -notin $validUpstreams) -and
      $_.Branch -ne $currentBranch -and
      $_.Branch -notin $ProtectedBranches
    } |
    ForEach-Object {
      if ($PSCmdlet.ShouldProcess($_.Branch, "Delete stale branch")) {
        git branch -D $_.Branch
      }
    }
}


# --- Filesystem Utilities ---

# Remove all bin/obj folders under a path (excludes node_modules, references, etc.)
function Remove-Bin {
  param([string]$rootPath)
  Write-Output "Removing all bin and obj folders from $rootPath ..."

  Get-ChildItem -Path $rootPath -Directory -Recurse -Force -ErrorAction SilentlyContinue |
    Where-Object {
      $_.Name -in @('bin', 'obj') -and
      $_.FullName -notmatch '[\\/]node_modules([\\/]|$)' -and
      $_.FullName -notmatch '[\\/]installers[\\/]bin([\\/]|$)' -and
      $_.FullName -notmatch '[\\/]Opc\.Client[\\/](bin|obj)([\\/]|$)' -and
      $_.FullName -notmatch '[\\/]references[\\/]'
    } |
    ForEach-Object {
      Write-Output "Removing $($_.FullName)"
      Remove-Item -LiteralPath $_.FullName -Force -Recurse
    }

  Write-Output "Done."
}

# Remove empty directories
function Remove-EmptyDirectories {
  param(
    [string]$Path = (Get-Location),
    [switch]$Recurse
  )
  $dirs = Get-ChildItem $Path -Directory -Recurse:$Recurse |
    Where-Object { (Get-ChildItem $_.FullName -Force).Count -eq 0 } |
    Select-Object -ExpandProperty FullName

  if ($dirs.Count -gt 0) {
    $dirs | ForEach-Object { Remove-Item $_ }
    Write-Host "$($dirs.Count) empty directories removed."
  } else {
    Write-Host "No empty directories found."
  }
}


# --- WSL Utilities ---

# Shrink the Ubuntu WSL VHDX to reclaim disk space
function Shrink-VHDX {
  param(
    [string]$vdiskPath = "C:\Users\chowarth\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu_79rhkp1fndgsc\LocalState\ext4.vhdx"
  )

  Read-Host "Make sure Docker Desktop is closed. Press Enter to continue..."

  if (-Not (Test-Path $vdiskPath)) {
    Write-Error "VHDX not found at $vdiskPath"
    return
  }

  Write-Host "Shutting down WSL..."
  $p = Start-Process cmd.exe -ArgumentList "/c wsl --shutdown" -NoNewWindow -PassThru
  $p.WaitForExit()
  $p = Start-Process cmd.exe -ArgumentList "/c wsl.exe --list --verbose" -NoNewWindow -PassThru
  $p.WaitForExit()

  $diskpartScript = @"
select vdisk file="$vdiskPath"
detach vdisk
attach vdisk readonly
compact vdisk
detach vdisk
exit
"@
  $tempFile = [System.IO.Path]::GetTempFileName()
  Set-Content -Path $tempFile -Value $diskpartScript

  Write-Host "Running diskpart..."
  $p = Start-Process cmd.exe -ArgumentList "/c diskpart /s $tempFile" -NoNewWindow -PassThru
  $p.WaitForExit()

  Remove-Item -Path $tempFile
  Write-Host "Done."
}


# --- SQL Utilities ---

# Restore all .bak files in a directory to the local SQL Server instance
function Restore-DatabaseBackups {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)]
    [string]$BackupDirectory
  )

  $sqlServerInstance = "(local)"
  $sqlCmdPath        = "C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\170\Tools\Binn\SQLCMD.EXE"
  $sqlScriptPath     = "C:\Users\chowarth\OneDrive - ATS Corporation\Documents\Docs\Code\Scripts\restore_database_backup.sql"
  $dataFilePath      = "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"
  $logFilePath       = "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"

  foreach ($backupFile in (Get-ChildItem -Path $BackupDirectory -Filter *.bak)) {
    $databaseName = Read-Host "Database name for $($backupFile.Name)"
    & $sqlCmdPath -S $sqlServerInstance -i "`"$sqlScriptPath`"" `
      -v db="$databaseName" `
      -v file="`"$($backupFile.FullName)`"" `
      -v data-file-path="`"$dataFilePath`"" `
      -v log-file-path="`"$logFilePath`"" `
      | Out-Default
  }
}

function Shrink-Database-Logs {
  & "C:\Users\chowarth\OneDrive - ATS Corporation\Documents\Docs\Code\Scripts\shrink_sql_logs.bat"
}


# --- Azure DevOps ---

# Cancel all queued builds. Requires AZURE_DEVOPS_PAT env var.
function Clear-AzureQueues {
  $pat = $env:AZURE_DEVOPS_PAT
  if (-not $pat) { throw "Set the AZURE_DEVOPS_PAT environment variable first." }

  $url = "https://dev.azure.com/imi/imi/_apis/build/builds?statusFilter=notStarted&api-version=7.0"
  $base64AuthInfo = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(":$pat"))
  $pendingJobs = Invoke-RestMethod -Uri $url -Headers @{Authorization = "Basic $base64AuthInfo"} -Method Get -ContentType "application/json"

  Write-Host $pendingJobs.value
}

function New-AzDoWorkItem {
  $scriptPath = "C:\git\scripts\create_work_item.py"
  & "C:\Python314\python.exe" $scriptPath @args
}


# --- Modules (optional — only loaded if present) ---

$GetFileLockModule = "C:\Users\chowarth\OneDrive - ATS Corporation\Documents\Docs\Code\Scripts\Get-FileLockProcess.psm1"
if (Test-Path $GetFileLockModule) { Import-Module $GetFileLockModule }

$UninstallImiModule = "C:\Users\chowarth\OneDrive - ATS Corporation\Documents\Docs\Code\Scripts\Uninstall-Imi.psm1"
if (Test-Path $UninstallImiModule) { Import-Module $UninstallImiModule }

# Chocolatey
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path $ChocolateyProfile) { Import-Module $ChocolateyProfile }
