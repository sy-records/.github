#!/bin/bash

testedWpVersion=$WP_TESTED_VERSION
requireWpVersion=$WP_REQUIRE_VERSION
phpVersion=$PHP_VERSION

testedWpVersionTxt="Tested up to:"
requireWpVersionTxt="Requires at least:"
phpVersionTxt="Requires PHP:"

if [ -z "$testedWpVersion" ]; then
    echo "WP_TESTED_VERSION is not set"
fi

if [ -z "$requireWpVersion" ]; then
    echo "WP_REQUIRE_VERSION is not set"
fi

readmeFile=$(pwd)/readme.txt
content=$(cat "$readmeFile")

if [ -n "$testedWpVersion" ]; then
    pattern="${testedWpVersionTxt}[[:space:]]*([0-9.]+)"
    if [[ $content =~ $pattern ]]; then
        oldWPVersion="${BASH_REMATCH[1]}"
        if [ -n "$oldWPVersion" ]; then
            echo "Now Tested WordPress version is: $oldWPVersion"
            echo "Change Tested WordPress version to: $testedWpVersion"
            content=$(echo "$content" | sed -E "s/${testedWpVersionTxt}[[:space:]]*[0-9.]+/${testedWpVersionTxt} $testedWpVersion/")
            echo "$content" > "$readmeFile"
        fi
    fi
fi

if [ -n "$requireWpVersion" ]; then
    pattern="${requireWpVersionTxt}[[:space:]]*([0-9.]+)"
    if [[ $content =~ $pattern ]]; then
        oldRequireWPVersion="${BASH_REMATCH[1]}"
        if [ -n "$oldRequireWPVersion" ]; then
            echo "Now Require WordPress version is: $oldRequireWPVersion"
            echo "Change Require WordPress version to: $requireWpVersion"
            content=$(echo "$content" | sed -E "s/${requireWpVersionTxt}[[:space:]]*[0-9.]+/${requireWpVersionTxt} $requireWpVersion/")
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
