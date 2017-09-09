cls
$inputs = Get-Content '.\Day 09.txt'
$inputs = @"
(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7).EVEN
"@

while ($inputs -like "*(*" -and $inputs -like "*)*") {
    $length = $inputs.Length
    $output = ""
    $i = 0

    while ($i -lt $length) {
        $c = $inputs[$i]
        if ($c -eq '(') {
            $r = ""
            while ($c -ne ')') {
                $c = $inputs[$i]
                $r += $c
                $i++
            }
            $l = $r.Split('x')[0].Replace('(', '')
            $t = $r.Split('x')[1].Replace(')', '')
            for ($j = 0; $j -lt $t; $j++) {
                $output += $inputs.Substring($i, $l)
            }
            $i += $l
        }
        else {
            $output += $c
            $i++
        }
    }
    $inputs = $output
    $output
    "`n"
}

