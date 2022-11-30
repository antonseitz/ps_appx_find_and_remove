param (
[string] $name,
[switch] $allusers,
[switch] $provisioned,
[switch] $remove


)


if ($name){
    Write-Output ("Searching ``" + $name +"`` Appx Packages in current USER Profile ...")
    #(Get-AppxPackage $name).ispresent
    if (Get-AppxPackage $name ) {
	    "Found!"
        "See PackageUserInformation for list of Users: "
	    Get-AppxPackage $name | fl
	
	
		# löschen ?
		if ($remove ) {
		
			Get-AppxPackage $name | Remove-AppxPackage
			$name + "removed!"
		} 
		
	
		
		if ($allusers ){
		  Write-Output ("Searching ``" + $name +"`` Appx Packages in ALL USER Profiles ...")
			if(Get-AppxPackage -Name $name -allUsers){
"Found: "
Get-AppxPackage -Name $name -allUsers | fl
	
# AllUsers löschen ?
if ($remove	){

				"Removing " +  $name
				Get-AppxPackage -Name $name  -AllUsers | Remove-AppxPackage -AllUsers -Verbose -ErrorAction Continue
				$name + "removed for allUsers !" }
			}
			else{
				Write-Output $Name  + "App is not installed for any user"
			}
		}
		
		
		
		
		
		
	}
	
	 else{
	"``" + $name + "`` not found"
    }
	
	if($provisioned){
	
	Write-Output ("
Searching ``" + $name +"`` in Appx Packages PROVISIONED in Win Image ...")
    $name_without_sternchen= $name.replace('*','')
	if(Get-ProvisionedAppPackage -online | ? {$_.Displayname -match $name_without_sternchen} ){
	"Found: "
	Get-ProvisionedAppPackage -online | ? {$_.Displayname -match $name_without_sternchen}
	
	if ($remove	){
		
		Get-ProvisionedAppxPackage -Online |Where-Object {$_.DisplayName -Match $name_without_sternchen} | Remove-AppxProvisionedPackage -Online -AllUsers -Verbose -ErrorAction Continue
		$name + "removed in Provisioned Packackes !"
	}
	
	}
    else{
	"``" + $name + "`` not found"
    }
	}

}



# auch in provisioned ?






else {
	
	"nothing given!"
"Usage:

-name APP_NAME  : searching for NAME_OF_APP (uses -like )
-allusers       : finds APP_NAME in all user profiles
-provisioned    : finds APP_NAME in win image
                  if found here, new user will get APP_NAME provisioned to his users profile
-remove         : removes APP_NAME from all places found 

"

}

