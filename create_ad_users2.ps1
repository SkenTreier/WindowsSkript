$title = "Kasutaja loomine Active Directorys"
$host.ui.RawUI.WindowTitle = $title 
Import-Module ActiveDirectory -EA stop

$firstname = (Read-Host -Prompt "Sisesta oma eesnimi")
$lastname = (Read-Host -Prompt "Sisesta oma perenimi")
$fullname = $firstname.ToLower() + $lastname.ToLower()
$i = 1
$login = $firstname.ToLower() + $lastname.ToLower()
$OU = "$OU=Users,DC=sv-kool,DC=local"
$domain = "sv-kool.local"
DO
{
If ($(Get-ADUser -Filter {SamAccountName -eq $login})) {
        Write-Host "Hoiatus: Kasutaja" $login.toUpper() "juba eksisteerib!" -ForegroundColor:Green
        $i++
        $login = $firstname.Substring(0,$i) + $lastname
        Write-Host
        Write-Host
        Write-Host "Muudan nime" $login.ToUpper() -ForegroundColor:Green
        Write-Host
        $taken = true
    } else {
    $taken = $false
    }
} Until ($taken -eq $false)
$login = $login.ToLower()

$password = (Read-Host -Prompt "Sisesta oma parool" -AsSecureString)

New-ADUser -Name $fullname -GivenName $firstname -Surname $lastname -DisplayName $fullname -SamAccountName $login -UserPrincipalName $login@$domain -AccountPassword $password -Enabled $true -Path $OU 
