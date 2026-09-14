$ErrorActionPreference = 'Stop'
$dir = '.'
$out = '.\.codebuddy\tmp_tails.txt'
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

function Clean($s) {
  # strip tool-ish xml tags and env blobs to focus on real prose
  $s = $s -replace '(?s)<user_info>.*?</user_info>', ' ' -replace '(?s)<project_context>.*?</project_context>', ' ' -replace '(?s)<additional_data>.*?</additional_data>', ' ' -replace '(?s)<user_query>', ' '
  $s = $s -replace '[ \t\r\n]+', ' '
  return $s.Trim()
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
    [void]$sb.AppendLine('==== CONVERSATION: ' + $c.name)
    $idx = 0
    foreach ($req in @($c.requests)) {
      $idx++
      $msgs = @($req.messages)
      # collect assistant final text
      $lastAssist = ''
      foreach ($m in $msgs) {
        $role = ''
        try { $role = [string]$m.role } catch {}
        $body = $m.message
        if ($body -is [string]) { try { $body = $body | ConvertFrom-Json } catch { $body = $null } }
        if (-not $body) { continue }
        if ($role -eq 'assistant' -or $role -eq 'model') { $lastAssist = Get-MsgText $body }
      }
      $lastAssist = Clean $lastAssist
      if ($lastAssist) {
        if ($lastAssist.Length -gt 1600) { $lastAssist = $lastAssist.Substring($lastAssist.Length - 1600) }
        [void]$sb.AppendLine('  [ASSISTANT #' + $idx + ' tail] ' + $lastAssist)
        [void]$sb.AppendLine('')
      }
    }
  }
}

$abs = Join-Path (Get-Location) $out
[System.IO.File]::WriteAllText($abs, $sb.ToString(), (New-Object System.Text.UTF8Encoding($true)))
Write-Output ('DONE size=' + $sb.Length)
