$inputs = Get-Content '.\Day 04.txt'

# Can't figure out why test lines below only work for one line at a time.
#$inputs = @"
#hwbba-gii-eqpvckpogpv-492[pbgiv]
#zsxyfgqj-hqfxxnknji-idj-xytwflj-359[jxfin]
#"@

$inputs = $inputs.Split("`n")

$total = 0

foreach ($input in $inputs) {
    $checksum     = $input.Split('[')[1].Replace(']', '')
    $sectorID     = $input.Split('[')[0].Split('-')[-1]
    $data         = $input.Split('[')[0] -replace '\d', '' -replace '-', ''
 
    $table = @{}
    foreach ($char in [char[]]$data) {
        if ($table.Contains($char)) {
            $table.Item($char)++
        } else {
            $table.Add($char, 1)
        }
    }

    
    #Tricky to get this to sort by value descending and then name ascending.
    #$computed = ($table.GetEnumerator() | sort name | sort Value -Descending | select -First 5).Name -join ''
    $computed = ($table.GetEnumerator() | sort @{Expression = {$_.Value}; Ascending = $false}, @{Expression = {$_.Name}; Ascending = $true} | select -First 5).Name -join ''

    if ($computed -eq $checksum) {
        $total += $sectorID
        $computed + "==" + $checksum
    } else {
        $computed + "<>" + $checksum
    }

}

"Answer: $total"
