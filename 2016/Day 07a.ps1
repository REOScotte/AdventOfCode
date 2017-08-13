$inputs = Get-Content '.\Day 07.txt'
#$inputs = @"
#abba[mnop]qrst
#abcd[bddb]xyyx
#aaaa[qwer]tyui
#ioxxoj[asdfgh]zxcvbn
#"@

$inputs = $inputs.Split("`n")
$answer = 0

foreach ($input in $inputs) {
    $valid = 1
    $DQ = 0
    $abba = 0
    for ($i = 0; $i -lt ($input.Length -4); $i++) {
        if ($input[$i] -eq "[") {$valid = 0}
        if ($input[$i] -eq "]") {$valid = 1}
        if ($input[$i] -eq $input[$i + 3] -and $input[$i + 1] -eq $input[$i + 2]) {
            if (-not $valid) {$DQ = 1}
            $abba = 1
        }
    }
    if ($abba -and -not $DQ) {$answer++}
}

"Answer: $answer"
