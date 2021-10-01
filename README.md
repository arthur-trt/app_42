# Bypass Flatpak on 42 Linux iMac

The purpose of these different scripts is to download, install, and configure the Gnome shortcuts of some applications I use. These scripts are there because some applications are not available at 42, or worse, they are available via flatpak (which is quickly blocking to use gdb or other).

You can reuse each of the scripts to update applications without losing data

## VSCode
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/arthur-trt/app_42/main/vscode.sh)"
```

For uninstall you can :
```
rm -rf ${HOME}/.local/share/applications/com.visualstudio.code.desktop
rm -rf ${HOME}/opt/code-linux-64
```

## GitKraken
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/arthur-trt/app_42/main/gitkraken.sh)"
```

For uninstall you can :
```
rm -rf ${HOME}/.local/share/applications/gitkraken.desktop
rm -rf ${HOME}/opt/gitkraken
```

## Brave Browser
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/arthur-trt/app_42/main/brave.sh)"
```

For uninstall you can :
```
rm -rf ${HOME}/.local/share/applications/brave.desktop
rm -rf ${HOME}/opt/brave
```
