#!/bin/bash

#
# You can chose the vscode build you want : stable // insider
#
BUILD=insider # Or insider


DESKTOP_FILE=${HOME}/.local/share/applications/com.visualstudio.code.desktop
BUILD_NAME="Visual Studio Code"
EXEC_COMMAND="${HOME}/sgoinfre/opt/code-linux-64/bin/code"
ICON_PATH="${HOME}/sgoinfre/opt/code-linux-64/resources/app/resources/linux/code.png"
WM_BUILD="Code"
COMMAND="code"

curl -L "https://code.visualstudio.com/sha/download?build=${BUILD}&os=linux-x64" --output /tmp/code.tar.gz
mkdir -p ${HOME}/sgoinfre/opt
rm -rf ${HOME}/sgoinfre/opt/code-linux-64/
tar -zxvf /tmp/code.tar.gz --directory ${HOME}/sgoinfre/opt
mv ${HOME}/sgoinfre/opt/VSCode-linux-x64/ ${HOME}/sgoinfre/opt/code-linux-64/

rm -f ${DESKTOP_FILE}

if [[ ! -f ${DESKTOP_FILE} ]]; then
	curl -L "https://raw.githubusercontent.com/arthur-trt/app_42/main/com.visualstudio.code.desktop" --output ${DESKTOP_FILE}
	if [[ ${BUILD} == "insider" ]]; then
		BUILD_NAME="Visual Studio Code Insiders"
		EXEC_COMMAND="${HOME}/sgoinfre/opt/code-linux-64/bin/code-insiders"
		WM_BUILD="Code - Insiders"
		COMMAND="code-insiders"
	fi
	sed -i "s|ICON_PATH|${ICON_PATH}|g" ${DESKTOP_FILE}
	sed -i "s|BUILD_NAME.*|${BUILD_NAME}|g" ${DESKTOP_FILE}
	sed -i "s|EXEC_COMMAND|${EXEC_COMMAND}|g" ${DESKTOP_FILE}
	sed -i "s|WM_BUILD|${WM_BUILD}|g" ${DESKTOP_FILE}

	update-desktop-database ${HOME}/.local/share/applications/
	busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…")'
fi

if ! command -v ${COMMAND} &> /dev/null
then
	echo "export PATH=\$HOME/sgoinfre/opt/code-linux-64/bin:\$PATH" >> ${HOME}/.zshrc
fi
