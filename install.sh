#!/bin/bash
#
# Install configuration files via symlinks
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

if [[ ! -d "${DF_SAVE}" ]]; then
	mkdir "${DF_SAVE}"
fi

for item in `ls -ad "${DF_DIR}"/.[^.]* | grep -v ".git$"`; do
    bn=`basename "${item}"`
    # Save original if it already exists
    if [[ -e "${bn}" && -h "${bn}" ]]; then
        mv -f "${bn}" "${DF_SAVE}/"
    fi

    ln -s "${DF_DIR}/${bn}" "${bn}"
done

cd - > /dev/null
