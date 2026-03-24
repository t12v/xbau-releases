#!/usr/bin/env bash

function normalize() {
    dir=$1

    # Skip if directory doesn't exist
    [ ! -d "$dir" ] && { echo "Directory $dir does not exist, skipping."; return; }

    for oldname in "$dir"/*; do
        [ -f "$oldname" ] || continue

        # Skip non-XML files (e.g. ZIP downloads that should not be renamed)
        [[ "$oldname" != *.xml ]] && { echo "Skipping non-XML file $oldname"; continue; }

        newname="$(xq -q 'Identification > CanonicalVersionUri' "$oldname")"
        [ -z "$newname" ] && { echo "No CanonicalVersionUri for $oldname, skipping."; continue; }
        newname="$newname.xml"

        newpath="$dir/$newname"
        mv -v -- "$oldname" "$newpath"

        base_name=$(basename "$newpath")
        echo "\"$base_name\","
    done
}

while IFS= read -r dir; do
    # remove trailing spaces
    dir="${dir%"${dir##*[![:space:]]}"}"
    normalize "$dir"
done < <(find artifacts -type d -name "codelists")