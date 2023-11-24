
# drawercli

Application drawer in the terminal. Requires the Termuxlauncher library or app and Termux installed on the device.

## Features

- Interactive by scrolling the screen to select apps and typing to find favorite apps.

- Updated app list in Termuxlauncher.

- Display frequently opened apps.

- Makes app suggestions to open with a specified number.

Note: Without Termuxlauncher & Termux this tool won't work

## Prerequites

* Termuxlauncher apk's (https://github.com/amsitlab/termuxlauncher/releases)
* pkg install termux-api (https://wiki.termux.com/wiki/Termux:API)
* pkg install pick (https://github.com/mptre/pick)
* Input keyevent (is in /system/bin make sure it is part of the $PATH variable)


## Install

### a. termux

```sh
curl -fSsl "https://raw.githubusercontent.com/luisadha/drawercli/main/drawercli" -o ~/.local/bin/drawercli && chmod +x ~/.local/bin/drawercli
```

### b. proot-distro

1. 
 ```sh
proot-distro login archlinux
```

2. 
 ```sh
zsh
```

3. 
 ```sh
curl -fSsl "https://raw.githubusercontent.com/luisadha/drawercli/main/drawercli" -o /usr/sbin/drawercli && chmod +x /usr/sbin/drawercli
```


## Uninstall

```sh
rm -f ~/.local/bin/drawercli
```


## Usage

```sh
drawercli 

-S NUMBER               To display random app recommendations

--skip                  Do nothing or open Termux itself

-u                      To display frequently used applications

-r                      To refresh the app list, it will run termuxlauncher itself
```

## Author

@luisadha 

## Contributor

@zaedstudioshpkentang

## Thanks

- Creator of Termuxlauncher and termux for creating great apps

- mptre creator of pick