# ps_appx_find_and_remove

Powershell script to find and remove Apps (appx) from 
- user
- allusers
- provisioned in image 

Usage:

-name APP_NAME  : searching for NAME_OF_APP (uses -like )
-allusers       : finds APP_NAME in all user profiles
-provisioned    : finds APP_NAME in win image
                  if found here, new user will get APP_NAME provisioned to his users profile
-remove         : removes APP_NAME from all places found 
