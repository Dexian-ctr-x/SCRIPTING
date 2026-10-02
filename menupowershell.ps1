#Importamos los comandos necesarios
Import-Module ActiveDirectory
#Dominio
$dominio = (Get-ADDomain).DistinguishedName

#1. Vistazo del menu
do {
        Clear-Host
        #1)Mostrar menu
        Write-Host " Menu Active Directory"
        Write-Host "1.Información del dominio"
        Write-Host "2. Crear OU"
        Write-Host "3. Crear grupo"
        Write-Host "4. Crear usuario"
        Write-Host "5. Salir"

        #2. Elegir una opción
        $option = Read-Host "Elige una opción"

        #3 Según la opción, rellenar

        switch ($option) {

       #Opción 1

       "1" { Write-Host "Nombre del equipo : $env:COMPUTERNAME"
             Write-Host "Nombre del dominio : $dominio"
             Write-Host "Número de OUs : (Get-ADOrganizationalUnit -Filter *)"
             Write-Host "Número de grupos : (Get-ADGroup -Filter *)"
             Write-Host "Número de usuarios : (Get-ADUser -Filter *)"
             Read-Host "Pulsa ENTER para continuar"

             }
        #Opción 2
 
        "2" {
                $ou = Read-Host "Nombre de la Unidad Organizativa"
                New-ADOrganizationalUnit -Name $ou
                Write-Host "La UO ha sido creada correctamente"
                Read-Host "Pulsa ENTER para continuar"
            }

        #Opción 3

        "3"{
		    $grupos = Read-Host "Nombre del grupo"
		    $ou = Read-Host "Nombre de la Unidad Organizativa"
		    $ruta = "OU=$ou,$dominio"
                    New-ADOrganizationalUnit -Name $ou
                    Write-Host "El grupo ha sido creado correctamente"
                    Read-Host "Pulsa ENTER para continuar"  
        }

	#Opción 4

	"4" {
		    $nombre =  Read-Host "Introduzca el nombre"
		    $apellido =  Read-Host "Introduzca el apellido"
		    $login = Read-Host "Nombre de inicio de sesión (ej. alopez)"
                    $ou = Read-Host "Nombre de la Unidad Organizativa"
                    $grupos = Read-Host "Nombre de la Unidad Organizativa"
                    $clave = Read-Host "Contraseña inicial" -AsSecureString
                    $ruta = "OU=$ou,$dominio"
                    New-ADUser -Name "$nombre $apellido"  -GivenName $nombre -Surname $apellido -SamAccountName $login -UserPrincipalName "$login@$dnsDom"  -Path $ruta -AccountPassword $clave -Enabled $true -ChangePasswordAtLogon $true
                    Add-ADGroupMember -Identity $grupos -Members $login
                    Write-Host "Usuario $login creado y añadido al grupo $grupos"
                    Read-Host "Pulsa ENTER para continuar"   	
	    }
	 #  OPCIÓN 5
        "5" {
           	 Write-Host "Adiós"
                 exit
       	    }
 	
        # Cualquier otra cosa 
        default {
          	  Write-Host "Opción no válida"
           	 Read-Host "Pulsa ENTER para continuar"

       		}

        }
}
# 4 Repetir mientras no sea  la opción 5
while ($opcion -ne "5")