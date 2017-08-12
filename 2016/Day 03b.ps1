$inputs = Get-Content '.\Day 03.txt'
#$inputs = @"
#  238  413  620
#  222  366   58
#  427  323  608
#  613  402  520
#  401  211  328
#  1725  312  215
#"@

$inputs = $inputs.Split("`n")
$count = 0
$groups = $inputs.Count / 3

$i = 0

0..($groups -1) | ForEach-Object {
    $row1 = ($inputs[$i++]).Trim() -replace '\s+', ',' -split ','
    $row2 = ($inputs[$i++]).Trim() -replace '\s+', ',' -split ','
    $row3 = ($inputs[$i++]).Trim() -replace '\s+', ',' -split ','

    0..2 | ForEach-Object {
        if ([int]$row1[$_] + [int]$row2[$_] -gt [int]$row3[$_] -and
            [int]$row2[$_] + [int]$row3[$_] -gt [int]$row1[$_] -and
            [int]$row3[$_] + [int]$row1[$_] -gt [int]$row2[$_]) {$count++}
    }
}

$count