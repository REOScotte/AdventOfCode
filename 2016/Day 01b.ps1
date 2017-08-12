$inputs = Get-Content '.\Day 01.txt'
#$inputs = "R8, R4, R4, R8"
$inputs = $inputs.Replace(" ", "")
$inputs = $inputs.Split(",")

$direction = 0
$coordX    = 0
$coordY    = 0

[string[]]$history = "X0 Y0"
[string[]]$repeats = $null

foreach ($input in $inputs) {
    $d = $input.SubString(0, 1)
    $l = $input.SubString(1, $input.Length - 1)

    switch ($d) {
        "R" {$direction++}
        "L" {$direction--}
    }

    $direction = $direction % 4
    if ($direction -lt 0) {$direction += 4}

    switch ($direction) {
        0 {1..$l | % {$coordY += 1; $location = "X$coordX Y$CoordY"; if ($history -contains $location){$repeats += $location}; $history += $location}; $facingDirection = "North"}
        1 {1..$l | % {$coordX += 1; $location = "X$coordX Y$CoordY"; if ($history -contains $location){$repeats += $location}; $history += $location}; $facingDirection = "East"}
        2 {1..$l | % {$coordY -= 1; $location = "X$coordX Y$CoordY"; if ($history -contains $location){$repeats += $location}; $history += $location}; $facingDirection = "South"}
        3 {1..$l | % {$coordX -= 1; $location = "X$coordX Y$CoordY"; if ($history -contains $location){$repeats += $location}; $history += $location}; $facingDirection = "West"}
    }

    #"$input Turn $facingDirection, walk $l end at X$coordX Y$coordY. Distance = " + [int]([math]::abs($coordX) + [math]::abs($coordY))
}

$repeatX = $repeats[0].Split(' ').Replace('X', '')[0]
$repeatY = $repeats[0].Split(' ').Replace('Y', '')[1]

"First repeat is " + $repeats[0] + ". Distance = " + [int]([math]::abs($repeatX) + [math]::abs($repeatY))
