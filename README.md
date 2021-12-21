# AdminUtils

Different tools to gather data when working in a windows / linux environement


### Developed with : 
* [Python](https://www.python.org/)
* [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.2)

### Usage :

 CheckADConnection :
 
 This script check if a computer's list is in AD and generates a results file with Found in AD / Not Found in AD
 
  - Fill the servers.txt with one server per line, preferably with hostnames, IP hasn't been tested, so I don't know if it works
  - Run the powershell script, it will check if RSAT is present on your system, and downloads it if it's not
  - Enter your Active Directory Admin credentials
  - Open the generated file to view results

 CheckPing :
 
 This script check if a computer's list is pingable and generates a results file with Ping is ON / Ping is OFF
  
  - Fill the servers.txt with one server per line, should work with both hostnames and IPs
  - Run the powershell script
  - Open the generated file to view results

 CheckRDP :
 
 This script check if a computer's list has RDP port (TCP 3389) open and generates a results file with RDP is ON / RDP is OFF
 
  - Fill the servers.txt with one server per line, should work with both hostnames and IPs
  - Run the powershell script
  - Open the generated file to view results

 SSLScanTxtToCsv :
 
 This script is specific to the SSLScan module used during pentests, it transforms the output of the command `sslscan --starttls-ftp <IP>:21 > results.txt` to a csv
 
  - Fill the ip_FTP file with one server per line, preferably IPs
  - Run the bash script
  - Open the generated file to view results
