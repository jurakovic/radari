
# Get current PowerShell Execution Policy and save it to a variable
#originalPolicy=$(powershell.exe -Command 'Get-ExecutionPolicy')

# Change PowerShell Execution Policy to Unrestricted
#if [ ! $originalPolicy = 'Unrestricted' ]; then powershell.exe -Command "Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force"; fi;

# Execute editHosts.ps1 script
powershell.exe -ExecutionPolicy ByPass -File 'publish.ps1'

# Revert back to the original PowerShell Execution Policy
#if [ ! $originalPolicy = 'Unrestricted' ]; then powershell.exe -Command "Set-ExecutionPolicy $originalPolicy -Scope CurrentUser -Force"; fi;

mapfile -t files < <(find ../docs -type f -iwholename "*.html")
for file in "${files[@]}"; do
  sed -i '1s/^\xEF\xBB\xBF//' "$file"
  unix2dos -q "$file"
done
