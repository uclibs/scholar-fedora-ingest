#!/bin/sh

# This script ingests files from the command line into Fedora content datastreams

FILE_PID=$1
FILE_NAME=$2
MIME_TYPE=$3
FEDORA_USER=$4
FEDORA_PASSWORD=$5

# You probably don't want to change the following options
CURL_PATH="/usr/bin/curl"
FEDORA_URL="http://localhost:8080/fedora"
FORMAT_URI=""
CHECKSUM_TYPE="SHA-256"
ALT_IDS=""
CONTROL_GROUP="M"
VERSIONABLE="true"
DS_STATE="A"
FLASH="true"
#RIGHTS_FILE="rightsMetadata.xml"

printf "\n\nDeleteing the existing content datatream...\n"
$CURL_PATH -i -XDELETE "$FEDORA_URL/objects/$FILE_PID/datastreams/content" -u $FEDORA_USER:$FEDORA_PASSWORD

# Create the rightsMetadata
#$CURL_PATH -i -H -XPOST -F file="@$RIGHTS_FILE" -u $FEDORA_USER:$FEDORA_PASSWORD "$FEDORA_URL/objects/$FILE_PID/datastreams/rightsMetadata?dsLabel=&formatURI=&checksumType=&altIDs=&mimeType=text/xml&controlGroup=M&versionable=true&dsState=A&flash=$FLASH"

printf "\n\nCreating new content datastream and uploading file...\n"
$CURL_PATH -i -H -XPOST -F file="@$FILE_NAME" -u $FEDORA_USER:$FEDORA_PASSWORD "$FEDORA_URL/objects/$FILE_PID/datastreams/content?dsLabel=$FILE_NAME&formatURI=$FORMAT_URI&checksumType=$CHECKSUM_TYPE&altIDs=$ALT_IDS&mimeType=$MIME_TYPE&controlGroup=$CONTROL_GROUP&versionable=$VERSIONABLE&dsState=$DS_STATE&flash=$FLASH"

printf "\n\nNext steps in rails console on the web server:"
printf "\n  file = GenericFile.find('$FILE_PID')"
printf "\n  file.owner = 'someone@example.com'"
printf "\n  file.save"
printf "\n  file.to_solr"
printf "\n  Sufia.queue.push(CharacterizeJob.new('$FILE_PID'))\n"
