function Disable-ADUser {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)][string[]]$Identity,
        [Parameter(Mandatory = $true)][string]$OrganizationalUnit,
        [Parameter(Mandatory = $true)][string]$ActiveDirectoryGroup
    )
            
    Try {
        # Harvesting information about the AD Object.
        if ((Get-ADUser -Identity $Identity).Enabled -eq $true) {

            Write-Verbose -Message "Useraccount $Identity will be disabled."
                
            # Disabling AD Object.
            Disabled-ADAccount -Identity $Identity -Confirm $false
            Write-Verbose -Message "Disabled account $Identity." 

            # Moving AD Object to OU.
            Move-ADObject -Identity $Identity -TargetPath $OrganizationalUnit
            Write-Verbose -Message "Moved AD Object $Identity to $OrganizationalUnit." 
                
            # Removing AD Object from AD Group.
            Remove-ADPrincipalGroupMembership -Identity $Identity -MemberOf $ActiveDirectoryGroup
            Write-Verbose -Message "Removed AD Object $Identity from group $ActiveDirectoryGroup."
        }else {
            Write-Warning -Message "The Active Directory User $Identity was already disabled."
        }    
    }Catch {
        Write-Error -Message $_.Exception.Message -ErrorAction Stop
        return
    }
}