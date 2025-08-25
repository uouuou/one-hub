Param(
    [string]$Target = "all"
)

# PowerShell 版构建脚本（参考）
# UTF-8 输出
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$NAME = "one-api"  # 保持项目名称不变
$DISTDIR = "dist"
$WEBDIR = "web"
$env:CGO_ENABLED = "0"
$env:GOOS = "linux"
$env:GOARCH = "amd64"

# 获取版本信息（git describe --tags），失败则为 dev
$VERSION = ""
try {
    $raw = & git describe --tags 2>$null
    if ($raw) { $VERSION = $raw.ToString().Trim() }
} catch {
    $VERSION = ""
}
if ([string]::IsNullOrWhiteSpace($VERSION)) { $VERSION = "dev" }

Write-Host "Current version:`n$VERSION" -ForegroundColor Green

function Show-Help {
    Write-Host "Usage:`n  .\build.ps1 [-Target <all|web|one-api|app|clean|help>]" -ForegroundColor Yellow
    Write-Host "Targets:`n  all      Build everything (default)`n  web      Build web resources`n  one-api  Build Go binary (requires built web resources)`n  app      Build Go binary only`n  clean    Remove build artifacts`n  help     Show this help" -ForegroundColor Yellow
}

function Invoke-Web {
    Write-Host "Building web resources..." -ForegroundColor Cyan
    if (-not (Test-Path $WEBDIR)) {
        Write-Host "Web directory not found!" -ForegroundColor Red; exit 1
    }
    Push-Location $WEBDIR
    $buildDir = Join-Path (Get-Location) "build"
    if (-not (Test-Path $buildDir)) { New-Item -ItemType Directory -Path $buildDir | Out-Null }

    $env:VITE_APP_VERSION = $VERSION
    Write-Host "Running: yarn run build" -ForegroundColor Yellow
    & yarn run build
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to build web project!" -ForegroundColor Red; Pop-Location; exit 1
    }
    Pop-Location
    Write-Host "Web build finished." -ForegroundColor Green
}

function Invoke-GoBuild {
    param([switch]$RequireWeb)

    if ($RequireWeb) { Invoke-Web }

    Write-Host "Current CGO_ENABLED:" -ForegroundColor Yellow; & go env CGO_ENABLED
    Write-Host "Current GOOS:" -ForegroundColor Yellow; & go env GOOS
    Write-Host "Current GOARCH:" -ForegroundColor Yellow; & go env GOARCH

    Write-Host "Building Go binary..." -ForegroundColor Cyan
    if (-not (Test-Path $DISTDIR)) { New-Item -ItemType Directory -Path $DISTDIR | Out-Null }

    # 构造 ldflags，确保整个参数作为一个字符串传递，保留项目包路径 one-hub
    $ldFlags = "-s -w -X 'one-hub/common/config.Version=$VERSION'"
    $outputPath = Join-Path $DISTDIR $NAME
    Write-Host "go build -ldflags $ldFlags -o $outputPath" -ForegroundColor Yellow
    & go build -ldflags $ldFlags -o $outputPath
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Go build failed!" -ForegroundColor Red; exit 1
    }
    Write-Host "Build completed: $outputPath" -ForegroundColor Green
}

function Invoke-Clean {
    Write-Host "Cleaning build artifacts..." -ForegroundColor Cyan
    if (Test-Path $DISTDIR) {
        Remove-Item -Recurse -Force -LiteralPath $DISTDIR
        Write-Host "Deleted $DISTDIR" -ForegroundColor Green
    } else {
        Write-Host "$DISTDIR not found" -ForegroundColor Yellow
    }

    $webBuild = Join-Path $WEBDIR "build"
    if (Test-Path $webBuild) {
        Remove-Item -Recurse -Force -LiteralPath $webBuild
        Write-Host "Deleted $webBuild" -ForegroundColor Green
    } else {
        Write-Host "$webBuild not found" -ForegroundColor Yellow
    }
}

switch ($Target.ToLower()) {
    "all" { Invoke-GoBuild -RequireWeb:$true; break }
    "web" { Invoke-Web; break }
    "one-api" { Invoke-GoBuild -RequireWeb:$true; break }
    "app" { Invoke-GoBuild; break }
    "clean" { Invoke-Clean; break }
    "help" { Show-Help; break }
    default { Write-Host "Unknown target: $Target" -ForegroundColor Red; Show-Help; exit 1 }
}

exit $LASTEXITCODE

