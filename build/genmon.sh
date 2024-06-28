#!/bin/bash

# Get the current username
USER=$(whoami)

# Define the file path
CPURC="genmon-15.rc"

# Write the content to the file
echo "Command=/home/$USER/.config/genmon/cpu.sh" > $CPURC
echo "UseLabel=0" >> $CPURC
echo "Text=(genmon)" >> $CPURC
echo "UpdatePeriod=1000" >> $CPURC
echo "Font=Roboto 10" >> $CPURC

# Define the file path
DATERC="genmon-16.rc"

# Write the content to the file
echo "Command=/home/$USER/.config/genmon/datetime.sh" > $DATERC
echo "UseLabel=0" >> $DATERC
echo "Text=(genmon)" >> $DATERC
echo "UpdatePeriod=1000" >> $DATERC
echo "Font=Roboto 10" >> $DATERC

# Define the file path
MEMRC="genmon-17.rc"

# Write the content to the file
echo "Command=/home/$USER/.config/genmon/mem.sh" > $MEMRC
echo "UseLabel=0" >> $MEMRC
echo "Text=(genmon)" >> $MEMRC
echo "UpdatePeriod=750" >> $MEMRC
echo "Font=Roboto 10" >> $MEMRC
