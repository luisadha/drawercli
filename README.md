<!-- [![Please don't upload to GitHub](https://nogithub.codeberg.page/badge.svg)](https://nogithub.codeberg.page)
[![Made with Bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg) -->

[![Maintained-Yes](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://img.shields.io/badge/Maintained%3F-yes-green.svg) 
[![Fetch-license](https://img.shields.io/github/license/luisadha/drawercli.svg)](https://img.shields.io/github/license/luisadha/drawercli.svg)
[![Total-downloads](https://img.shields.io/github/downloads/luisadha/drawercli/total.svg)](https://img.shields.io/github/downloads/luisadha/drawercli/total.svg)
[![Stargazer](https://img.shields.io/github/stars/luisadha/drawercli.svg)](https://img.shields.io/github/stars/luisadha/drawercli.svg)
[![Fork-totals](https://img.shields.io/github/forks/luisadha/drawercli.svg)](https://img.shields.io/github/forks/luisadha/drawercli.svg)
[![Watcher-totals](https://img.shields.io/github/watchers/luisadha/drawercli.svg)](https://img.shields.io/github/watchers/luisadha/drawercli.svg)



<h1 align="center">Drawercli-lightwieght for Termux</h1>

<p align="center">Application drawer in the terminal. Requires the Termuxlauncher library or app and Termux installed on the device.</p>


<p align="center"><b>Also find drawercli on alrc-termux plugin.</b></p>


## Features

- Interactive by scrolling the screen to select apps and typing to find favorite apps (this parts has been improved on new update).

- Updated app list in Termuxlauncher.

- Display frequently opened apps.

- Makes app suggestions to open with a specified number.

- Calculate total user applications

- Support touchscreen

- Can be installed in ~/.shortcuts to run via Termux:widget

- Can be installed on ztmexluis or luis-toolbox.sh

> [!NOTE]
> Without Termuxlauncher & Termux this tool won't work.

## Dependencies
#### A. Download and install these apk's
* Termuxlauncher apk's [Check this!](https://github.com/amsitlab/termuxlauncher/releases)
* Termux:widget (optional) [Find on Play store](https://play.google.com/store/apps/details?id=com.termux.widget)
    <!-- * ~pkg install termux-api (https://wiki.termux.com/wiki/Termux:API)~
  * ~pkg install pick (https://github.com/mptre/pick)~ -->
#### B. Install packages
* ```input``` keyevent (is in /system/bin make sure it is part of the $PATH variable) (**Optional**)
* git, curl, fzf, coreutils, sed, grep and which.
* termux-setup-storage


## Install with Bash Package Manager ([bpkg](https://bpkg.sh/bpkg/))

```sh
bpkg install -g luisadha/drawercli
```

<!-- ```sh
curl -fSsl "https://github.com/luisadha/drawercli/blob/v1.2.1-lightwieght/drawercli-lightweight.sh" -o ~/.local/bin/drawercli && chmod +x ~/.local/bin/drawercli
``` -->
* Install with Make

```make
make install
```

* Install with Nix-build

```nix
nix-build
```
```nix
nix-env -i ./result
```

## Uninstall

- general (i.e.: termux)

```sh
rm -f ${PREFIX}/bin/drawercli
```
- nix-on-droid

```nix
nix-env -e drawercli
nix-env --rollback
```

- gnumake

```make
make uninstall
```
## Optional Config
Try our custom configurations, Termux config is stored in ~/.termux/termux.properties

```json
extra-keys-style = none
extra-keys = [[{key: "drawercli \n", popup: KEYBOARD, display: drawercli}]]
```
## Usage

```sh
drawercli -S 4 | -u

 Command-line-based app drawer to display a list of all user-installed apps on the device and many other features.

drawercli requires the termuxlauncher to be installed and used at least once to use this tool.

Available options:

-S NUMBER                To display app recommendations to open, recommendations will be displayed according to the given number.
-c, --clear-history      To clear the history of opened app activities.
-r                       To refresh the list of apps, newly installed apps will be displayed after the refresh.
-s, --skip               Does nothing, literally opens Termux itself.
-u                       To display the most frequently used apps.
-w, --see-wallpaper      To view the wallpaper or open the current-wallpaper app.
-h, --help               To display this help message.
```
## Tested
| Platform | Status |
| :---------------- | :------: | 
| Termux | ✅ | 
| Nix-on-droid | ✅ |
| Acode Terminal Plugin | ❌ |

## Issue

Issues related to nix-on-droid, Try clearing this duplicate package garbage fix

```nix
nix-collect-garbage
```
## Author

@luisadha 

## Contributor

@zaedstudioshpkentang

## 💰 Support my work by Donating
 
[![BuyMeACoffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://www.buymeacoffee.com/luisadha) 
[![PayPal](https://img.shields.io/badge/PayPal-00457C?style=for-the-badge&logo=paypal&logoColor=white)](https://www.paypal.com/paypalme/luisadha01)

## Thanks

- Creator of Termuxlauncher and termux for creating great apps
- pick tools
- fzf tools
- bpkg (bash package manager)
- 
