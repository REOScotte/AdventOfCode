$inputs = "R1, R3, L2, L5, L2, L1, R3, L4, R2, L2, L4, R2, L1, R1, L2, R3, L1, L4, R2, L5, R3, R4, L1, R2, L1, R3, L4, R5, L4, L5, R5, L3, R2, L3, L3, R1, R3, L4, R2, R5, L4, R1, L1, L1, R5, L2, R1, L2, R188, L5, L3, R5, R1, L2, L4, R3, R5, L3, R3, R45, L4, R4, R72, R2, R3, L1, R1, L1, L1, R192, L1, L1, L1, L4, R1, L2, L5, L3, R5, L3, R3, L4, L3, R1, R4, L2, R2, R3, L5, R3, L1, R1, R4, L2, L3, R1, R3, L4, L3, L4, L2, L2, R1, R3, L5, L1, R4, R2, L4, L1, R3, R3, R1, L5, L2, R4, R4, R2, R1, R5, R5, L4, L1, R5, R3, R4, R5, R3, L1, L2, L4, R1, R4, R5, L2, L3, R4, L4, R2, L2, L4, L2, R5, R1, R4, R3, R5, L4, L4, L5, L5, R3, R4, L1, L3, R2, L2, R1, L3, L5, R5, R5, R3, L4, L2, R4, R5, R1, R4, L3"
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

"First repeat is " + $repeats[0]