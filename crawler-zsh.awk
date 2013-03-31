#!/usr/bin/env awk
# DESCRIPTION
#
# USAGE
#

# executed before any of the input -files- are read
BEGIN {
}

/=/ { # variable line
  var[$1]++
}

{ #

}

# executed after any of the input -files- are read
END {
  for (v in var) print var[v] " " v

}
