$inputs = Get-Content '.\Day 04.txt'

# Can't figure out why test lines below only work for one line at a time.
#$inputs = @"
#hwbba-gii-eqpvckpogpv-492[pbgiv]
#zsxyfgqj-hqfxxnknji-idj-xytwflj-359[jxfin]
#"@

$inputs = $inputs.Split("`n")

$total = 0

[string[]]$answer = $null
foreach ($input in $inputs) {
    $checksum     = $input.Split('[')[1].Replace(']', '')
    $sectorID     = $input.Split('[')[0].Split('-')[-1]
    $rawData      = $input.Split('[')[0] -replace '\d', ''
    $data         = $rawdata -replace '-', ''
    $shift        = $sectorID % 26

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

    $output = ""
    if ($computed -eq $checksum) {
        foreach ($char in [char[]]$rawData) {
            $newChar = [char]([int]$char + $shift)
            if ([int]$newChar -gt 122) {
                $newChar = [char]([int]$newChar - 26)
            }
            if ($char -eq "-") {$newChar = " "}
            $output += $newChar
        }
            if ($output -like "*north*") {
                $answer += $output + "is in sector $sectorID"
            }
    }
}
$answer