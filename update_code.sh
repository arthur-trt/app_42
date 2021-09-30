#!/bin/bash

DESKTOP_FILE=${HOME}/.local/share/applications/com.visualstudio.code.desktop
BUILD=stable # Or insider

BUILD_NAME="Visual Studio Code"
EXEC_COMMAND="${HOME}/code-linux-64/bin/code"
ICON_PATH="${HOME}/code-linux-64/resources/app/resources/linux/code.png"
WM_BUILD="Code"
COMMAND="code"

curl -L "https://code.visualstudio.com/sha/download?build=${BUILD}&os=linux-x64"  --output /tmp/code.tar.gz
tar -zxvf /tmp/code.tar.gz
rm -rf ${HOME}/code-linux-64/
mv ${HOME}/VSCode-linux-x64/ ${HOME}/code-linux-64/
curl -L "https://raw.githubusercontent.com/arthur-trt/vscode_42/main/com.visualstudio.code.desktop" --output ${DESKTOP_FILE}
if [[ ${BUILD} == "insider" ]]; then
	BUILD_NAME="Visual Studio Code Insiders"
	EXEC_COMMAND="${HOME}/code-linux-64/bin/code-insiders"
	WM_BUILD="Code - Insiders"
	COMMAND="code-insiders"
fi
sed -i "s|ICON_PATH|${ICON_PATH}|g" ${DESKTOP_FILE}
sed -i "s|BUILD_NAME.*|${BUILD_NAME}|g" ${DESKTOP_FILE}
sed -i "s|EXEC_COMMAND|${EXEC_COMMAND}|g" ${DESKTOP_FILE}
sed -i "s|WM_BUILD|${WM_BUILD}|g" ${DESKTOP_FILE}

update-desktop-database ${HOME}/.local/share/applications/

if ! command -v ${COMMAND} &> /dev/null
then
    echo "export PATH=\$HOME/code-linux-64/bin:\$PATH" >> ${HOME}/.zshrc
fi
