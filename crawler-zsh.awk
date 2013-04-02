#!/usr/bin/env awk
# DESCRIPTION
#   Count occurence for each command form
#   called by ./shelll-stats.bash
# USAGE
#   ./crawler-zsh.awk list-of-command.txt


# executed before any of the input -files- are read
BEGIN {
}

/=/ { # variable line
  var[$1]++
}

{ #
    cmd[$1]++
}

# executed after any of the input -files- are read
END {
  for (v in var) print var[v] " " v
  for (c in cmd) print cmd[c] " " c
}
