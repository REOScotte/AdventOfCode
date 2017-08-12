$inputs = Get-Content '.\Day 01.txt'
#$inputs = "R2, L3"
#$inputs = "R2, R2, R2"
#$inputs = "R5, L5, R5, R3"
#$inputs = "R5, R5, R10"
$inputs = $inputs.Replace(" ", "")
$inputs = $inputs.Split(",")

$direction = 0
$coordX    = 0
$coordY    = 0

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
        0 {$coordY += $l; $facingDirection = "North"}
        1 {$coordX += $l; $facingDirection = "East"}
        2 {$coordY -= $l; $facingDirection = "South"}
        3 {$coordX -= $l; $facingDirection = "West"}
    }

    #"$input Turn $facingDirection, walk $l end at X$coordX Y$coordY. Distance = " + [int]([math]::abs($coordX) + [math]::abs($coordY))
}

"Facing $facingDirection at X$coordX Y$coordY. Distance = " + [int]([math]::abs($coordX) + [math]::abs($coordY))
