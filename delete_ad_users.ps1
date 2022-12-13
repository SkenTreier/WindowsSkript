$firstname = Read-Host "Sisesta Eesnimi"
$lastname = Read-Host "Sisesta Perenimi"
$username = $firstname + "." + $lastname
$username = $username.ToLower()
$username = Translit($username)
$displayname = $firstname + " " + $lastname

    if (Get-ADUser -F {SamAccountName -EQ $username})
        {
                 Remove-ADUser -identity $username
                echo "Kasutaja $displayname on edukalt kustutatud."
        }
        else
        {
        Write "Kasutaja ei eksisteeri või tekkis probleem kustutamisel, palun proovige uuesti."
        }

Function Translit {
    param(
        [string] $inputString
    )

        $Translit = @{
        [char]'ä' = "a"
        [char]'õ' = "o"
        [char]'ü' = "u"
        [char]'ö' = "o"
        }
        $outputString=""
        foreach ($character in $inputCharacter = $inputString.ToCharArray())
    {
        if ($Translit[$character] -cne $Null){
        $outputString += $Translit[$character]
        }else {
            $outputString += $character
            }
            }
            Write-Output $outputString
            }
