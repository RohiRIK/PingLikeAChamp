$answer= Read-Host "This script will send pings to any devices that found in the list and will export the running devices into to CSV file.
 do you wish to proceed? Yes/No" 
Start-Sleep -seconds 0.8

echo "Made by ROHI RIKMAN for lernning Propose, heve FUN troubleshooting"
Start-Sleep -seconds 1


if ($answer -eq "Yes")
    {
    $Path= Read-Host "Pleas insert the full name and Path of the file with the devices list"
    $Path =$Path.Replace("""","")
    $devicess = Get-Content -Path $Path

    $exportfile = Read-Host "How do you wont to call the exported file?"
    Add-Content -Path "$exportfile.csv" -Value '"Host-name","IP-address"'

    ### Funny loding 
    for ($i = 1; $i -le 100; $i++ ) 
        {
            Write-Progress -Activity "Start PINGING, Pleas wait for loding the Csv file" -Status "$i% Complete:" -PercentComplete $i
            Start-Sleep -Milliseconds 15
        }

    $list=@()
     foreach ($devices in $devicess)
         {
         if (Test-Connection  $devices -Count 1 -ErrorAction SilentlyContinue)
            {
                $ping = ping -4 $devices
                $ip = $ping.Item(2)
                $ip = $ip.Substring(11,11)
                $list+=("$devices,$ip")
                $list | Add-Content -Path "$exportfile.csv" 
                Write-Host "Append $devices to CSV..." -ForegroundColor Green
            }
        else
            {
                Write-Host "The $devices is down so no Append to CSV" -ForegroundColor Red
            }
         }
    }
else
{
echo "have a nice day"
}