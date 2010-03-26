# Makefile.am -- Makefile for language-related data of the m17n database
# Copyright (C) 2007
#   National Institute of Advanced Industrial Science and Technology (AIST)
#   Registration Number H15PRO112

# This file is part of the m17n database; a sub-part of the m17n
# library.

# The m17n library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public License
# as published by the Free Software Foundation; either version 2.1 of
# the License, or (at your option) any later version.

# The m17n library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.

# You should have received a copy of the GNU Lesser General Public
# License along with the m17n library; if not, write to the Free
# Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301, USA.

pkgdatadir=$(datadir)/@INSTSUBDIR@

TABLES=@LANGNAME_TABLES@

pkgdata_DATA = LANGUAGE.tbl ${TABLES}

EXTRA_DIST = ${TABLES} native.txt ISO-639-2.txt

dist_noinst_SCRIPTS = LANGUAGE.awk

native.ext: ${TABLES}
	(for f in [a-z][a-z].lnm [a-z][a-z][a-z].lnm; do \
	  l=`basename $$f .tbl`; \
	  sed -n -e "/($$l /s/(\([a-z]*\)[^\"]*\"\([^\"]*\)\")/\1|\2/p" < $$f; \
	done) > $@

LANGUAGE.tbl: LANGUAGE.awk ${TABLES} native.txt native.ext
	$(AWK) -f LANGUAGE.awk '-F|' < ISO-639-2.txt > $@

CLEANFILES = native.ext LANGUAGE.tbl
