#!/bin/bash
# 
# drawercli v1.0.2
# App drawer on Android but it's cli,
# Copyright (c) 2023 Luis Adha
# Rilis (100)
# First release on Codeberg

# Update (101)
# ~fix bug on -u option (stable)

# Update (102)
#+add resetClipboard() function's
#~fix bug (OH,OB on scrolling)
#~fix bug JAVA error comes with input
#-del backKey
#+fix the strings
#+add -c options, && --clear-history


source $HOME/storage/shared/termuxlauncher/.apps-launcher # inisialisasi termuxlauncher, ini akan membaca seluruh aplikasi pengguna yang diinstall di perangkat

function resetClipboard() {
 termux-clipboard-set ""
}

function hideSoftKeyboard() {
 input keyevent 4
}


opt="$1"
if [ -z "$opt" ]; then

hideSoftKeyboard;

  launch -l | grep -Exo '[a-z0-9:_-]+' | sort -u | xargs | lolcat -r | xargs -n 1 | pick | termux-clipboard-set

  termux-clipboard-get >> $HOME/.drawercli_history

  launch $(termux-clipboard-get)

resetClipboard;

exit 0;

elif [ "$opt" == "-s" ] || [ "$opt" == "--skip" ]; then # THIS OPTION SKIP


launch $(launch -l | grep -o "termux" ) &>/dev/null;

exit 0;

elif [ "$opt" == "-S" ]; then # THIS OPTION SUGGESTIONS

hideSoftKeyboard;

ERROR=${2?drawercli: option requires an argument after -- S }

      launch $(launch -l | grep -Exo [a-z0-9:_-]+ | sort -u | xargs | lolcat -r | xargs -n 1 | shuf | head -n "$2" | pick)


    echo $(basename $ERROR)

 exit 0;

elif [ "$opt" == "-u" ]; then # THIS OPTION MOST USAGE

if [ ! -f $HOME/.drawercli_history ]; then
    echo "drawercli: No history most opened apps."
    exit 1;
elif [ $(cat $HOME/.drawercli_history | wc -w) -eq 0 ]; then
    echo "drawercli: No history most opened apps. 2";
    exit 2;
else

  cat $HOME/.drawercli_history | uniq -c | sort -r | sed 's/[\t0-9]//g' | head -n 1 | pick | termux-clipboard-set

  launch $(termux-clipboard-get)

resetClipboard;

exit 0;
fi

elif [ "$opt" == "-r" ]; then # THIS OPTION FOR REFRESH LIST APPS BY termuxlauncher

launch $(launch -l | grep "termuxlauncher" ) &>/dev/null;

echo "drawercli: Memindai aplikasi baru..."; sleep 1;
echo -e "Please, type \`drawercli' again to see effect!"

exit 0;
elif [ "$opt" == "-w" ] || [ "$opt" == "--see-wallpaper" ]; then
  launch $(launch -l | grep "current-wallpaper" )

exit 0;
elif [ "$opt" == "-c" ] || [ "$opt" == "--clear-history" ]; then
set +o noclobber

echo '' > ${HOME}/.drawercli_history
echo "drawercli: History was cleared!"
exit 0;

elif [ "$opt" == "-h" ] || [ "$opt" == "--help" ]; then

  echo "drawercli | -S 4 | -u "
  echo
  echo " Laci aplikasi berbasis command line untuk menampilkan semua daftar aplikasi pengguna yang di-install pada perangkat dan banyak fitur lainnya."
 echo
  echo "drawercli membutuhkan Peluncur termuxlauncher di install dan dipakai minimal sekali untuk dapat menggunakan alat ini."
  echo
  echo "Available options:"
  echo
  echo -e "-S NUMBER" "\t\t" "Untuk menampilkan rekomendasi aplikasi untuk dibuka, rekomendasi akan ditampilkan sesuai angka yang diberikan."
  echo -e "-c, --clear-history" "\t" "Untuk membersihkan riwayat aktifitas aplikasi yang dibuka."
  echo -e "-r" "\t\t\t" "Untuk menyegarkan daftar aplikasi, Aplikasi yang baru diinstall akan ditampilkan setelah penyegaran."
  echo -e "-s, --skip" "\t\t" "Tidak melakukan apapun, secara harfiah itu membuka Termux itu sendiri."
  echo -e "-u" "\t\t\t" "Untuk menampilkan aplikasi yang paling sering dipakai."
  echo -e "-w, --see-wallpaper" "\t" "Untuk melihat wallpaper atau membuka aplikasi current-wallpaper."
  echo -e "-h, --help" "\t\t" "Untuk menampilkan pesan bantuan ini."
  echo
  exit 1;
 else
       echo "$(basename $0): options not recognized -$opt";
   exit 1;

fi


