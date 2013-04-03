#!/usr/bin/env awk
# DESCRIPTION
#   Count occurence for each command form
#   called by ./shelll-stats.bash
# USAGE
#   ./crawler-zsh.awk list-of-command.txt


# executed before any of the input -files- are read
BEGIN {
}


# For each lines in the file
{
    # print "$0:", $0
    cmdKey=""

    for (i=1; i < NF; i++) {
        cmdKey = sprintf("%s %s", cmdKey, $i)
        cmdList[cmdKey]++
    }
}


# executed after any of the input -files- are read
END {
    for (c in cmdList) printf ("%s\0%s\0", c, cmdList[c])
}
