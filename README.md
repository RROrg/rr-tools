# rr-tools


To run the script via SSH or task scheduler

1. Forcefully install SurveillanceVideoExtension in a fake serial number environment
    ```bash
    curl -fsSL https://raw.githubusercontent.com/rrorg/rr-tools/main/installsve -o /root/installsve && chmod +x /root/installsve && /root/installsve
    ```
2. Cracking the 'Default License' for Surveillance-Station is 60 number (From: https://github.com/ohyeah521/Surveillance-Station)
    ```bash
    curl -fsSL https://raw.githubusercontent.com/ohyeah521/Surveillance-Station/main/activated.sh | bash
    ```


3. Forcibly create a storage pool on a disk type that DSM does not support (e.g., Hyper-V virtual disks)
    ```bash
    curl -fsSL https://raw.githubusercontent.com/rrorg/rr-tools/main/forcemount -o /root/forcemount && chmod +x /root/forcemount
    /root/forcemount --createpool --auto      # Create a new pool
    /root/forcemount --install --md /dev/md2  # install the tool, automatically mounts the pool on system startup
    ```
