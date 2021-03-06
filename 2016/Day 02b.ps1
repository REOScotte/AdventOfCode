﻿$inputs = Get-Content '.\Day 02.txt'

#$inputs = @"
#ULL
#RRDDD
#LURDL
#UUUUD
#"@

$inputs = $inputs.Split("`n")

$location = '5'
$answer = ""

foreach ($input in $inputs) {

    foreach ($step in [char[]]$input) {
 
        $i = [System.Convert]::ToInt32($location, 16)
        switch ($step) {
            "U" {$location = " 121452349678B"[$i]}
            "D" {$location = " 36785ABC9ADCD"[$i]}
            "R" {$location = " 134467899BCCD"[$i]}
            "L" {$location = " 122355678AABD"[$i]}
        }

    }

    $answer += $location

}

"Answer: $answer"
