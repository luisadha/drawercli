<!-- [![Please don't upload to GitHub](https://nogithub.codeberg.page/badge.svg)](https://nogithub.codeberg.page)
[![Made with Bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg) -->
This project uses GNU Parallel.
Citation: Tange, O. (2025). GNU Parallel. Zenodo. doi:10.5281/zenodo.17692695

![Warning](https://img.shields.io/badge/status-outdated-orange?style=for-the-badge)
> Documentation rewrite in progress — may not reflect current behavior.


[![Fetch-license](https://img.shields.io/github/license/luisadha/drawercli.svg)](https://img.shields.io/github/license/luisadha/drawercli.svg) ![version](https://img.shields.io/badge/version-1.2.4-blue)
[![Maintained-Yes](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://img.shields.io/badge/Maintained%3F-yes-green.svg) ![android](https://img.shields.io/badge/android-green) 
<!-- ![dependencies](https://img.shields.io/badge/dependencies-out%20of%20date-orange)
-->
<h1 align="center">Drawercli (codename: Nova) Apps Drawer for Termux</h1>
<!--
<p align="center">Application drawer in the terminal. Requires the Termuxlauncher library or app and Termux installed on the device.</p>
-->

<p align="center"><b>Find drawercli on alrc-termux plugin</b></p>

## Description
 A cli app for termux to open user android apps with Termuxlauncher backend as your main launcher, installation of termuxlauncher apps is necessary for the script to work. [Follow the installation instructions](https://github.com/amsitlab/termuxlauncher/releases)

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

## Dependencies & Requirements
#### A. Download and install these apk's 
[v1.2.4] Using termuxlauncher =< Android 11
* Termuxlauncher apk's [Check this!](https://github.com/amsitlab/termuxlauncher/releases)
* Termux:widget (optional) [Find on Play store](https://play.google.com/store/apps/details?id=com.termux.widget)

[v1.2.7] Using [ListMyApps](https://github.com/u0a316/ListMyApps/releases/tag/v1.0)
#### B. Other
* Android minimum version 5.0 up to Android 13 Using ListMyApp
     <!-- * ~pkg install termux-api (https://wiki.termux.com/wiki/Termux:API)~
  * ~pkg install pick (https://github.com/mptre/pick)~ -->
#### C. Install packages
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
1. Fix shebang on nix

 ```bash
sed -i '1s|#!/data/data/com.termux.nix/files/usr/bin/bash|#!/data/data/com.termux.nix/files/home/.nix-profile/bin/bash|' $(command -v drawercli)
   ```

2. Issues related to nix-on-droid, Try clearing this duplicate package garbage fix
  
```bash
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

- github.com/amsitlab/termuxlauncher
- junegunn.github.io/fzf
- github.com/bpkg/bpkg
