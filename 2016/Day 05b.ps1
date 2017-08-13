$md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$utf8 = New-Object -TypeName System.Text.UTF8Encoding

$doorID = "ugkcyxxp"

$password = @{}
$i = 1

while ($password.Count -lt 8) {
    $code = $doorID + $i
    $hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($code)))
    $hash = $hash.Replace("-", "")
    if ($hash.Substring(0, 5) -eq "00000") {
        $position = $hash.Substring(5, 1)
        if ($position -in 0..7) {
            if (-not $password.Contains($position)) {
                $password.Add($position, $hash.Substring(6, 1))
# For some reason displayPassword collides with password
#                $displayPassword = $password
#                0..7 | ForEach-Object {
#                    if (-not $displayPassword.Contains($_)) {
#                        $displayPassword.Add($_, "_")
#                    }
#                }
#                ($displayPassword.GetEnumerator() | sort name).Value -join ''
            ($password.GetEnumerator() | sort name).Value -join ''
            }
        }
    }
    $i++
}
