
drawercli v1.0.3

Without Termuxlauncher this tool won't work

# Requirement

* Termuxlauncher apk's (https://github.com/amsitlab/termuxlauncher/releases)
* pkg install termux-api (https://wiki.termux.com/wiki/Termux:API)
* pkg install pick (https://github.com/mptre/pick)
* Input keyevent (is in /system/bin make sure it is part of the $PATH variable)


# Install

```sh
curl -fSsl "https://raw.githubusercontent.com/luisadha/drawercli/main/drawercli" -o ~/.local/bin/drawercli && chmod +x ~/.local/bin/drawercli
```

# Uninstall

```sh
rm -f ~/.local/bin/drawercli
```


# Usage

drawercli 

-S NUMBER               To display random app recommendations

--skip                  Do nothing or open Termux itself

-u                      To display frequently used applications

-r                      To refresh the app list, it will run termuxlauncher itself
```

Thanks to contributor :

@Zaedstudios
