$ErrorActionPreference='Stop'
& (Join-Path $PSScriptRoot 'restore-compiler.ps1')
$out=Join-Path $PSScriptRoot 'build/tests'
New-Item -ItemType Directory -Path $out -Force|Out-Null
$csc=Join-Path $PSScriptRoot '.deps/compiler/tasks/net472/csc.exe'
$exe=Join-Path $out 'pool.exe'
& $csc /nologo /target:exe "/out:$exe" (Join-Path $PSScriptRoot 'src/AirframePool.cs') (Join-Path $PSScriptRoot 'tests/test_shared_airframes.cs')
if($LASTEXITCODE -ne 0){throw 'Test compilation failed'}
& $exe
if($LASTEXITCODE -ne 0){throw 'Offline test failed'}
