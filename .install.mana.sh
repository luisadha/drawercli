## Installer for mana package manager

PREFIX="/data/data/com.termux/files/usr"

# pre-install

check_dependency pick
check_dependency fzf
check_dependency sed
check_dependency grep
check_dependency coreutils

if [ ! -f /sdcard/termuxlauncher/.apps-launcher ]; then
# not found
echo -e "Missing dependency lib \"termuxlauncher\/.apps-launcher\" !";
echo -e "Could not continue the installation."
exit 1;
fi

# creating config
 if [ -f ~/.drawercli_aliases ]; then
  source ~/.drawercli_aliases
else
  echo -en "Creating config files.. "

cat <<- "EOF" > $HOME/.drawercli_aliases
alias apps='drawercli'
alias app_favorites='drawercli -u'
alias app_recomendations='drawercli -S'
alias app_refesh='drawercli -r'
alias app_wallpaper='drawercli -w'
EOF
source ~/.drawercli_aliases
echo " Done!"; sleep 1; echo "You can find the configuration file at ~/.drawercli_aliases"
 fi

# install to usr/bin
mv ./drawercli $PREFIX/bin
chmod +x $PREFIX/bin/drawercli;

echo -e "Installation succes!";
exit 0;
