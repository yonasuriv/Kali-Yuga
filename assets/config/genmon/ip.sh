#!/bin/sh

# Get the first tuntap interface name
interface="$(ip tuntap show | cut -d : -f1 | head -n 1)"

# Initialize the ip variable to an empty string
ip=""

# If an interface is found, get its IP address
if [ -n "${interface}" ]; then
  ip="$(ip a s "${interface}" 2>/dev/null | grep -o -P '(?<=inet )[0-9]{1,3}(\.[0-9]{1,3}){3}')"
fi

# Display the VPN icon
printf "<icon>network-vpn-symbolic</icon>"

# Always print the IP address (or a default message if not found)
if [ -n "${ip}" ]; then
  printf "<txt>${ip}</txt>"
else
  printf "<txt>No IP found</txt>"
fi

# Add clipboard functionality if xclip is available
if command -v xclip > /dev/null; then
  if [ -n "${ip}" ]; then
    printf "<iconclick>sh -c 'printf ${ip} | xclip -selection clipboard'</iconclick>"
    printf "<txtclick>sh -c 'printf ${ip} | xclip -selection clipboard'</txtclick>"
    printf "<tool>VPN IP (click to copy)</tool>"
  else
    printf "<tool>No IP found</tool>"
  fi
else
  printf "<tool>Install xclip to copy IP to clipboard</tool>"
fi
