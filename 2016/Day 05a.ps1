$md5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$utf8 = New-Object -TypeName System.Text.UTF8Encoding

$doorID = "ugkcyxxp"

$password = ""
$i = 1

while ($password.Length -lt 8) {
    $code = $doorID + $i
    $hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes($code)))
    $hash = $hash.Replace("-", "")
    #"$code $hash"
    if ($hash.Substring(0, 5) -eq "00000") {
        $password += $hash.Substring(5, 1)
        $password
    }
    $i++
}
