# CASED.awk -- awk script to generate CASED.tab
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
# Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301, USA.

BEGIN {
  tohex["0"] = 1;
  tohex["1"] = 2;
  tohex["2"] = 3;
  tohex["3"] = 4;
  tohex["4"] = 5;
  tohex["5"] = 6;
  tohex["6"] = 7;
  tohex["7"] = 8;
  tohex["8"] = 9;
  tohex["9"] = 10;
  tohex["A"] = 11;
  tohex["B"] = 12;
  tohex["C"] = 13;
  tohex["D"] = 14;
  tohex["E"] = 15;
  tohex["F"] = 16;
  tohex["a"] = 11;
  tohex["b"] = 12;
  tohex["c"] = 13;
  tohex["d"] = 14;
  tohex["e"] = 15;
  tohex["f"] = 16;

  FS = "[ \t]*[;#][ \t]*";
}

function decode_hex(str, idx) {
  n = 0;
  len = length(str);
  for (i = idx; i <= len; i++)
    {
      c = tohex[substr(str, i, 1)];
      if (c == 0)
	break;
      n = n * 16 + c - 1;
    }
  return n;
}

function single(str, bit) {
  i = decode_hex(str, 1);
  if (cased[i] != bit)
    cased[i] += bit;
}

function range(str, bit) {
  end = decode_hex(str, index(str, "..") + 2);
  for (i = decode_hex(str, 1); i <= end; i++)
    if (cased[i] != bit)
      cased[i] += bit;
}

/^[^#]/ {
  if (FILENAME == "UNIDATA/UnicodeData.txt") {
    if ($3 ~ /L[ltu]/)
      single($1, 1);
    else if ($3 ~ /Mn|Me|Cf|Lm|Sk/)
      single($1, 2);
  }

  else if (FILENAME == "UNIDATA/PropList.txt") {
    if ($2 ~ /Other_(Upp|Low)ercase/) {
      if (index($1, "."))
	range($1, 1);
      else
	single($1, 1);
    }
  }

  else {			# FILE == "WordBreakProperty.txt"
    if ($2 == "MidLetter") {
      if (index($1, "."))
	range($1, 2);
      else
	single($1, 2);
    }
  }
}

END {
  for (i in cased)
    printf ("0x%X %d\n", i, cased[i]);
}
