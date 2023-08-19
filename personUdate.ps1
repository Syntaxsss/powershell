## POSTMAN CODE SNIPPET
clear
### API call to extract Bearer token
## Endpoing URL's

$urlAuth = "https://integrate.elluciancloud.com/auth"
$urlPers = "https://integrate.elluciancloud.com/api/persons" 
  
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer 5ea6fe5c-2f10-478c-923d-a4ca9554cd1e")

#$headers.Add("Authorization", "Bearer 46198042-52bf-4c3a-94c5-532e6e340f19")

#$response = Invoke-RestMethod 'https://integrate.elluciancloud.com/auth' -Method 'POST' -Headers $headers
$response = Invoke-RestMethod -uri $urlAuth -Method 'POST' -Headers $headers
#$response | ConvertTo-Json
$token = $response



##### using  Bearer token extracted from 1st API Call for Authorization to the API https://integrate.elluciancloud.com/api/persons
   
 #for($i=0; $i -lt 1; $i++) #Get Persons
 #{
    $headers2 = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers2.Add("Authorization", "Bearer $token")
    $headers2.Add('Content-Type', 'application/json')
    $headers2.Add('Accept', 'application/json')

    #$headers2

    $response2 = ''
    $response2 = Invoke-RestMethod 'https://integrate.elluciancloud.com/api/persons' -Method 'GET' -Headers $headers2 
    $response2 = Invoke-RestMethod   -uri $urlPers -Method 'GET' -Headers $headers2 
   #$response2 | ConvertTo-Json -Depth 100
    
     
    
   #for($i=0; $i -lt GUID.count; $i++)
   #{
     
    $GUID = $response2.id   
    $credential = $response2.credentials 
    $username = " "
    $name = $response2.names
    $email = $response2.emails
    $emailType = $response2.emails.type.emailType
   #$GUID.Count
   #$name.Count
   
    $data = $response2 

   #$data

    
    foreach ($item in $data)
    {

         
       $Ids = $item.id
       $Names = $item.names
       $creds = $item.credentials
       $credType = $item.credentials.type
       $credTypeValue = $item.credentials.value
       $emls = $item.emails
       $emlType = $item.emails.type.emailType

       
       for ( $i = 0; $i -lt 3; $i++)
       {
            
          
           #if (($item.credentials.type -eq "bannerUserName") -and ($emlType -ne "school"))
            if (($item.credentials.type[$i] -eq "bannerUserName") -and ($emlType -ne "school"))
               {  
                   #$username=$item.value
                    $username=$item.credentials.value[$i]
                    $BCCCEmail = $username + '@student.bccc.edu' 
                    

                   
                   #build PSObject body section for post method
      
                   $detail=''
                   $detail= @{
                   id=  "28f66a71-d1f8-4c5c-b8f1-27d82c35cb68"
                   }
                   $type=''
                   $type=@{
                   detail=$detail
                   emailType="school"
                   }
                   $email1=''
                   $email1=[ordered]@{
                   address = $BCCCEmail 
                   type = $type 
               }
              
            

               #build complete payload body from above objects
  
      
                  $payload=''
                  $payload =@{          
           
                     id = $Ids
                     names  = $Names
                     emails = $email1      
        
                   }

       
                  $payload1 = $payload | ConvertTo-Json -Depth 100
       
                  $payload1
                   

          }
              
                  
       }   
   
  }
            

   