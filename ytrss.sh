#!/bin/bash

URL=$1

if [[ -z "$URL" ]]; then
	echo "Enter URL:"
	read URL
fi

curl -s $URL > tmp.html
META=$(xmllint --html --xpath 'string(//meta[@property="og:url"]/@content)' 2>/dev/null tmp.html)
rm tmp.html
URL="https://www.youtube.com/feeds/videos.xml?channel_id="${META##*/}

if [[ "$META" == '' ]]; then	
	echo "Invalid URL"

else
	echo -e $URL

	# copy to clipboard
	if [[ $(dpkg -l | grep qdbus) != '' ]]; then
		qdbus org.kde.klipper /klipper setClipboardContents "$URL"
	
	elif [[ $(dpkg -l | grep xsel) != '' ]]; then
		echo -n $URL | xsel -b
	fi
fi
