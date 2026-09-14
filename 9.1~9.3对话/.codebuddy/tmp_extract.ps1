$ErrorActionPreference = 'Stop'
$dir = '.'
$out = '.\.codebuddy\tmp_dialogs.txt'
$files = Get-ChildItem -Path $dir -Filter '*.json' | Sort-Object Name
$sb = New-Object System.Text.StringBuilder

function Get-MsgText($m) {
  $t = ''
  try {
    if ($m.PSObject.Properties['text']) { $t = [string]$m.text }
    elseif ($m.PSObject.Properties['content']) {
      $cc = $m.content
      if ($cc -is [System.Array]) {
        $parts = @()
        foreach ($p in $cc) {
          if ($p.PSObject.Properties['text']) { $parts += [string]$p.text }
          elseif ($p.PSObject.Properties['content']) { $parts += [string]$p.content }
        }
        $t = $parts -join ' | '
      } elseif ($cc -is [string]) { $t = $cc }
    }
  } catch { $t = '' }
  return $t
}

foreach ($f in $files) {
  [void]$sb.AppendLine('')
  [void]$sb.AppendLine('############################################################')
  [void]$sb.AppendLine('# FILE: ' + $f.Name)
  [void]$sb.AppendLine('############################################################')
  $j = Get-Content -Raw -Encoding UTF8 $f.FullName | ConvertFrom-Json
  if (-not $j.data.conversations) { continue }
  foreach ($c in $j.data.conversations) {
    [void]$sb.AppendLine('')
    [void]$sb.AppendLine('==== CONVERSATION: ' + $c.name + '  (created=' + $c.createdAt + ', last=' + $c.lastMessageAt + ')')
    $reqs = @($c.requests)
    foreach ($req in $reqs) {
      $msgs = @($req.messages)
      $userMsgs = @()
      foreach ($m in $msgs) {
        $role = ''
        try { $role = [string]$m.role } catch {}
        $body = $m.message
        if ($body -is [string]) {
          try { $body = $body | ConvertFrom-Json } catch { $body = $null }
        }
        if (-not $body) { continue }
        $innerRole = ''
        try { $innerRole = [string]$body.role } catch {}
        if ($role -ne 'user' -and $innerRole -ne 'user') { continue }
        $text = Get-MsgText $body
        if (-not $text) { continue }
        $text = $text -replace '[\r\n]+', ' '
        if ($text.Length -gt 1500) { $text = $text.Substring(0, 1500) + ' ...[truncated]' }
        $userMsgs += $text
      }
      foreach ($u in $userMsgs) {
        [void]$sb.AppendLine('  [USER] ' + $u)
        [void]$sb.AppendLine('')
      }
    }
  }
}

$abs = Join-Path (Get-Location) $out
[System.IO.File]::WriteAllText($abs, $sb.ToString(), (New-Object System.Text.UTF8Encoding($true)))
Write-Output ('DONE size=' + $sb.Length)
