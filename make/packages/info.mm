# -*- Makefile -*-
#
# michael a.g. aïvázis
# parasim
# (c) 1998-2018 all rights reserved
#

# show me
# ${info -- packages.info}

# package help
# make the recipe
packages.info: mm.banner
	$(log) "known packages: "$(palette.purple)$(packages)$(palette.normal)
	$(log)
	$(log) "to build one of them, use its name as a target"
	$(log) "    mm ${firstword $(packages)}"
	$(log)
	$(log) "to get more information about a specific package, use"
	$(log) "    mm ${firstword $(packages)}.info"
	$(log)

# build the package targets
#   usage: packages.workflows {package}
define packages.workflows
    # build recipes
    ${call package.workflows.build,$(1)}
    # info recipes
    ${call package.workflows.info,$(1)}
    # help recipes
    ${call package.workflows.help,$(1)}
# all done
endef


# build targets
# make the package specific targets
#   usage: package.workflows {package}
define package.workflows.build

# top level target
$(1): $(1).directories $(1).assets
	${call log.asset,"pkg",$(1)}

# make all relevant directories
$(1).directories: $($(1).pycdir) $($(1).staging.pycdirs)

# make the directories with the byte compiled files
$($(1).staging.pycdirs):
	$(mkdirp) $$@
	${call log.action,"mkdir",$$@}

$(1).assets: $($(1).staging.pyc) $($(1).staging.meta.pyc)

# make rules that byte compile the sources
${foreach source,$($(1).sources),
    ${eval ${call package.workflows.pyc,$(1),$(source)}}
}

# make the rule that generates the package meta-data file
$($(1).staging.meta.pyc): $($(1).staging.meta)
	${call log.action,sed,$$<}
	$(sed) \
          -e "s:PROJECT:$(project):g" \
          -e "s:MAJOR:$($(project).major):g" \
          -e "s:MINOR:$($(project).minor):g" \
          -e "s:REVISION:$($(project).revision):g" \
          -e "s|YEAR|$($(project).now.year)|g" \
          -e "s|TODAY|$($(project).now.date)|g" \
          $($(1).staging.meta) > $($(1).staging.meta.py)
	${call log.action,python,$($(1).staging.meta.py)}
	$(python.compile) $($(1).staging.meta.py)
	$(rm) $($(1).staging.meta.py)

# all done
endef


# helpers
# make a target for each byte compiled file
#   usage: package.workflows.pyc {package} {source}
define package.workflows.pyc =

    # local variables
    # the absolute path to the source
    ${eval path.py := $(2)}
    # the absolute path to the byte compiled file
    ${eval path.pyc := ${call package.staging.pyc,$(1),$(path.py)}}

$(path.pyc): $(path.py) | ${dir $(path.pyc)}
	${call log.action,python,$$<}
	$(python.compile) $(path.py)
	$(mv) $$(<:$(languages.python.sources)=$(languages.python.pyc)) $(path.pyc)

# all done
endef

# make a recipe to log the metadata of a specific package
# usage: package.workflows.info {package}
define package.workflows.info =
# make the recipe
$(1).info:
	${call log.sec,$(1),"a package in project '$($(1).project)'"}
	$(log)
	$(log)
	$(log) "for an explanation of their purpose, try"
	$(log)
	$(log) "    mm $(1).help"
	$(log)
	$(log) "related targets:"
	$(log)
	${call log.help,$(1).info.directories,"the layout of the source directories"}


# make a recipe that prints the directory layout of the sources of a package
$(1).info.directories:
	${call log.sec,$(1),"a package in project '$($(1).project)'"}
	${call log.sec,"  source directories",}
	${foreach directory,$($(1).directories),$(log) $(log.indent)$(directory);}


# make a recipe that prints the set of sources that comprise a package
$(1).info.sources:
	${call log.sec,$(1),"a package in project '$($(1).project)'"}
	${call log.sec,"  sources",}
	${foreach source,$($(1).sources),$(log) $(log.indent)$(source);}


# make a recipe that prints the set of byte compiled files that comprise a package
$(1).info.pyc:
	${call log.sec,$(1),"a package in project '$($(1).project)'"}
	${call log.sec,"  byte compiled files",}
	${foreach pyc,$($(1).staging.pyc),$(log) $(log.indent)$(pyc);}


# make a recipe that prints the directories that house the package byte compiled files
$(1).info.pycdirs:
	${call log.sec,$(1),"a package in project '$($(1).project)'"}
	${call log.sec,"  directories with byte compiled files",}
	${foreach dir,$($(1).staging.pycdirs),$(log) $(log.indent)$(dir);}


# make a recipe that prints the directory layout of the sources of a package
$(1).info.general:
	${call log.sec,$(1),"a package in project '$($(1).project)'"}
	${foreach var,$($(1).meta.general), \
            ${call log.var,$(var),$$($(1).$(var))}; \
         }

# all done
endef

# make a recipe to show the metadata documentation of a specific package
# usage: package.workflows.help {package}
define package.workflows.help =
# make the recipe
$(1).help:
	$(log)
	${call log.sec,$(1),package attributes}
	$(log)
	${foreach category,$($(1).meta.categories),\
            ${call log.sec,"  "$(category),$($(1).metadoc.$(category))}; \
            ${foreach var,$($(1).meta.$(category)), \
                ${call log.help,$(1).$(var),$($(1).metadoc.$(var))}; \
             } \
        } \
	$(log)
	$(log) "for a listing of their values, try"
	$(log)
	$(log) "    mm $(1).info"
	$(log)
# all done
endef



# show me
# ${info -- done with packages.info}

# end of file