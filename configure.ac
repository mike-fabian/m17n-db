# Copyright (C) 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011,
#   2012, 2013, 2014
#   National Institute of Advanced Industrial Science and Technology (AIST)
#   Registration Number H15PRO112
# Copyright (C) 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023 Kenichi Handa <handa@gnu.org>

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

# Process this file with autoconf to produce a configure script.
AC_INIT([m17n-db],[1.8.3],[bugs-m17n-lib@m17n.org])
AM_INIT_AUTOMAKE
AM_GNU_GETTEXT
AM_GNU_GETTEXT_VERSION([0.17])
GETTEXTDIR="$datadir/locale"
AC_SUBST(GETTEXTDIR)

LT_INIT

# Checks for programs.
AC_PROG_INSTALL
AC_PROG_AWK

AC_CHECK_PROG(HAVE_MSGFMT, msgfmt, yes)
if test "x$HAVE_MSGFMT" != "xyes"; then
  echo "  Please install the program \"msgfmt\" in advance."
  echo "  It is usually included in the package \"gettext\"."
  exit 1;
else :
fi

# Checks for source data files.
AC_ARG_WITH(charmaps,
  [  --with-charmaps=DIR     Directory of source files for charset maps.],
  CHARMAPS="$withval")

AC_SUBST(CHARMAPS)
AC_SUBST(CHARMAP_EXT)
AC_SUBST(CHARMAP_CAT)

if test "x$CHARMAPS" = "x"; then
  if test -d ./charmaps; then
    CHARMAPS=./charmaps
  elif test -d /usr/share/i18n/charmaps; then
    CHARMAPS=/usr/share/i18n/charmaps
  else
    CHARMAPS=
  fi
else :
fi

if test "x$CHARMAPS" != "x"; then
  if test -r "$CHARMAPS/EUC-JP.gz"; then
    CHARMAP_EXT=".gz"
    CHARMAP_CAT="zcat"
  elif test -r "$CHARMAPS/EUC-JP"; then
    CHARMAP_EXT=
    CHARMAP_CAT="cat"
  else
    CHARMAPS=
  fi
else :
fi

INPUT_METHOD=`echo MIM/*.mim`
AC_SUBST(INPUT_METHOD)
FLT=`echo FLT/*.flt`
AC_SUBST(FLT)
ICONS=`echo icons/*.png`
AC_SUBST(ICONS)

LANGNAME_TABLES=`cd LANGDATA; echo *.lnm`
AC_SUBST(LANGNAME_TABLES)

AC_CONFIG_FILES([Makefile mapconv m17n-db m17n-db.pc
		 po/Makefile.in
		 LANGDATA/Makefile
		 ])
AC_OUTPUT

# Print configuration message.
if test "x$CHARMAPS" != "x"; then
  echo "------------------------------------------------------------"
  echo "Charset maps are generated from files under the directory:"
  echo "  $CHARMAPS/"
  echo "------------------------------------------------------------"
else
  echo "-----------ERROR-----------ERROR-----------ERROR------------"
  echo "Can't find source files for generating charset maps."
  echo "Run the script \"./get-glibc.sh\", and try again."
  echo "Or, read the installation procedure in the file README."
  echo "  --with-charmaps=--DIRECTORY-OF-GLIBC-SOURCE--/localedata/charmaps"
  echo "-----------ERROR-----------ERROR-----------ERROR------------"
fi
