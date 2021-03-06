#!/usr/bin/env bash
# DESCRIPTION
# Build a JSON array holding statistics about your command history. Structure is as follow
# [
#   {
#      'cmd': "echo 'string'", // JSON-escaped command
#      'size': 5 // number of occurences
#   }
# ]
#
# USAGE
# ./shell-insights.bash

scriptDir="$(dirname "$0")" # emplacement du script

outputDir='./app/data/' # yeoman hierarchy

shellList=( "bash" "csh" "ksh" "sh" "tsh" "zsh" )

# @description For all shell, we look at the history file
function loopShells() {
  for shell in "${shellList[@]}";
  do
    printf -v historyFile "%s/.%s_history" "$HOME" "$shell"

    if [[ -e "$historyFile" || -f "$historyFile" ]];
      then
        $(sed -i '/shell-stats.bash/d' "$historyFile") # remove references to the script
        "$shell"Crawler # call the right crawler
    else
        printf "skipping %s\n" "$shell"
    fi
done
}


# @description  crawl Bash history
function bashCrawler() {
  printf "%s\n" "Bash"
  awk -f "$scriptDir"/crawler-bash.awk "$historyFile"
}

# @description  crawl Csh history
function cshCrawler() {
  printf "%s\n" "Csh"
  awk -f "$scriptDir"/crawler-csh.awk "$historyFile"
}

# @description  crawl Ksh history
function kshCrawler() {
  printf "%s\n" "Ksh"
  awk -f "$scriptDir"/crawler-ksh.awk "$historyFile"
}

# @description  crawl Sh history
function shCrawler() {
  printf "%s\n" "Sh"
  awk -f "$scriptDir"/crawler-sh.awk "$historyFile"
}

# @description  crawl Tsh history
function tshCrawler() {
  printf "%s\n" "Tsh"
  awk -f "$scriptDir"/crawler-tsh.awk "$historyFile"
}


# @description  crawl Zsh history
function zshCrawler() {
    printf "%s\n" "Zsh"
    cut -d ';' -f 2- "$historyFile" \
    | splitLine \
    | removeComment \
    | awk -f "$scriptDir"/crawler-zsh.awk | sed 's/^ //g' \
    | sort -k 2 \
    | toJSON  > "$scriptDir"/"$outputDir"/output.json
    # | toJSON  | tee "$scriptDir"/"$outputDir"/output.json
}


# @description remove comment from command line
function removeComment() {
  while read input
  do
    cut -d '#' -f -2
done
}

# @description split a line by word/command separator
function splitLine() {
  while read input
  do
    awk 'BEGIN{ FS="[;&\|=]" } { for (i=1; i<=NF; i++) print $i}'
done
}


function toJSON() {
    local globalWrap=( '[' ']' ) # array: [] or object: {}
    local cmdWrap='{}'
    local i=0 # used as object index

    printf "%s\n" "${globalWrap[0]}"
    # use NUL delimiter as separator, hence 2 call to 'read'
    # IFS presence prevent trailing whitespaces to be stripped off
    # so we get byte-for-byte content
    while IFS='' read -r -d '' cmdKey && IFS='' read -r -d '' count;
    do
        (( $i > 0 )) && printf ",\n"
        cmd=( -s "$cmdKey" -i "cmd"  -n "$count" -i "size" )
        object="$("$scriptDir"/jshon/jshon "${cmd[@]}"<<<$cmdWrap )"
        printf "%s" "$object" # create [{ object }, ...]
        let "i++"
    done
    printf "\n%s" "${globalWrap[1]}"

}

loopShells "${shellList[@]}"
