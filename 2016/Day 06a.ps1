$inputs = Get-Content '.\Day 06.txt'
#$inputs = @"
#asdf
#1234
#1s3f
#"@

$inputs = $inputs.Split("`n")
$answer = ""

$slot0 = $slot1 = $slot2 = $slot3 = $slot4 = $slot5 = $slot6 = $slot7 = $null
foreach ($input in $inputs) {
    [int[]]$slot0 += [int]$input[0]
    [int[]]$slot1 += [int]$input[1]
    [int[]]$slot2 += [int]$input[2]
    [int[]]$slot3 += [int]$input[3]
    [int[]]$slot4 += [int]$input[4]
    [int[]]$slot5 += [int]$input[5]
    [int[]]$slot6 += [int]$input[6]
    [int[]]$slot7 += [int]$input[7]
}

$answer += [char][int](($slot0 | group | sort count -Descending | select -First 1).Name)
$answer += [char][int](($slot1 | group | sort count -Descending | select -First 1).Name)
$answer += [char][int](($slot2 | group | sort count -Descending | select -First 1).Name)
$answer += [char][int](($slot3 | group | sort count -Descending | select -First 1).Name)
$answer += [char][int](($slot4 | group | sort count -Descending | select -First 1).Name)
$answer += [char][int](($slot5 | group | sort count -Descending | select -First 1).Name)
$answer += [char][int](($slot6 | group | sort count -Descending | select -First 1).Name)
$answer += [char][int](($slot7 | group | sort count -Descending | select -First 1).Name)

"Answer: $answer"
