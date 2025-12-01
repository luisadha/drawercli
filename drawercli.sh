#!/data/data/com.termux/files/usr/bin/env bash
# set -euo pipefail # EXIT LANGSUNG SAAT ADA YANG ERROR
# set -xv # DEBUG
exit_if_theres_no_match="-0"
dependencies_app_url="https://f-droid.org/id/packages/de.onyxbits.listmyapps"
file="${1:--}"
use_dialog=false
depend_installed=

if [ "$(pm list package --user 0 2>&1 </dev/null | grep de.onyxbits.listmyapps | sed 's/^package://')" == "de.onyxbits.listmyapps" ]; then
  depend_installed=true
MainActivity="de.onyxbits.listmyapps/de.onyxbits.listmyapps.MainActivity"

openApp () {
  am start --user 0 -n $MainActivity
}
messages=("$(basename $0): Clipboard kosong atau tidak berisi format yang valid mohon mengisinya dengan Membuka aplikasi 'List My Apps dari de.onyxbits.listmyapps' lalu pilih format diantara markdown/html/bbcode lalu copy daftar aplikasi. \nperhatikan juga untuk tidak menyetel kustomisasi template supaya program ini dapat membaca data.,Buka Aplikasi")
else
  depend_installed=false
download="Unduh Aplikasi"
messages=("$(basename $0): Clipboard kosong atau tidak berisi format yang valid mohon mengisinya dengan Membuka aplikasi 'List My Apps dari de.onyxbits.listmyapps' lalu pilih format diantara markdown/html/bbcode lalu copy daftar aplikasi. \nperhatikan juga untuk tidak menyetel kustomisasi template supaya program ini dapat membaca data.,$download")
fi

if [[ "${2:-}" == "--dialog" || "${file}" == "--dialog" ]]; then
  use_dialog=true
  if [[ "${file}" == "--dialog" ]]; then file="${2:--}"; fi
fi


if ! [ -t 0 ]; then # baca input (stdin, file, clipboard piped, dll.)
  input_data=$(cat)
elif [ $# -eq 0 ]; then # baca dari clipboard ketika tanpa opsi
  input_data=$(termux-clipboard-get)
elif [[ "$file" == "-" ]]; then # baca dari
  input_data=$(cat)
else # baca dari argument $1 sebagai FILE
  input_data=$(<"$file")
fi
# ---------------- Parsers ---------------- #
parse_markdown() {
  printf '%s\n' "$input_data" \
    | sed -nE 's/^[[:space:]]*[*-][[:space:]]*\[([^]]+)\]\(([^)]+)\).*/\1|\2/p'
}

parse_html() {
  printf '%s\n' "$input_data" \
    | sed -nE 's/.*<a href="([^"]+)">([^<]+)<\/a>.*/\2|\1/p'
}

parse_bbcode() {
  printf '%s\n' "$input_data" \
    | sed -nE 's/.*\[url=([^]]+)\]([^[]+)\[\/url\].*/\2|\1/p'
}
# ----------------------------------------- #

# pilih parser sesuai input
if grep -q "<a href=" <<<"$input_data"; then
  parsed_lines=$(parse_html)
elif grep -q "\[url=" <<<"$input_data"; then
  parsed_lines=$(parse_bbcode)
elif grep -q "](http" <<<"$input_data"; then
  parsed_lines=$(parse_markdown)
else
  parsed_lines=""
fi

# Normalisasi + dedupe
declare -A seen_urls
out_lines=()
while IFS= read -r line; do
  [[ -z "${line// }" ]] && continue
  name="${line%%|*}"
  url="${line#*|}"
  name="$(printf '%s' "$name" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
  url="$(printf '%s' "$url" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
  name="$(printf '%s' "$name" | sed -E 's/<[^>]+>//g')" # hapus tag html kalau ada
  [[ -z "$url" || -z "$name" ]] && continue
  if [[ -z "${seen_urls[$url]:-}" ]]; then
    seen_urls[$url]=1
    out_lines+=("$name |$url")
  fi
done <<<"$parsed_lines"

if [ "$use_dialog" == "false" ]; then
# ---------------- Section ---------- #
  lines=()
    for e in "${out_lines[@]}"; do
      lines+=("$e")  # "Name|URL"
  done

# Tampilkan fzf: kolom 1 = name, kolom 2 = full "name|url"
chosen=$(printf '%s\n' "${lines[@]}" \
  | awk -F'|' '{printf "%s\t%s\n", $1, $0}' \
  | fzf -1 --with-nth=1 --delimiter='\t' --layout=reverse); if [[ -n "$chosen" ]]; then
  # Ambil hanya kolom kedua (name|url)
  full_line=$(awk -F'\t' '{print $2}' <<<"$chosen")

  # Pecah jadi name dan url
  IFS='|' read -r name url <<<"$full_line"
[ -z "$name" ] || [ -z "$url" || "$depend_installed" == "false" ] && printf "%s\n" "${messages[*]}" && exit 2;
[ -z "$name" ] || [ -z "$url" || "$depend_installed" == "true" ] && printf "%s\n" "${messages[*]}" && exit 1;
  # JSON output valid
  jq -n --arg name "$name" --arg url "$url" '{name: $name, url: $url}'

  # Buka via play store
  termux-open-url "$url"; fi
elif [ "$use_dialog" == "true" ]; then
  lines=()
  for e in "${out_lines[@]}"; do
    lines+=("$e")  # "Name|URL"
  done

  # Ambil hanya nama (kolom 1) sebagai label dialog
  labels=$(printf '%s\n' "${lines[@]}" | cut -d'|' -f1 | paste -sd "," -)
  [ -z "$labels" ] && labels=$(echo -e "$messages")
  chosen=$(termux-dialog sheet -t "Pilih aplikasi" -v "$labels" | jq -r '.text')

  if [[ -n "$chosen" && "$chosen" != "null" ]]; then

    url=$(printf '%s\n' "${lines[@]}" | grep "^$chosen |" | cut -d'|' -f2-)

    jq -n --arg name "$chosen" --arg url "${url:-$dependencies_app_url}" '{name: $name, url: $url }'


    opened=0
    if [[ -n "$url" ]]; then
      opened=1;
      termux-open-url "$url"
    fi

    if [[ "$depend_installed" == false ]]; then
      termux-open-url "$dependencies_app_url"
    elif [[ "$depend_installed" == true ]]; then
      if [ $opened -eq 1 ]; then
        exit 1;
      fi
      openApp
    fi
  fi;
fi



set +xv
