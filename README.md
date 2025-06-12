# Pop-OS-splitlock-fix

A simple utility script for managing the split_lock_detect kernel parameter on Pop!_OS systems using systemd-boot.

## Why?

Some applications and games (especially running under Proton or Wine) may trigger CPU split lock detection traps on newer kernels (e.g., 6.12), causing system freezes or crashes.

This script allows you to safely:

- Disable `split_lock_detect` to improve stability in those cases.
- Re-enable it if needed later.

## What does this fix do? 

Modern Linux kernels (5.8+) include a feature called split_lock_detect that traps certain low-level CPU instructions known as split locks. These operations are inefficient and can affect performance on multi-core systems.

Some applications — particularly games running under Proton or Wine — may unintentionally trigger split locks. When this happens, the Linux kernel raises a special exception (#AC trap), which can cause the process to crash or freeze the system entirely if unhandled.

By disabling split_lock_detect, this script prevents the kernel from interrupting such operations. This allows games or other applications to continue running, avoiding system freezes or crashes — at the cost of ignoring a relatively rare performance warning.

This fix is safe for desktop and gaming systems. It is not recommended to disable split lock detection in security-critical or low-level software development environments.

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
