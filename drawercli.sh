#!/data/data/com.termux/files/usr/bin/env bash
# Issue: kolom ke 1 seharusnya label aplikasi bukan package name aplikasi
# Terima kasih :
# - Muhammad Fikri (Feedback)
# Bagus kan kodingan gue?
messages_error=()

IFS=''
packages=$(
  pm list packages --user 0 -3 2>&1 </dev/null | while read -r line; do
      pkg=${line#package:}
      main=$(pm resolve-activity --user 0 \
          -a android.intent.action.MAIN \
          -c android.intent.category.LAUNCHER \
          "$pkg" 2>&1 </dev/null | grep "name=" | head -n1 | sed 's/.*name=//')
      if [ -n "$main" ]; then
          echo "$pkg|$main"
      fi
  done
);
chosen=$(
  printf '%s\n' "${packages[@]}" \
  | awk -F'|' '{printf "%s\t%s\n", $1, $0}' \
  | fzf -1 --with-nth=1 --delimiter='\t' --layout=reverse
  );

if [[ -n "$chosen" ]]; then
  # Ambil hanya kolom kedua (name|intent)
full_line=$(awk -F'\t' '{print $2}' <<<"$chosen")
IFS='|' read -r package intent <<<"$full_line";
[ -z "$package" ] || [ -z "$intent" ] && printf "%s\n" "${messages_error[*]}" && exit 2;
launch="${package:-}|${intent:-}"
 # JSON output print
  jq -n --arg pkg "$package" --arg int "$intent" '{package: $pkg, intent: $int}'
echo "$launch" | tr '|' '/' | xargs -r am start --user 0 -n
fi
