$ErrorActionPreference = 'Stop'
$f = Get-ChildItem -Path '.' -Filter '*.json' | Sort-Object Name | Select-Object -First 1
$j = Get-Content -Raw -Encoding UTF8 $f.FullName | ConvertFrom-Json
$c = $j.data.conversations[0]
$reqs = $c.requests
Write-Output ('reqCount: ' + @($reqs).Count)
$r0 = @($reqs)[0]
Write-Output ('req keys: ' + ($r0.PSObject.Properties.Name -join ', '))
$json = $r0 | ConvertTo-Json -Depth 3 -Compress
if ($json.Length -gt 2000) { $json = $json.Substring(0,2000) }
Write-Output $json
