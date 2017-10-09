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
    [string]$lowMapType = ''
    [int]$high = -1
    [int]$highMap = -1
    [string]$highMapType = ''

    bot ([int]$num) {
        $this.num = $num
    }

    [void] load([int]$new) {
        if ($new -ge $this.high) {
            $this.low = $this.high
            $this.high = $new
        } else {
            $this.low = $new
        }
        $this.disburse()
    }

    [void] map([string]$ord, [int]$map, [string]$type) {
        if ($ord -eq 'low') {
            $this.lowMap = $map
            $this.lowMapType = $type
        } else {
            $this.highMap = $map
            $this.highMapType = $type
        }
        $this.disburse()
    }

    [void] disburse() {
        if ($this.low -ge 0 -and $this.lowMap -ge 0 -and $this.high -ge 0 -and $this.highMap -ge 0) {

            if ($this.lowMapType -eq 'bot') {
                $lowDest = $global:bots | Where-Object num -eq $this.lowMap
                if ($lowDest) {
                    $lowDest.load($this.low)
                } else {
                    $lowDest = [bot]::New($this.lowMap)
                    $lowDest.load($this.low)
                    $global:bots.Add($lowDest)
                }
            }

            if ($this.lowMapType -eq 'output') {
                $lowDest = $global:bins | Where-Object num -eq $this.lowMap
                if ($lowDest) {
                    $lowDest.load($this.low)
                } else {
                    $lowDest = [bin]::New($this.lowMap)
                    $lowDest.load($this.low)
                    $global:bins.Add($lowDest)
                }
            }

            if ($this.highMapType -eq 'bot') {
                $highDest = $global:bots | Where-Object num -eq $this.highMap
                if ($highDest) {
                    $highDest.load($this.high)
                } else {
                    $highDest = [bot]::New($this.highMap)
                    $highDest.load($this.high)
                    $global:bots.Add($highDest)
                }
            }

            if ($this.highMapType -eq 'output') {
                $highDest = $global:bins | Where-Object num -eq $this.highMap
                if ($highDest) {
                    $highDest.load($this.high)
                } else {
                    $highDest = [bin]::New($this.highMap)
                    $highDest.load($this.high)
                    $global:bins.Add($highDest)
                }
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
        if (-not $destBot) {
            $destBot = [bot]::New($dest)
            $bots.Add($destBot)
        }
        $destBot.load($chip)
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

        $destBot.map("low", $lowDest, $lowDestType)
        $destBot.map("high", $highDest, $highDestType)
    }

}

$bots|? low -eq 17 | ? high -eq 61 | ft
($bins |? num -eq 0).value * ($bins |? num -eq 1).value * ($bins |? num -eq 2).value
