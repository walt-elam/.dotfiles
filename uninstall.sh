#!/bin/bash
#
# Uninstall configuration files via symlinks
################################################################################

if [[ -z "${DF_SAVE}" ]]; then
    echo "[!] No dotfile save directory specified in \$DF_SAVE"
    exit 1
fi

if [[ -z "${DF_DIR}" ]]; then
    echo "[!] No dotfile directory specified in \$DF_DIR"
    exit 2
fi

cd ~ > /dev/null

for item in `ls -Ad "${DF_DIR}"/.[^.]* | grep -v ".git\(ignore\)\?$"`; do
    bn=`basename "${item}"`

    if [[ -h "${bn}" ]]; then
    	unlink "${bn}"
    fi

    # Restore original if it exists
    if [[ -f "${DF_SAVE}/${bn}" ]]; then
        mv "${DF_SAVE}/${bn}" .
    fi
done

cd - > /dev/null

