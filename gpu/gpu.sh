#!/bin/bash
#
# This is a script that detects the gpu of the computer and 
# installs and configures the appropriate graphisc drivers and software.
#

#
# Define driver installation and set up for each
# gpu brand
#
AMD () {
    echo "Installing AMD drivers...
    # pacman -S amdgpu
    pacman -S mesa
    pacman -S lib32-mesa                        # Ensure multilib is enabled
    pacman -S xf86-video-amdgpu
    pacman -S vulkan-radeon
    pacman -S lib32-vulkan-radeon
}

INTEL () {
    if [[ ! -z $1 ]]
    then
        echo "Please include the appropriate category of your card"
    else
        echo "Installing Intel drivers..."
    fi
}




# 
# Detect the gpu present - TODO
# 

