# drawercli v1.0.1
# App drawer on Android but it's cli,

source $HOME/storage/shared/termuxlauncher/.apps-launcher # inisialisasi termuxlauncher, ini akan membaca seluruh aplikasi pengguna yang diinstall di perangkat



function backKey() {

input keyevent 4
}

#backKey

opt="$1"
if [ -z "$opt" ]; then


launch -l | grep -Exo '[a-z0-9:_-]+' | sort -u | xargs | lolcat -r | xargs -n 1 | pick | termux-clipboard-set

termux-clipboard-get >> $HOME/.drawercli_history
launch $(termux-clipboard-get)




elif [ "$opt" == "--skip" ]; then # THIS OPTION SKIP

launch $(launch -l | grep -o "termux" )

exit 0;

elif [ "$opt" == "-S" ]; then # THIS OPTION SUGGESTIONS

ERROR=${2?Error: option requires an argument -- S }


      launch $(launch -l | grep -Exo [a-z0-9:_-]+ | sort -u | xargs | lolcat -r | xargs -n 1 | shuf | head -n "$2" | pick)

   backKey

    echo $ERROR

 exit 0;

elif [ "$opt" == "-u" ]; then # THIS OPTION MOST USAGE

#  launch $(launch -l | grep -Exo [a-z0-9:_-]+ | 
#cat $HOME/.drawercli_history | uniq -c | sort -r | tr -d '\t0-9' | head -n 1 | pick


  cat $HOME/.drawercli_history | uniq -c | sort -r | sed 's/[\t0-9]//g' | head -n 1 | pick | termux-clipboard-set


  launch $(termux-clipboard-get)

exit 0;

elif [ "$opt" == "-r" ]; then # THIS OPTION FOR REFRESH LIST APPS BY termuxlauncher


launch $(launch -l | grep "termuxlauncher" )

exit 0;

 else


       echo "$0: options not recognized! or require more arguments after -$opt";
     exit 1;

fi


