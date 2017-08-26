$inputs = Get-Content '.\Day 07.txt'
#$inputs = @"
#aba[bab]xyz
#xyx[xyx]xyx
#aaa[kek]eke
#zazbz[bzb]cdb
#"@

#$inputs = @"
#ottpscfbgoiyfri   [iwzhojzrpzuinumuwd]   orfroqlcemumqbqqrea
#"@


$inputs = $inputs.Split("`n")
$answer = 0

foreach ($input in $inputs) {
    $ssl = 0
    $abaValid = 1
    for ($i = 0; $i -lt ($input.Length - 2); $i++) {
        if ($input[$i] -eq "[") {$abaValid = 0}
        if ($input[$i] -eq "]") {$abaValid = 1}
        if ($input[$i] -eq $input[$i + 2] -and $input[$i] -ne $input[$i + 1] -and $abaValid) {
            $bab = $input[$i + 1] + $input[$i] + $input[$i + 1]
            $babValid = 0#;$bab
            for ($j = 0; $j -lt ($input.Length - 2); $j++) {
                if ($input[$j] -eq "[") {$babValid = 1}
                if ($input[$j] -eq "]") {$babValid = 0}
                if ($input[$j] + $input[$j + 1] + $input[$j + 2] -eq $bab -and $babValid) {
                    $ssl = 1
                }
            }
        }
    }
    if ($ssl) {$answer++}
}

"Answer: $answer"
