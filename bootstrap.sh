#!/bin/sh
# Copyright (C) 2003, 2004
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

echo "Cleaning up old files..."
rm -rf INSTALL aclocal.m4 autom4te.cache config.guess config.rpath config.sub install-sh libtool ltmain.sh missing mkinstalldirs intl/[D-Za-z]* m4/[a-z]*

echo "Running autoreconf -v -f -i"
autoreconf -v -f -i
echo "Producing po/POTFILES.in"
ls MIM/*.mim > po/POTFILES.in
echo "The remaining steps to install this package are:"
echo "  % ./configure"
echo "  % make"
echo "  % make install"
