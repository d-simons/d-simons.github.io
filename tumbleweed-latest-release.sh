#!/bin/bash

POST_URL="$(rsstail -HN1lru "https://lists.opensuse.org/opensuse-factory/mailinglist.rss" | grep -m1 -A1 '\[opensuse-factory] New Tumbleweed snapshot' | cut -f2- -d' ' | tail -n 1)"

NEW_POST_DATE="$(curl -sL "https://lists.opensuse.org/opensuse-factory/$(date +%Y)-$(date +%m)/$POST_URL" \
| grep -A1 -m1 'Date</span>:' | cut -f2- -d' ' | cut -f1 -d'<' | tail -n -1)"

if [ -f "$HOME/.cache/tumbleweed-latest-release" ]; then
    POST_DATE="$(cat ~/.cache/tumbleweed-latest-release | head -n 1)"
else
    POST_DATE="null"
fi

if [ ! -z "$NEW_POST_DATE" ] && [ ! "$NEW_POST_DATE" = "$POST_DATE" ]; then
    POST_TITLE="$(rsstail -HN1lru "https://lists.opensuse.org/opensuse-factory/mailinglist.rss" | grep -m1 '\[opensuse-factory] New Tumbleweed snapshot' | cut -f2- -d' ')"
    POST_CONTENTS="$(curl -sL "https://lists.opensuse.org/opensuse-factory/$(date +%Y)-$(date +%m)/$POST_URL" \
    | awk '/Packages changed:/,/=== Details ===/' | sed 's%<.*>%%g;s%  %%' | head -n -1)"
    echo "$NEW_POST_DATE" > ~/.cache/tumbleweed-latest-release
    echo "$POST_TITLE" >> ~/.cache/tumbleweed-latest-release
    echo "https://lists.opensuse.org/opensuse-factory/$(date +%Y)-$(date +%m)/$POST_URL" >> ~/.cache/tumbleweed-latest-release
    echo "$POST_CONTENTS" >> ~/.cache/tumbleweed-latest-release
    # POST_CONTENTS="$(cat ~/.cache/tumbleweed-latest-release | tail -n +4 | tr '\n' '@' | sed 's%@  %\\n%g')"
    cat ~/.cache/tumbleweed-latest-release
cat > ~/.cache/tumbleweed-feed-new.xml << EOL
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
<channel>
<title>Tumbleweed Releases</title>
<link>https://www.simonizor.net/tumbleweed/</link>
<description>Release information for openSUSE Tumbleweed</description>
<item>
<title>$POST_TITLE</title>
<link>https://lists.opensuse.org/opensuse-factory/$(date +%Y)-$(date +%m)/$POST_URL</link>
<guid>https://lists.opensuse.org/opensuse-factory/$(date +%Y)-$(date +%m)/$POST_URL</guid>
<pubDate>$NEW_POST_DATE</pubDate>
<description>
$POST_CONTENTS
</description>
</item>
EOL
    if [ -f "$HOME/.cache/tumbleweed-feed.xml" ]; then
        echo "$(cat ~/.cache/tumbleweed-feed.xml | tail -n +6)" >> ~/.cache/tumbleweed-feed-new.xml
        mv ~/.cache/tumbleweed-feed-new.xml ~/.cache/tumbleweed-feed.xml
    else
        echo -e "</channel>\n</rss>" >> ~/.cache/tumbleweed-feed-new.xml
        mv ~/.cache/tumbleweed-feed-new.xml ~/.cache/tumbleweed-feed.xml
    fi
fi
