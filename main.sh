#!/bin.bash
# 
# This is a script that installs and configures bluetooth software on Linux Arch.
# 

#
# Install all the base required software
#
echo "Initializing packages to install..."
pacman -S bluez                     # BlueZ provides the bluetooth protocol in linux
pacman -S bluez-utils               # This provides the ```bluetoothctl``` terminal interface for bluetooth fucntionality
pacman -S bluez-obex                # bluez-obex adds file transfer functionality using bluetooth
pacman -S bluez-firmware            # add additional firmware for various bluetooth devices
pacman -S blueman                   # Blueman provides a GUI interface for bluetooth functionality
echo -e "The following has been installed on your device: \nbluez \nbluez-utils \nbluez-obex \nbluez-firmware \nblueman"



#
# Configure bluetooth functionality
# 
echo "Initializing base configuration..."
echo "Loading the bluetooth driver (btusb)..."
modprobe btusb                      # Load the btusb kernel module. This will be the bluetooth driver.

echo "Starting and enabling the bluetooth service..."
systemctl start bluetooth.service  
systemctl enable bluetooth.service



# 
# Add additional packages and configurations
# 


# Add explicit support for dualsense controllers
echo "Implementing additional configurations and packages..."
echo "Installing support for Dual Sense controllers..."
pacman -S dualsensectl              
# Add udev rules if not already present
if ! test -f /etc/udev/rules.d/70-dualsensectl.rules; then 
    echo "creating file /etc/udev/rules.d/70-dualsensectl.rules"
    touch /etc/udev/rules.d/70-dualsensectl.rules
    echo '# PS5 DualSense controller over USB hidraw
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0660", TAG+="uaccess"

    # PS5 DualSense controller over bluetooth hidraw
    KERNEL=="hidraw*", KERNELS=="*054C:0CE6*", MODE="0660", TAG+="uaccess"

    # PS5 DualSense Edge controller over USB hidraw
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0df2", MODE="0660", TAG+="uaccess"

    # PS5 DualSense Edge controller over bluetooth hidraw
    KERNEL=="hidraw*", KERNELS=="*054C:0DF2*", MODE="0660", TAG+="uaccess"' >> /etc/udev/rules.d/70-dualsensectl.rules
    udevadm trigger                     # refresh udev rules without rebooting
fi





