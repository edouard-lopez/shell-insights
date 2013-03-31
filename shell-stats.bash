#!/usr/bin/env bash
# DESCRIPTION
#
# USAGE
#

shellList = ( "bash" "csh" "ksh" "sh" "zsh" )


# @description For all shell, we look at the history file
#
function loopShells() {
    for s in "$shellList[$*]";
    do
        printf "%s\n" "$s"
    done
}
