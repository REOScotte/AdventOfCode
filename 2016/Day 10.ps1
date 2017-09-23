$inputs = Get-Content '.\Day 10.txt'
$inputs = @"
value 5 goes to bot 2
bot 2 gives low to bot 1 and high to bot 0
value 3 goes to bot 1
bot 1 gives low to output 1 and high to bot 0
bot 0 gives low to output 2 and high to output 0
value 2 goes to bot 2
"@
$inputs = Get-Content '.\Day 10.txt'

$inputs = $inputs.Split("`n")

class bot {
    [int]$num
    [int]$low = -1
    [int]$lowMap = -1
    [int]$high = -1
    [int]$highMap = -1

    bot ([int]$num) {
        $this.num = $num
    }
    
    [void] load([int]$new) {
        if ($new -ge $this.high) {
            $this.low = $this.high
            $this.high = $new
        }
        else {
            $this.low = $new
        }
        $this.disburse()
    }

    [void] map([string]$ord, [int]$map) {
        if ($ord -eq 'low') {
            $this.lowMap = $map
        }
        else {
            $this.highMap = $map
        }
        $this.disburse()
    }

    [void] disburse() {
        if ($this.low -ge 0 -and $this.lowMap -ge 0 -and $this.high -ge 0 -and $this.highMap -ge 0) {
            $lowDest = $global:bots | Where-Object num -eq $this.lowMap
            if ($lowDest) {
                $lowDest.load($this.low)
            }
            else {
                $lowDest = [bot]::New($this.lowMap)
                $lowDest.load($this.low)
                $global:bots.Add($lowDest)
            }

            $highDest = $global:bots | Where-Object num -eq $this.highMap
            if ($highDest) {
                $highDest.load($this.high)
            }
            else {
                $highDest = [bot]::New($this.highMap)
                $highDest.load($this.high)
                $global:bots.Add($highDest)
            }
        }
    }
}

class bin {
    [int]$num
    [int]$value
    
    bin ([int]$num) {
        $this.num = $num
    }

    [void] load([int]$new) {
        $this.value = $new
    }
}

$bots = New-Object -TypeName System.Collections.Generic.List[bot]
$bins = New-Object -TypeName System.Collections.Generic.List[bin]

foreach ($input in $inputs) {
    $instruction = $input.split(' ')
    $type = $instruction[0]

    if ($type -eq 'value') {
        $chip = $instruction[1]
        $dest = $instruction[5]

        $destBot = $bots | Where-Object num -eq $dest
        if ($destBot) {
            $destBot.load($chip)
        }
        else {
            $destBot = [bot]::New($dest)
            $destBot.load($chip)
            $bots.Add($destBot)
        }
    }

    if ($type -eq 'bot') {
        $bot = $instruction[1]
        $lowDestType = $instruction[5]
        $lowDest = $instruction[6]
        $highDestType = $instruction[10]
        $highDest = $instruction[11]

        $destBot = $bots | Where-Object num -eq $bot
        if (-not $destBot) {
            $destBot = [bot]::new($bot)
            $bots.Add($destBot)
        }

        if ($lowDestType -eq 'bot') {
            $destBot.map("low", $lowDest)
        }

        if ($highDestType -eq 'bot') {
            $destBot.map("high", $highDest)
        }

        #       if ($lowDestType -eq 'output') {
        #           $destBin = $bins | Where-Object num -eq $lowDest
        #           if ($destBin) {
        #               $destBin.load($bot.low)
        #           }
        #           else {
        #               $destBin = [bin]::New($lowDest)
        #               $destBin.load($bot.low)
        #               $bins.Add($destBot)
        #           }
        #       }
        #
        #       if ($highDestType -eq 'output') {
        #           $destBin = $bins | Where-Object num -eq $highDest
        #           if ($destBin) {
        #               $destBin.load($bot.high)
        #           }
        #           else {
        #               $destBin = [bin]::New($highDest)
        #               $destBin.load($bot.high)
        #               $bins.Add($destBot)
        #           }
        #       }

    }

}

$bots|ft
$bots|? low -eq 17 | ? high -eq 61 | ft
$bins
$inputs = @"
value 5 goes to bot 2
bot 2 gives low to bot 1 and high to bot 0
value 3 goes to bot 1
bot 1 gives low to output 1 and high to bot 0
bot 0 gives low to output 2 and high to output 0
value 2 goes to bot 2
"@
