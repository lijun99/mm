# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2019 all rights reserved
#

# colors
palette.normal := ${call csi3,0}
palette.black := ${call csi3,0;30}
palette.red := ${call csi3,0;31}
palette.green := ${call csi3,0;32}
palette.brown := ${call csi3,0;33}
palette.blue := ${call csi3,0;34}
palette.purple := ${call csi3,0;35}
palette.cyan := ${call csi3,0;36}
palette.light-gray := ${call csi3,0;37}

# bright colors
palette.dark-gray := ${call csi3,1;30}
palette.light-red := ${call csi3,1;31}
palette.light-green := ${call csi3,1;32}
palette.yellow := ${call csi3,1;33}
palette.light-blue := ${call csi3,1;34}
palette.light-purple := ${call csi3,1;35}
palette.light-cyan := ${call csi3,1;36}
palette.white := ${call csi3,1;37}

# pretty
palette.amber := ${call csi24,38,255,191,0}
palette.lavender := ${call csi24,38,192,176,224}
palette.sage := ${call csi24,38,176,208,176}
palette.steel-blue := ${call csi24,38,70,130,180}

# purpose
palette.info := ${call csi8,38,28}
palette.warning := ${call csi8,38,214}
palette.error := ${call csi8,38,196}
palette.debug := ${call csi8,38,75}
palette.firewall := $(palette.light-red)

# end of file