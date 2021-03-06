# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2019 all rights reserved
#

# show me
# ${info -- builder.init}

# the builder constructor
#   usage: builder.init {project-prefix} {project-bldroot}
define builder.init =
    # the build tag
    ${eval builder.tid := $(target.tag)}

    # construct the name of the top level directory
    ${eval builder.dest.prefix := $(1)/$(builder.tid)/}
    ${eval builder.dest.root := $(2)/$(builder.tid)/}
    ${eval builder.dest.bin := $(builder.dest.prefix)bin/}
    ${eval builder.dest.doc := $(builder.dest.prefix)doc/}
    ${eval builder.dest.inc := $(builder.dest.prefix)include/}
    ${eval builder.dest.lib := $(builder.dest.prefix)lib/}
    ${eval builder.dest.pyc := $(builder.dest.prefix)packages/}
    ${eval builder.dest.defaults := $(builder.dest.prefix)defaults/}
    ${eval builder.dest.staging := $(builder.dest.root)}

    # make a pile out for all the relevant directories; this gets used by the rulemaker that makes
    # sure these directories exist, so make sure you add new ones here as well
    ${eval builder.dirs := prefix root bin doc inc lib pyc defaults staging}
    # put them all on a pile
    ${eval builder.directories := \
        ${sort \
            ${foreach directory,$(builder.dirs),$(builder.dest.$(directory))} \
        } \
    }

    # extensions for products
    builder.ext.obj := .o
    builder.ext.dep := .d
    builder.ext.lib := .a
    builder.ext.dll := .so

# all done
endef

# show me
# ${info -- done with builder.init}

# end of file
