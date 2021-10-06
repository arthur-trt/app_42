#!/bin/bash

DESKTOP_FILE=${HOME}/.local/share/applications/gitkraken.desktop
EXEC_COMMAND="${HOME}/sgoinfre/opt/gitkraken/gitkraken"
ICON_PATH="${HOME}/sgoinfre/opt/gitkraken/gitkraken.png"
COMMAND="gitkraken"

curl -L "https://release.gitkraken.com/linux/gitkraken-amd64.tar.gz" --output /tmp/kraken.tar.gz
mkdir -p ${HOME}/sgoinfre/opt
rm -rf ${HOME}/sgoinfre/opt/gitkraken/
tar -zxvf /tmp/kraken.tar.gz --directory ${HOME}/sgoinfre/opt

rm -rf ${DESKTOP_FILE}

if [[ ! -f ${DESKTOP_FILE} ]]; then
	curl -L "https://raw.githubusercontent.com/arthur-trt/app_42/main/gitkraken.desktop" --output ${DESKTOP_FILE}
	sed -i "s|ICON_PATH|${ICON_PATH}|g" ${DESKTOP_FILE}
	sed -i "s|EXEC_COMMAND|${EXEC_COMMAND}|g" ${DESKTOP_FILE}

	update-desktop-database ${HOME}/.local/share/applications/
	busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…")'
fi

if ! command -v ${COMMAND} &> /dev/null
then
	echo "export PATH=\$HOME/sgoinfre/opt/gitkraken:\$PATH" >> ${HOME}/.zshrc
fi
