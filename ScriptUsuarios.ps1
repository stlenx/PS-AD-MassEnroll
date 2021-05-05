$path = Read-Host "Gib path of csv"
$csv = Import-Csv $path;
$length = ($csv).count
$percent = 0;

if (!(Get-Module ActiveDirectory)) {
    Import-Module ActiveDirectory
}

$csv | ForEach-Object {
    $username = $_.Nome + $_.Apelido1.substring(0,1) + $_.Apelido2.substring(0,1);
    $pass = "abc123.$($_.Data_nacemento)";

    $AddUserArguments = @{
        Name = $_.Nome + $_.Apelido1 + $_.Apelido2
        SamAccountName = $username
        UserPrincipalName = $username + "@iesbernal.gal"
        GivenName = $_.Nome
        Surname = $_.Apelido1 + $_.Apelido2
        Enabled = $True
        DisplayName = $_.Apelido1 + $_.Apelido2 + "," + $_.Nome
        Path = "OU=$($_.Curso),OU=$($_.Ciclo),OU=Alumnado,OU=Usuarios,OU=IESBERNAL,DC=iesbernal,DC=gal"
        EmailAddress = $username + "@iesbernal.gal"
        AccountPassword = (ConvertTo-SecureString -AsPlainText -Force $pass)
        Description = "Alumno de $($_.Curso)"
        HomeDirectory = "\\DC1\DATOS\ALUM\$($_.Ciclo)\$($_.Curso)"
        HomeDrive = "Y:"
    }

    New-ADUser @AddUserArguments

    Add-ADGroupMember -Identity "G_ALUM_$($_.Curso)" -Members $username

    $percent += (100 / $length)
    Write-Progress -Activity "Created user $username " -Status "$percent% Complete:" -PercentComplete $percent
}