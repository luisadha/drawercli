#!/data/data/com.termux/files/usr/bin/env bash
# set -euo pipefail # EXIT LANGSUNG SAAT ADA YANG ERROR
# set -xv # DEBUG
file="${1:--}"
use_dialog=false
if [[ "${2:-}" == "--dialog" || "${file}" == "--dialog" ]]; then
  use_dialog=true
  if [[ "${file}" == "--dialog" ]]; then file="${2:--}"; fi
fi

# baca input (stdin, file, clipboard piped, dll.)
if ! [ -t 0 ]; then
  input_data=$(cat)
elif [[ "$file" == "-" ]]; then
  input_data=$(cat)
else
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
  | fzf --with-nth=1 --delimiter='\t' --layout=reverse); if [[ -n "$chosen" ]]; then
  # Ambil hanya kolom kedua (name|url)
  full_line=$(awk -F'\t' '{print $2}' <<<"$chosen")

  # Pecah jadi name dan url
  IFS='|' read -r name url <<<"$full_line"

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

  chosen=$(termux-dialog sheet -t "Pilih aplikasi" -v "$labels" | jq -r '.text')

  if [[ -n "$chosen" && "$chosen" != "null" ]]; then

    url=$(printf '%s\n' "${lines[@]}" | grep "^$chosen |" | cut -d'|' -f2-)

    jq -n --arg name "$chosen" --arg url "$url" '{name: $name, url: $url}'

    [[ -n "$url" ]] && termux-open-url "$url" || termux-toast "URL parse error"
  fi;
fi



set +xv
