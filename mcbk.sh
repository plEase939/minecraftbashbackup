# Variables
SERVERDIR="/path/to/your/minecraftserver" 	#changeme
MCSERVERBK="/path/to/your/backup/folder"	#changeme
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUPNAME="mcserver_backup_$TIMESTAMP.zip"
SERVER_COMMAND="java -Xmx20G -Xms20G -jar server.jar nogui" #you may change this as per your ram requirement
SCREEN_NAME="minecraft"				#changeme if required
PROCESSDIR="/path/to/copy/paste/mcfolder/before/backup" #changeme

WEBHOOK_URL="https://discord.com/api/webhooks/<Key>" 	#changeme

# Set your message content
MESSAGE="Backup process initiated $TIMESTAMP"

# Send the message to Discord via webhook
curl -X POST -H "Content-Type: application/json" \
    -d "{\"content\": \"$MESSAGE\"}" \
    $WEBHOOK_URL

#procss
echo "Stopping mc server message sent"
screen -s $SCREEN_NAME -X stuff "say Server is shutting down in 30 seconds for backup..$(printf '\r')"
sleep 10
screen -s $SCREEN_NAME -X stuff "say Server is shutting down in 20 seconds for backup..$(printf '\r')"
sleep 5
screen -s $SCREEN_NAME -X stuff "say Server is shutting down in 15 seconds for backup..$(printf '\r')"
sleep 5
screen -s $SCREEN_NAME -X stuff "say Server is shutting down in 10 seconds for backup..$(printf '\r')"
sleep 5
screen -s $SCREEN_NAME -X stuff "say Server is shutting down in 5 seconds for backup..$(printf '\r')"
sleep 5
screen -s $SCREEN_NAME -X stuff "/stop$(printf '\r')"
sleep 10
SCREEN_NAME="minecraft"

# Set your message content
MESSAGE="Minecraft server stopped and zipping backup"

# Send the message to Discord via webhook
curl -X POST -H "Content-Type: application/json" \
    -d "{\"content\": \"$MESSAGE\"}" \
    $WEBHOOK_URL
screen -s $SCREEN_NAME -X stuff "exit$(printf '\r')"
echo "Creating Backup"
cd "$SERVERDIR"
cp -r * "$PROCESSDIR"
cd "$PROCESSDIR"
rm server.jar
zip -r "$MCSERVERBK/$BACKUPNAME" .
cd
rm -R "$PROCESSDIR"/*

#start server
echo "Starting MC Server"
cd "$SERVERDIR"
SCREEN_NAME="minecraft"
SERVER_COMMAND="java -Xmx20G -Xms20G -jar server.jar nogui"
screen -dmS $SCREEN_NAME $SERVER_COMMAND
echo "Backup complete: $BACKDIR/$BACKUPNAME"

WEBHOOK_URL="https://discord.com/api/webhooks/<Key>"	#changeme
# Set your message content
MESSAGE="Backup completed and stored at $BACKDIR/$BACKUPNAME"

# Send the message to Discord via webhook
curl -X POST -H "Content-Type: application/json" \
    -d "{\"content\": \"$MESSAGE\"}" \
    $WEBHOOK_URL