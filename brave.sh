#!/bin/bash

DESKTOP_FILE=${HOME}/.local/share/applications/brave.desktop
EXEC_COMMAND="${HOME}/sgoinfre/opt/brave/brave-browser"
ICON_PATH="${HOME}/sgoinfre/opt/brave/product_logo_256.png"
COMMAND="brave"

curl -L "https://github.com/brave/brave-browser/releases/download/v1.30.86/brave-browser-1.30.86-linux-amd64.zip" --output /tmp/brave.zip
mkdir -p ${HOME}/sgoinfre/opt
rm -rf ${HOME}/sgoinfre/opt/brave/
unzip -d ${HOME}/sgoinfre/opt/brave /tmp/brave.zip

rm -rf ${DESKTOP_FILE}

if [[ ! -f ${DESKTOP_FILE} ]]; then
	curl -L "https://raw.githubusercontent.com/arthur-trt/app_42/main/brave.desktop" --output ${DESKTOP_FILE}
	sed -i "s|ICON_PATH|${ICON_PATH}|g" ${DESKTOP_FILE}
	sed -i "s|EXEC_COMMAND|${EXEC_COMMAND}|g" ${DESKTOP_FILE}

	update-desktop-database ${HOME}/.local/share/applications/
	busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…")'
fi

if ! command -v ${COMMAND} &> /dev/null
then
	echo "export PATH=\$HOME/sgoinfre/opt/brave:\$PATH" >> ${HOME}/.zshrc
fi
