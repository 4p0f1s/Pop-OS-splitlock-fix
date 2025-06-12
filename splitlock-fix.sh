#!/bin/bash

# splitlock-fix.sh — Manage split_lock_detect kernel option in Pop!_OS with systemd-boot

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root. Try: sudo $0"
  exit 1
fi

# Detect current kernel version
KERNEL_VERSION=$(uname -r)
echo "Detected kernel version: $KERNEL_VERSION"

# Check if kernelstub is available
if ! command -v kernelstub &> /dev/null; then
  echo "Error: kernelstub is not installed. This script is intended for Pop!_OS with systemd-boot."
  exit 1
fi

# Read current kernel command line
CURRENT_CMDLINE=$(cat /proc/cmdline)

if echo "$CURRENT_CMDLINE" | grep -q "split_lock_detect=off"; then
  echo "The 'split_lock_detect=off' option is already enabled."

  # Ask if user wants to remove it
  read -rp "Do you want to re-enable split lock detection (remove the fix)? [y/N]: " REVERT
  if [[ "$REVERT" =~ ^[Yy]$ ]]; then
    echo "Removing split lock fix..."
    kernelstub --remove-options "split_lock_detect=off"
    echo "Option removed. Please reboot your system to apply changes."
  else
    echo "No changes were made."
  fi
else
  echo "Split lock detection is currently enabled."

  # Ask if user wants to apply the fix
  read -rp "Do you want to disable split lock detection now (apply the fix)? [y/N]: " APPLY
  if [[ "$APPLY" =~ ^[Yy]$ ]]; then
    echo "Applying split lock fix..."
    kernelstub --add-options "split_lock_detect=off"
    echo "Fix applied. Please reboot your system to take effect."
  else
    echo "No changes were made."
  fi
fi

exit 0
