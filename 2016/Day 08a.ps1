$inputs = Get-Content '.\Day 08.txt'
#$inputs = @"
#rect 3x2
#rotate column x=1 by 1
#rotate row y=0 by 4
#rotate column x=1 by 1
#"@
$inputs = $inputs.Split("`n")

$screenX = 50
$screenY = 6

$screen = New-Object 'char[,]' $screenX, $screenY

for ($y = 0; $y -lt $screenY; $y++) {
    for ($x = 0; $x -lt $screenX; $x++) {
        $screen[$x, $y] = '.'
    }
}

foreach ($input in $inputs) {
    if ($input.substring(0, 5) -eq 'rect ') {
        $rectX = $input.split(' ')[1].split('x')[0]
        $rectY = $input.split('x')[1]

        for ($y = 0; $y -lt $rectY; $y++) {
            for ($x = 0; $x -lt $rectX; $x++) {
                $screen[$x, $y] = '#'
            }
        }
        
    }

    if ($input.substring(0, 8) -eq 'rotate r') {
        $row = $input.split('=')[1].split(' ')[0]
        $times = $input.split(' ')[4]

        for ($i = 0; $i -lt $times; $i++) {
            $t = $screen[($screenX - 1), $row]
            for ($j = ($screenX - 1); $j -gt 0; $j--) {
                $screen[$j, $row] = $screen[($j - 1), $row]
            }
            $screen[0, $row] = $t
        }

    }

    if ($input.substring(0, 8) -eq 'rotate c') {
        $col = $input.split('=')[1].split(' ')[0]
        $times = $input.split(' ')[4]

        for ($i = 0; $i -lt $times; $i++) {
            $t = $screen[$col, ($screenY - 1)]
            for ($j = ($screenY - 1); $j -gt 0; $j--) {
                $screen[$col, $j] = $screen[$col, ($j - 1)]
            }
            $screen[$col, 0] = $t
        }

    }
}

$count = 0

for ($y = 0; $y -lt $screenY; $y++) {
    $row = ''
    for ($x = 0; $x -lt $screenX; $x++) {
        if ($screen[$x, $y] -eq '#') {$count++}
        $row += $screen[$x, $y]
    }
    $row
}

$count