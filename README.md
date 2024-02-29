
<h1 align="center">Drawercli</h1>

<p align="center">Application drawer in the terminal. Requires the Termuxlauncher library or app and Termux installed on the device.</p>


<p align="center">Find drawercli in the alrc-termux plugin.</p>


## Features

- Interactive by scrolling the screen to select apps and typing to find favorite apps (this parts has been improved on new update).

- Updated app list in Termuxlauncher.

- Display frequently opened apps.

- Makes app suggestions to open with a specified number.

- Calculate total user applications

- Support touchscreen

- Can be installed in ~/.shortcuts to run via Termux:widget

Note: Without Termuxlauncher & Termux this tool won't work

## Prerequites/dependencies

* Termuxlauncher apk's (https://github.com/amsitlab/termuxlauncher/releases)
* pkg install termux-api (https://wiki.termux.com/wiki/Termux:API)
* ~pkg install pick (https://github.com/mptre/pick)~
* pkg install fzf
* Input keyevent (is in /system/bin make sure it is part of the $PATH variable)
* pkg install coreutils
* pkg install sed
* pkg install grep
* Install apk's Termux:widget (optional)


## Install

```sh
curl -fSsl "https://raw.githubusercontent.com/luisadha/drawercli/main/drawercli" -o ~/.local/bin/drawercli && chmod +x ~/.local/bin/drawercli
```

## Uninstall

```sh
rm -f ~/.local/bin/drawercli
```

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
- fzf creator
