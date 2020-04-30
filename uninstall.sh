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

    # Unlink managed files
    if [[ -h "${bn}" && `readlink -f "${bn}"` =~ "${DF_DIR}/${bn}" ]]; then
        unlink "${bn}"
    fi

    # Restore original file if it exists
    if [[ -e "${DF_SAVE}/${bn}" ]]; then
    echo "Restoring ${bn}"
        mv "${DF_SAVE}/${bn}" .
    fi
done

cd - > /dev/null

