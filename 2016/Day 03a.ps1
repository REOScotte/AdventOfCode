$inputs = Get-Content '.\Day 03.txt'

$inputs = $inputs.Split("`n")
$count = 0

foreach ($input in $inputs) {
    $row = $input.Trim() -replace '\s+', ',' -split ','

    $a = [int]$row[0]
    $b = [int]$row[1]
    $c = [int]$row[2]

    if ($a + $b -gt $c -and $a + $c -gt $b -and $b + $c -gt $a) {$count++}
}

"Valid triangles: $count"