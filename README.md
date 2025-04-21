# rr-tools


To run the script via SSH or task scheduler

1. Forcefully install SurveillanceVideoExtension in a fake serial number environment
    ```bash
    curl -fsSL https://raw.githubusercontent.com/rrorg/rr-tools/main/installsve -o /root/installsve && chmod +x /root/installsve && /root/installsve
    ```

2. Cracking the 'Default License' for Surveillance-Station is 60 number (From: https://github.com/ohyeah521/Surveillance-Station)
    ```bash
    curl -fsSL https://github.com/ohyeah521/Surveillance-Station/raw/main/activated.sh | bash
    ```

3. Cracking the 'Default User Limit' for MailPlus-Server is 256 number (From: https://github.com/ohyeah521/MailPlus-Server)
    ```bash
    curl -fsSL https://github.com/ohyeah521/MailPlus-Server/raw/main/activated.sh | bash
    ```

4. Cracking the 'Default Limit' for Virtual Machine Manager (From: https://github.com/ohyeah521/vmm_no_limit)
    ```bash
    curl -fsSL https://github.com/ohyeah521/vmm_no_limit/raw/main/activated.sh | bash
    ```

5. Activate the Synology AI Console, Synology Drive Server, Active Backup for Business, Active Backup for Microsoft 365, Active Backup for Google Workspace
    ```bash
    ```

6. Forcibly create a storage pool on a disk type that DSM does not support (e.g., Hyper-V virtual disks)
    ```bash
    curl -fsSL https://raw.githubusercontent.com/rrorg/rr-tools/main/forcemount -o /root/forcemount && chmod +x /root/forcemount
    /root/forcemount --createpool --auto      # Create a new pool
    /root/forcemount --install --md /dev/md2  # install the tool, automatically mounts the pool on system startup
    ```
