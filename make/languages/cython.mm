# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2018 all rights reserved
#

# cython
languages.cython.sources := .pyx
languages.cython.headers := .pxd .pxi

# language predicates
languages.cython.compiled := yes
languages.cython.interpreted :=

# flags
languages.cython.categories.compile := flags defines incpath
languages.cython.categories.link :=

# build a compile command line
#  usage: languages.cython.compile {source-file} {target-object} {dependencies}
define languages.cython.compile =
${strip
    cython $(1) $(cython.compile.output) $(2)
}
endef


# end of file
