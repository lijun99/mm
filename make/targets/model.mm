# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2019 all rights reserved
#

# build the data model

# show me
# ${info -- targets.model}

# load the requested ones
include $(target.variants:%=make/targets/%.mm)

# show me
# ${info -- done with targets.model}

# end of file
