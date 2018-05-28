# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2018 all rights reserved
#

# show me
# ${info -- builder.info}

builder.info: mm.banner
	${call log.sec,"builder directory layout",}
	${call log.var,"prefix",$(builder.dest.prefix)}
	${call log.var,"root",$(builder.dest.root)}
	${call log.var,"bindir",$(builder.dest.bin)}
	${call log.var,"docdir",$(builder.dest.doc)}
	${call log.var,"incdir",$(builder.dest.inc)}
	${call log.var,"libdir",$(builder.dest.lib)}
	${call log.var,"libdir",$(builder.dest.pyc)}
	${call log.var,"tmpdir",$(builder.dest.staging)}


# create the builder targets
#   usage: builder.workflows
define builder.workflows

# rule to create the builder directories
$(builder.directories):
	$(mkdirp) $$@
	${call log.action,"mkdir",$$@}

# all done
endef


# show me
# ${info -- done with builder.info}

# end of file
