# CASE-MAPPING.awk -- awk script to generate CASE-MAPPING.tab
# Copyright (C) 2005
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
# Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
# 02111-1307, USA.

BEGIN {
  FS = ";";
  FILE = 1;
}

function mtext (str) {
  if (n = split (str, A, " "))
    {
      printf ("\"");
      for (i = 1; i <= n; i++)
	printf ("\\u%s", A[i]);
      printf ("\"");
    }
  else
    printf ("\"\\u%s\"", str);
  printf (" ");
}

FILE == 1 && /^[^\#]/ && NF == 5 {
  printf ("0x%s ( ", $1);
  mtext ($2);
  mtext ($3);
  mtext ($4);
  printf (")\n");
  X[$1] = 1;
  next;
}

/^0000;/ {
  FILE = 2;
}

FILE == 2 && /^[^\#]/ && ($13 || $14 || $15) && ! X[$1] {
  if (! $13) $13 = $1;
  if (! $14) $14 = $1;
  if (! $15) $15 = $1;
  printf ("0x%s ( \"\\u%s\" \"\\u%s\" \"\\u%s\" )\n",
	  $1, $14, $15, $13);
}
