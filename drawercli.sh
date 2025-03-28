#!/data/data/com.termux/files/usr/bin/bash

# drawercli v1.2.7-launch.bash (android13 support)
# App drawer on Android but it's CLI,
# Copyright (c) 2023 Luis Adha
# made with love & clean code priority

enable_history=0
fast_scroll_flags='--cycle' #not used yet # soon to version v1.2.2
version="1.2.7-launch";
name="drawercli";
self="none";
depend="termuxlauncher";
hint="$name: Scroll to 'Termux' or type that to quit.\ ";
info="$name: No such apps or interrupted by user." ;
num=1;
tmp_dir="$HOME/.tmp"
history_path="$HOME/.drawercli_history";
export PATH="$PATH:/system/bin";
pathlib="source $(which launch)"
launch="launch_App"
main_activity="launch_Main"
empty_activity="launch_ItSelf"
suggest_activity() {
  local num=$@
  launch_Random "$num"
}

$pathlib ||
echo "CANNOT EXECUTE "$0": library "launch" not found: needed by main executable"

#source $HOME/storage/shared/termuxlauncher/.apps-launcher &>/dev/null ||  source "${EXTERNAL_STORAGE}/termuxlauncher/.apps-launcher" || source /sdcard/termuxlauncher/.apps-launcher

# initialize termuxlauncher, this will read all user-installed apps on the device
# initialize alias if any
source ~/.drawercli_aliases 2>/dev/null
mkdir -p $tmp_dir 
function waitingInterupt() {
echo -e "$name: Process interrupted by the user (Ctrl + C)"
exit 0
}
trap waitingInterupt SIGINT
#function resetClipboard() {
 #termux-clipboard-set ""
#}
if [ "$SHELL_CMD__PACKAGE_NAME" == "com.termux.nix" ]; then
self="nix"
function hideSoftKeyboard {
 :
}
else
self="termux"
function hideSoftKeyboard() {
 hide_soft_keyboard || input keyevent 4 2>/dev/null;
}
fi
: "function historyPrepare() {
 cat $HOME/.drawercli_history | xargs | xargs -n $num  > $history_path 
}" # deprecrated function
function Drawer {
    while true; 
          do 
            $main_activity "$1" >&2 > ~/.tmp/drawercli.out 
    echo "$(cat ~/.tmp/drawercli.out)" >> $HOME/.drawercli_history
         if [ "$(cat ~/.tmp/drawercli.out)" == "termux" ]; then 
          break
       elif [ "$(cat ~/.tmp/drawercli.out)" == "" ] ; then
          echo "$info"; break
         fi
    $launch "$(cat ~/.tmp/drawercli.out)"
    #   trap waitingInterupt SIGINT
       # resetClipboard;
        hideSoftKeyboard;
        continue;
    done; }
opt="$1"; if [ -z "$opt" ]; then
    hideSoftKeyboard; Drawer;
elif [ "$opt" == "-s" ] || [ "$opt" == "--skip" ]; then # THIS OPTION SKIP
 $empty_activity
  exit 0;
elif [ "$opt" == "-v" ] || [ "$opt" == "--version" ]; then
  echo -e "drawercli v${version} Copyright (c) 2023 - 2024 Luis Adha <adharudin14@gmail.com>";
  echo -e ""
  echo -e "You can find this repository at <https://github.com/luisadha/drawercli>";
  echo -e "Using library termuxlauncher visit <https://github.com/amsitlab/termuxlauncher>";
  exit 0;
elif [ "$opt" == "-S" ]; then # THIS OPTION SUGGESTIONS
        hideSoftKeyboard; error='option requires an argument after -- S'; catch=$2; try=`if [ -z "$catch" ]; then echo "$name: $error" >&2; exit ${1:+1}; fi`

        shift 
        suggest_activity "$1"

        exit ${1:+0}; # untuk menyembunyikan error dari command launch jika salah input
elif [ "$opt" == "-u" ]; then # THIS OPTION MOST USAGE
  if [ ! -f $HOME/.drawercli_history ]; then
        echo "drawercli: No history most opened apps."
        exit ${1:+1};
elif [ $(cat $HOME/.drawercli_history | wc -w) -eq 0 ]; then
        echo "drawercli: No history most opened apps. 2";
        exit ${1:+2};
else
      cat $HOME/.drawercli_history \
      | uniq -c \
      | sort -r \
      | sed 's/[\t0-9]//g' \
      | xargs       \
      | xargs -n $num \
      | head -n 1 \
      | fzf $fast_scroll_flags >&2 > ~/.tmp/drawercli.out
            $launch $(cat ~/.tmp/drawercli.out);
  #resetClipboard;
exit ${1:+0};
  fi
elif [ "$opt" == "-r" ]; then # THIS OPTION FOR REFRESH LIST APPS BY termuxlauncher
  $empty_activity

exit ${1:+0};
elif [ "$opt" == "-w" ] || [ "$opt" == "--see-wallpaper" ]; then
  $launch "Current wallpaper"
exit ${1:+0};
elif [ "$opt" == "-c" ] || [ "$opt" == "--clear-history" ]; then
set +o noclobber
  echo '' > ${HOME}/.drawercli_history
  echo "drawercli: History was cleared!"
exit ${1:+0};
elif [ "$opt" == "-h" ] || [ "$opt" == "--help" ]; then

  echo "drawercli -S 4 | -u "
  echo
  echo " Command-line-based app drawer to display a list of all user-installed apps on the device and many other features."
 echo
  echo "drawercli requires the termuxlauncher to be installed and used at least once to use this tool."
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
  echo
  exit ${1:+1};
 else echo "$(basename $0): options not recognized -$opt";
   exit ${1:+1}
fi
