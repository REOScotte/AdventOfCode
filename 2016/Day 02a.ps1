$inputs = Get-Content '.\Day 02.txt'

#$inputs = @"
#ULL
#RRDDD
#LURDL
#UUUUD
#"@

$inputs = $inputs.Split("`n")

$coordX = 0
$coordY = 0
$answer = ""

foreach ($input in $inputs) {

    foreach ($step in [char[]]$input) {

        switch ($step) {
            "U" {$coordY++; if ($coordY -gt  1) {$coordY--}}
            "D" {$coordY--; if ($coordY -lt -1) {$coordY++}}
            "R" {$coordX++; if ($coordX -gt  1) {$coordX--}}
            "L" {$coordX--; if ($coordX -lt -1) {$coordX++}}
        }
    }

    $spot = [string]$coordX + [string]$coordY

    switch ($spot) {
        "-11"  {$answer += [string]"1"}
        "01"   {$answer += [string]"2"}
        "11"   {$answer += [string]"3"}
        "-10"  {$answer += [string]"4"}
        "00"   {$answer += [string]"5"}
        "10"   {$answer += [string]"6"}
        "-1-1" {$answer += [string]"7"}
        "0-1"  {$answer += [string]"8"}
        "1-1"  {$answer += [string]"9"}
    }

}

"Answer: $answer"
