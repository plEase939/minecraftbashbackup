# How to use this script?

## Requirements
1. zip
2. curl

This was a purpose made script for a simple procedure to automatically stop and take backup of your minecraft folder and then start server again

This script takes some assumptions such as you are running your minecraft server using screen so that is given. 

## Steps to use this script
1. You may choose to save this script anywhere, i personally saved this in my home/user/script
2. Make sure you are the owner of the file  : (sudo) chown user:group mcbk.sh
3. Give execute permission to the file      : sudo chmod u+x mcbk.sh
4. manually run : bash mcbk.sh or setup a cronjob

## Algorithm
1. Script sends warning message from 30 seconds and countdowns from there
2. Script sends /stop command to the console
3. Script terminates your current screen instance
4. Your Minecraft server files are moved to a different folder and works on that for backup
5. server.jar is removed as this can be obtained easily from minecraft website for the specific version and it increases the backup size which has no need
6. Your files are then zipped and moved to a backup folder
7. Script then deletes the data in the temporary folder from which the backup was zipped
8. Script starts a new screen session and then changes directory to your minecraft server folder and sends the java start command
9. Discord Webhook text message is sent to notify on your choice of channel.
