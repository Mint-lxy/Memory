$ErrorActionPreference = 'Stop'
$f = Get-ChildItem -Path '.' -Filter '*.json' | Sort-Object Name | Select-Object -First 1
Write-Output ('FILE: ' + $f.Name)
$j = Get-Content -Raw -Encoding UTF8 $f.FullName | ConvertFrom-Json
$c = $j.data.conversations[0]
Write-Output ('conv keys: ' + ($c.PSObject.Properties.Name -join ', '))
$msgs = $null
try { $msgs = $c.messages } catch {}
if (-not $msgs) { try { $msgs = $c.conversation.messages } catch {} }
Write-Output ('msgCount: ' + @($msgs).Count)
if ($msgs -and @($msgs).Count -gt 0) {
  $first = @($msgs)[0]
  Write-Output ('first msg keys: ' + ($first.PSObject.Properties.Name -join ', '))
  $json = $first | ConvertTo-Json -Depth 4 -Compress
  if ($json.Length -gt 1500) { $json = $json.Substring(0,1500) }
  Write-Output $json
}
