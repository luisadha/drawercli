
<h1 align="center">Drawercli</h1>

<p align="center">Application drawer in the terminal. Requires the Termuxlauncher library or app and Termux installed on the device.</p>


<p align="center">Find drawercli in the alrc-termux plugin.</p>


## Features

- Interactive by scrolling the screen to select apps and typing to find favorite apps.

- Updated app list in Termuxlauncher.

- Display frequently opened apps.

- Makes app suggestions to open with a specified number.

Note: Without Termuxlauncher & Termux this tool won't work

## Prerequites/dependencies

* Termuxlauncher apk's (https://github.com/amsitlab/termuxlauncher/releases)
* pkg install termux-api (https://wiki.termux.com/wiki/Termux:API)
* pkg install pick (https://github.com/mptre/pick)
* Input keyevent (is in /system/bin make sure it is part of the $PATH variable)
* pkg install coreutils
* pkg install sed
* pkg install grep



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

```sh
rm -f /usr/sbin/drawercli
``` 

if only install with proot

## Usage

```sh
  echo
  echo "Available options:"
  echo
  echo -e "-S NUMBER" "\t\t" "To display app recommendations to open, recommendations will be displayed according to the given number."
  echo -e "-c, --clear-history" "\t" "To clear the history of opened app activities."
  echo -e "-r" "\t\t\t" "To refresh the list of apps, newly installed apps will be displayed after the refresh."
  echo -e "-s, --skip" "\t\t" "Does nothing, literally opens Termux itself."
  echo -e "-u" "\t\t\t" "To display the most frequently used apps."
  echo -e "-w, --see-wallpaper" "\t" "To view the wallpaper or open the current-wallpaper app."
  echo -e "-h, --help" "\t\t" "To display this help message."
```


## Author

@luisadha 

## Contributor

@zaedstudioshpkentang

## Thanks

- Creator of Termuxlauncher and termux for creating great apps

- mptre creator of pick