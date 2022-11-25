$firstname = (Read-Host -Prompt "Sisesta oma eesnimi")
$lastname = (Read-Host -Prompt "Sisesta oma perenimi")
$User = $firstname.ToLower() + "." + $lastname.ToLower()

if (Get-LocalUser | Where-Object -Property Name -EQ $firstname ) {
    Remove-LocalUser -Name $firstname
    Write-Output "Kustutav kasutaja $User on kustutatud"
}
  else {
    Write-Host "Tekkinud probleem $User kustutamisega"
}
