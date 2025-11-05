#!/data/data/com.termux/files/usr/bin/env bash
IFS=''

# ambil daftar package
packages=$(pm list packages --user 0 -3 2>&1 </dev/null | sed 's/^package://')

# function untuk tiap package
process_pkg() {
  pkg=$1

  # ambil main activity
  main=$(pm resolve-activity --user 0 \
      -a android.intent.action.MAIN \
      -c android.intent.category.LAUNCHER \
      "$pkg" 2>&1 </dev/null | grep "name=" | head -n1 | sed 's/.*name=//')

  # ambil apk path
  apk_path=$(pm path "$pkg" --user 0 2>&1 </dev/null | sed 's/package://; s/=$pkg//' | head -n1)

  # ambil label aplikasi
  label=$(aapt dump badging "$apk_path" 2>/dev/null \
            | grep "application-label:" \
            | sed "s/.*application-label:'//; s/'//")

  if [ -n "$main" ] && [ -n "$label" ]; then
    echo "$label|$pkg|$main"
  fi
}

export -f process_pkg

# jalankan semua package secara paralel
apps=$(printf '%s\n' "$packages" | parallel -j 5 process_pkg {})

# tampilkan ke fzf
chosen=$(printf '%s\n' "$apps" \
  | awk -F'|' '{printf "%s\t%s|%s\n", $1, $2, $3}' | sort | fzf --with-nth=1 --delimiter='\t' --layout=reverse)

[ -z "$chosen" ] && exit 1

# ambil hasil
line=$(awk -F'\t' '{print $2}' <<<"$chosen")
IFS='|' read -r package intent <<<"$line"

# jalankan aplikasi
am start --user 0 -n "$package/$intent"
