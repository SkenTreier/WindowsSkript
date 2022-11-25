$firstname = (Read-Host -Prompt "Sisesta oma eesnimi")
$lastname = (Read-Host -Prompt "Sisesta oma perenimi")
$User = $firstname.ToLower() + "." + $lastname.ToLower()
$Password = (Read-Host -Prompt "Sisesta oma parool" -AsSecureString)

$Usercreate = Get-LocalUser | where-Object Name -eq "$firstname"
if ($Usercreate.Count -eq 0) {
     New-LocalUser  -Name "$firstname" -Password $Password -FullName "$User"
     echo "Loodav kasutaja on $User!"
} else {
     Write-Output "Tekkinud probleem kasutaja $User loomisega"
}
