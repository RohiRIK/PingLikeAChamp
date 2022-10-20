param($L,$E)
if ($L -eq $null -Or $E -eq $null)
    {
    echo "Pleas insert the Parmeter fo the scripts 
    -L for Choosing List fo Devices
    -E for Coosing the name of the file to export
    Pleas insert the Full Path"
    }

else
    {
    $answer= Read-Host "This script will send pings to any devices that found in the list and will export the running devices into to CSV file.
    do you wish to proceed? Yes/No" 
    Start-Sleep -seconds 0.8

    echo "Made by ROHI RIKMAN for lernning Propose, heve FUN troubleshooting"
    Start-Sleep -seconds 1


    if ($answer -eq "Yes")
        {
    
        #$Path= Read-Host "Pleas insert the full name and Path of the file with the devices list"
        $L =$L.Replace("""","")
        $devices = Get-Content -Path $L

        #$exportfile = Read-Host "How do you wont to call the exported file?"
        Add-Content -Path "$E.csv" -Value '"Host-name","IP-address"'

        for ($i = 1; $i -le 100; $i++ ) 
            {
                Write-Progress -Activity "Start PINGING, Pleas wait for loading the Csv file" -Status "$i% Complete:" -PercentComplete $i
                Start-Sleep -Milliseconds 15
            }

        $list=@()
            foreach ($device in $devices)
                {
                if (Test-Connection  $device -Count 1 -ErrorAction SilentlyContinue)
                {
                    $ping = ping -4 $device
                    $ip = $ping.Item(2)
                    $ip = $ip.Substring(11,11)
                    $list+=("$device,$ip")
                    #$list | Add-Content -Path "$E.csv" 
                    #$devices,$ip | Add-Content -Path "$E.csv" 
                    Write-Host "Append $device to CSV..." -ForegroundColor Green
                }
            else
                {
                    Write-Host "The $device is down so no Append to CSV" -ForegroundColor Red
                }
                }
        }
    else
    {
    echo "have a nice day"
    }
    $list | Add-Content -Path "$E.csv"
    }
