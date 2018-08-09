#!/bin/sh

# curl -X GET --header 'Accept: application/json' 'http://nexus:8081/service/rest/beta/assets?continuationToken=c770169csdfe3ed86d4e4c48e1d05f17&repository=Snapshots' > build2

NEXUS_URL="http://nexus:8081"
CONTINUATION_TOKEN=c770169c0b2e3ed86d4e4c48e1d0sdjf7
REPOSITORY=Snapshots
REST_URL="service/rest/beta/assets?repository=$REPOSITORY"
CT_REST_URL="service/rest/beta/assets?continuationToken=$CONTINUATION_TOKEN&repository=$REPOSITORY"

# From URL
URL="$NEXUS_URL/$REST_URL"
CT_URL="$NEXUS_URL/$CT_REST_URL"

echo $URL
echo $CT_URL


artifacts()
{

 curl -X GET --header 'Accept: application/json' $URL > artifactsjson
 jq '.items | .[].downloadUrl ' artifactsjson | sed 's/"//g' > uris
 cat uris

}


if [ -z "$CONTINUATION_TOKEN" ]
then

  URL=$URL
  artifacts

else

  URL=$CT_URL
  artifacts

fi
