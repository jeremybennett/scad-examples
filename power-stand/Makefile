# Makefile for power stand
#
# Copyright (C) 2023 Embecosm Limited (www.embecosm.com)
# Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>
#
# SPDX-License-Identifier: CC-BY-SA-4.0


# The tool
OPENSCAD=openscad

# Parameters
STLS = top-block.stl top-block-guide.stl

.PHONY: all
all: $(STLS)

top-block.stl: top-block.scad
	$(OPENSCAD) -D 'DO_GUIDE=false' -o $@ $<

top-block-guide.stl: top-block.scad
	$(OPENSCAD) -D 'DO_GUIDE=true' -o $@ $<

.PHONY: clean
clean:
	$(RM) $(STLS)
