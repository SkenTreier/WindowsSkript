function Translit {
    param(
        [string] $inputString
    )
        $Translit = @{
        [char]'ä' = 'a'
        [char]'ö' = 'o'
        [char]'ü' = 'u'
        [char]'õ' = 'o'
        }

    $outputString=""
    foreach ($character in $inputCharacter = $inputString.ToCharArray())
    {
        if ($Translit[$character] -cne $Null){
        
            
           $outputString += $Translit[$character]

        } else {
            $outputString += $character
        }
    }
    Write-Output $outputString
}

$file="C:\Users\Administrator\Documents\adusers.csv"

$users=Import-Csv $file -Encoding Default -Delimiter ";"
$ErrorActionPreference = 'SilentlyContinue'
foreach ($user in $users){
    $username = $user.FirstName + "." + $user.LastName
    $username = $username.ToLower()
    $username = Translit($username)
    $upname = $username + "@sv-kool.local"
    $displayname =$user.FirstName + " " + $user.LastName
    New-ADUser -Name $username `
        -DisplayName $displayname `
        -GivenName $user.FirstName `
        -Surname $user.LastName `
        -Department $user.Department `
        -Title $user.Role `
        -UserPrincipalName $upname `
        -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -force) -Enabled $true
    if(!$?){
        Get-ADUser $username | Out-Null
        if($?){
            Write-Output "Kasutaja $username juba eksisteerib"
        }
    }
    else {
        Write-Output "Loodi kasutaja $username"
    }
}

$ErrorActionPreference = 'Stop'
