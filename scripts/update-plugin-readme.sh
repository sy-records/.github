#!/bin/bash

wpVersion=$WP_VERSION
phpVersion=$PHP_VERSION

wpVersionTxt="Tested up to:"
phpVersionTxt="Requires PHP:"

if [ -z "$wpVersion" ]; then
    echo "WP_VERSION is not set"
fi

readmeFile=$(pwd)/readme.txt
content=$(cat "$readmeFile")

if [ -n "$wpVersion" ]; then
    pattern="${wpVersionTxt}[[:space:]]*([0-9.]+)"
    if [[ $content =~ $pattern ]]; then
        oldWPVersion="${BASH_REMATCH[1]}"
        if [ -n "$oldWPVersion" ]; then
            echo "Now WordPress version is: $oldWPVersion"
            echo "Change WordPress version to: $wpVersion"
            content=$(echo "$content" | sed -E "s/${wpVersionTxt}[[:space:]]*[0-9.]+/${wpVersionTxt} $wpVersion/")
            echo "$content" > "$readmeFile"
        fi
    fi
fi

if [ -z "$phpVersion" ]; then
    echo "PHP_VERSION is not set"
    exit 0
fi

if [ -n "$phpVersion" ]; then
    pattern="${phpVersionTxt}[[:space:]]*([0-9.]+)"
    if [[ $content =~ $pattern ]]; then
        oldPhpVersion="${BASH_REMATCH[1]}"
        if [ -n "$oldPhpVersion" ]; then
            echo "Now PHP version is: $oldPhpVersion"
            echo "Change PHP version to: $phpVersion"
            content=$(echo "$content" | sed -E "s/${phpVersionTxt}[[:space:]]*[0-9.]+/${phpVersionTxt} $phpVersion/")
            echo "$content" > "$readmeFile"
        fi
    fi
fi
