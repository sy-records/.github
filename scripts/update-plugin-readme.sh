#!/bin/bash

# Define variables
testedWpVersion=$WP_TESTED_VERSION
requireWpVersion=$WP_REQUIRE_VERSION
phpVersion=$PHP_VERSION

# Define text patterns
testedWpVersionTxt="Tested up to:"
requireWpVersionTxt="Requires at least:"
phpVersionTxt="Requires PHP:"

# Check if variables are set
if [ -z "$testedWpVersion" ]; then
    echo "WP_TESTED_VERSION is not set"
fi

if [ -z "$requireWpVersion" ]; then
    echo "WP_REQUIRE_VERSION is not set"
fi

if [ -z "$phpVersion" ]; then
    echo "PHP_VERSION is not set"
fi

# Define readme file path
readmeFile=$(pwd)/readme.txt

# Read the content of the readme file
content=$(<"$readmeFile")

# Function to update version in readme file
update_version() {
    local version=$1
    local versionTxt=$2
    local versionLabel=$3

    if [ -n "$version" ]; then
        pattern="${versionTxt}[[:space:]]*([0-9.]+)"
        if [[ $content =~ $pattern ]]; then
            oldVersion="${BASH_REMATCH[1]}"
            if [ -n "$oldVersion" ]; then
                echo "Now ${versionLabel} version is: $oldVersion"
                echo "Change ${versionLabel} version to: $version"
                content=$(echo "$content" | sed -E "s/${versionTxt}[[:space:]]*[0-9.]+/${versionTxt} $version/")
                echo "$content" > "$readmeFile"
            fi
        fi
    fi
}

# Update Tested WordPress version
update_version "$testedWpVersion" "$testedWpVersionTxt" "Tested WordPress"

# Update Requires WordPress version
update_version "$requireWpVersion" "$requireWpVersionTxt" "Require WordPress"

# Update PHP version
update_version "$phpVersion" "$phpVersionTxt" "PHP"
