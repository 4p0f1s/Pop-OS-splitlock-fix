# Pop-OS-splitlock-fix

A simple utility script for managing the split_lock_detect kernel parameter on Pop!_OS systems using systemd-boot.

## Why?

Some applications and games (especially running under Proton or Wine) may trigger CPU split lock detection traps on newer kernels (e.g., 6.12), causing system freezes or crashes.

This script allows you to safely:

- Disable `split_lock_detect` to improve stability in those cases.
- Re-enable it if needed later.

## Requirements

- Pop!_OS 20.04+ using `systemd-boot` (default for modern installations)
- `kernelstub` installed (it is by default in Pop!_OS)

## Usage

1. Clone the repository or download the script:

   ```bash
   git clone https://github.com/4p0f1s/splitlock-fix.git
   cd splitlock-fix
   ```

2. Make the script executable:

   ```bash
   chmod +x splitlock-fix.sh
   ```
   
3. Run the script with root privileges:

   ```bash
   sudo ./splitlock-fix.sh
   ```
   
The script will:

- Detect if split_lock_detect=off is already applied.
- Ask whether you want to enable or disable the option.
- Apply the change via kernelstub.

## How to Revert

Run the script again. If the fix is active, it will offer to remove it and restore the default kernel behavior.

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/4p0f1s/Pop-OS-splitlock-fix/blob/main/LICENSE) file for details.
