$inputs = Get-Content '.\Day 09.txt'
#$inputs = @"
#(27x12)(20x12)(13x14)(7x10)(1x12)A
#"@

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

$output.Length