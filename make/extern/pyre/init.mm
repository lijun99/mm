# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2018 all rights reserved
#

# add me to the pile
extern += ${if ${findstring pyre,$(extern)},,pyre}

# compiler flags
pyre.flags ?=
# enable {pyre} aware code
pyre.defines := WITH_PYRE WITH_JOURNAL
# the canonical form of the include directory
pyre.incpath ?= $(pyre.dir)/include

# linker flags
pyre.ldflags ?=
# the canonical form of the lib directory
pyre.libpath ?= $(pyre.dir)/lib
# the names of the libraries
pyre.libraries := pyre journal

# my dependencies
pyre.dependencies =

# end of file