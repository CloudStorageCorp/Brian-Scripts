$loginCreds = Get-Credential
$apiaccuser = $loginCreds.UserName
$apiaccpass = $loginCreds.Password

$loginBody = @{
  email = $apiaccuser
  password = $apiaccpass
  device_name = "GPUsoft"
} | ConvertTo-Json


$loginResponse = Invoke-RestMethod `
    -Uri "https://tlfront.cshays.us/api/v1/diskInfoUserLogin" `
    -Method Post `
    -Body $loginBody `
    -ContentType "application/json"


$loginResponse | Format-List *

$token = $loginResponse.token #may need to adjust to accesstoken or whatever its called