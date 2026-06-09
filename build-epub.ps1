param(
    [string[]]$SourceDirs = @(
        ".\books",
        ".\characters",
        ".\weapons",
        ".\artifacts"
    ),
    [string]$OutputDir = ".\output"
)

if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
    Write-Error "未找到 pandoc，请先安装并加入 PATH"
    exit 1
}

if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

foreach ($dir in $SourceDirs) {

    if (-not (Test-Path $dir)) {
        Write-Warning "目录不存在，跳过: $dir"
        continue
    }

    $bookName = Split-Path $dir -Leaf

    $outputFile = Join-Path $OutputDir ($bookName + ".epub")

    Write-Host "正在处理: $bookName"

    $mdFiles = Get-ChildItem -Path $dir -Filter *.md -File |
               Sort-Object Name

    if ($mdFiles.Count -eq 0) {
        Write-Warning "没有 md 文件: $dir"
        continue
    }

    $fileList = $mdFiles | ForEach-Object { $_.FullName }

    $coverPath = Join-Path $dir "images" "cover.png"

    $coverArg = @()
    if (Test-Path $coverPath) {
        Write-Host "使用封面: $coverPath"
        $coverArg = @("--epub-cover-image=$coverPath")
    }

    $arguments = @()
    $arguments += $fileList
    $arguments += "-o"
    $arguments += $outputFile
    $arguments += "--toc"
    $arguments += "--embed-resources"
    $arguments += "--resource-path=$dir"
    $arguments += "--metadata=title=$bookName"

    if ($coverArg.Count -gt 0) {
        $arguments += $coverArg
    }
    
    & pandoc @arguments

    if ($LASTEXITCODE -eq 0) {
        Write-Host "生成成功: $outputFile" -ForegroundColor Green
    } else {
        Write-Host "生成失败: $bookName" -ForegroundColor Red
    }
}

Write-Host "全部处理完成"