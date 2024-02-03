#!/bin/bash

URL=$1

if [[ -z "$URL" ]]; then
	echo "Enter URL:"
	read URL
fi

curl -s $URL > tmp.html
META=$(xmllint --html --xpath 'string(//meta[@property="og:url"]/@content)' 2>/dev/null tmp.html)
rm tmp.html

if [[ "$META" == '' ]]; then	
	echo "Invalid URL"

else
	echo -e "https://www.youtube.com/feeds/videos.xml?channel_id="${META##*/}
fi
