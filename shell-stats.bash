#!/usr/bin/env bash
# DESCRIPTION
#
# USAGE
#

sed -i '/shell-stats.bash/d' "$HISTFILE" # remove references to the script
scriptDir="$(dirname "$0")" # emplacement du script

shellList=( "bash" "csh" "ksh" "sh" "tsh" "zsh" )

# @description For all shell, we look at the history file
#
function loopShells() {
    for shell in "${shellList[@]}";
    do
      printf -v historyFile "%s/.%s_history" "$HOME" "$shell"
        "$shell"Crawler # call the right crawler
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
    cut -d ';' -f 2- "$historyFile" | awk -f "$scriptDir"/crawler-zsh.awk
}


loopShells "${shellList[@]}"
