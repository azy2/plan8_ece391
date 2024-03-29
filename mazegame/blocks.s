#									tab:8
#
# blocks.s
#
# "Copyright (c) 2004-2009 by Steven S. Lumetta."
#
# Permission to use, copy, modify, and distribute this software and its
# documentation for any purpose, without fee, and without written agreement is
# hereby granted, provided that the above copyright notice and the following
# two paragraphs appear in all copies of this software.
#
# IN NO EVENT SHALL THE AUTHOR OR THE UNIVERSITY OF ILLINOIS BE LIABLE TO
# ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
# DAMAGES ARISING OUT  OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION,
# EVEN IF THE AUTHOR AND/OR THE UNIVERSITY OF ILLINOIS HAS BEEN ADVISED
# OF THE POSSIBILITY OF SUCH DAMAGE.
#
# THE AUTHOR AND THE UNIVERSITY OF ILLINOIS SPECIFICALLY DISCLAIM ANY
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE
# PROVIDED HEREUNDER IS ON AN "AS IS" BASIS, AND NEITHER THE AUTHOR NOR
# THE UNIVERSITY OF ILLINOIS HAS ANY OBLIGATION TO PROVIDE MAINTENANCE,
# SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS."
#
# Author:	    Steve Lumetta
# Version:	    2
# Creation Date:    Thu Sep  9 22:09:54 2004
# Filename:	    blocks.s
# History:
#	SL	1	Thu Sep  9 22:09:54 2004
#		First written.
# 	SL	2	Sat Sep 12 14:25:10 2009
#		Edited comments to avoid flaky assembler errors.
#


#
# see blocks.h for descriptions of blocks ; the first 16 are walls with
# possible connections to adjacent walls
#
.GLOBAL blocks

blocks:
# 0 -- none
.BYTE 0x31, 0x31, 0x31, 0x32, 0x32, 0x32, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x32, 0x32, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x32, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x32, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x33, 0x32
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x33, 0x32
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x32, 0x31
.BYTE 0x31, 0x32, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x32, 0x31
.BYTE 0x31, 0x32, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x32, 0x31
.BYTE 0x31, 0x32, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x31, 0x31
.BYTE 0x31, 0x32, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31

# 1 -- up
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31

# 02 -- right
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31

# 3 -- up and right
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x21, 0x21
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31

# 4 -- down
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31

# 5 -- up and down
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31

# 6 -- right and down
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x21, 0x21
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31

# 7 -- up, right, and down
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x21, 0x21
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x21, 0x21
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31

# 8 -- left
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31

# 9 -- up and left
.BYTE 0x31, 0x34, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x34, 0x3C, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x30, 0x31
.BYTE 0x21, 0x21, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x30, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x30, 0x32
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x30, 0x32
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x30, 0x32
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x30, 0x32
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x32
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x32
.BYTE 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x31, 0x31
.BYTE 0x31, 0x30, 0x30, 0x30, 0x30, 0x30, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31

# 10 -- right and left
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x32, 0x32, 0x32, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x32, 0x32, 0x32, 0x32, 0x33, 0x33, 0x33, 0x32, 0x32, 0x32, 0x31
.BYTE 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21
.BYTE 0x30, 0x30, 0x30, 0x31, 0x31, 0x31, 0x30, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31

# 11 -- up, right, and left
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x21, 0x21, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x21, 0x21
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31

# 12 -- down and left
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x21, 0x21, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31

# 13 -- up, down, and left
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x21, 0x21, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x21, 0x21, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31

# 14 -- right, down, and left
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31
.BYTE 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21, 0x21
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x21, 0x21, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x21, 0x21
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31

# 15 -- up, right, down, and left
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x21, 0x21, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x21, 0x21
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22
.BYTE 0x21, 0x21, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x21, 0x21
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31
.BYTE 0x31, 0x31, 0x21, 0x22, 0x22, 0x22, 0x22, 0x22, 0x22, 0x21, 0x31, 0x31

# 16 -- empty
.BYTE 0x31, 0x31, 0x31, 0x32, 0x33, 0x32, 0x32, 0x32, 0x32, 0x32, 0x31, 0x31
.BYTE 0x31, 0x31, 0x31, 0x32, 0x33, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32
.BYTE 0x31, 0x31, 0x31, 0x32, 0x33, 0x33, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32
.BYTE 0x31, 0x32, 0x32, 0x32, 0x33, 0x33, 0x33, 0x32, 0x32, 0x32, 0x31, 0x32
.BYTE 0x31, 0x32, 0x32, 0x33, 0x33, 0x32, 0x32, 0x32, 0x32, 0x31, 0x31, 0x32
.BYTE 0x32, 0x32, 0x32, 0x33, 0x34, 0x32, 0x32, 0x31, 0x30, 0x31, 0x32, 0x32
.BYTE 0x32, 0x32, 0x33, 0x33, 0x34, 0x32, 0x32, 0x31, 0x30, 0x32, 0x32, 0x32
.BYTE 0x32, 0x33, 0x33, 0x34, 0x34, 0x33, 0x32, 0x31, 0x32, 0x32, 0x32, 0x32
.BYTE 0x32, 0x33, 0x33, 0x34, 0x34, 0x33, 0x32, 0x32, 0x32, 0x32, 0x32, 0x31
.BYTE 0x32, 0x32, 0x33, 0x33, 0x34, 0x33, 0x32, 0x32, 0x32, 0x32, 0x31, 0x31
.BYTE 0x31, 0x32, 0x32, 0x33, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x31, 0x31
.BYTE 0x31, 0x31, 0x32, 0x32, 0x33, 0x32, 0x32, 0x32, 0x32, 0x32, 0x31, 0x31

# 17 -- shrouded
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18

# 18 -- player going up
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x17, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x17, 0x00
.BYTE 0x00, 0x18, 0x00, 0x00, 0x07, 0x07, 0x07, 0x07, 0x00, 0x00, 0x18, 0x00
.BYTE 0x00, 0x18, 0x00, 0x07, 0x07, 0x20, 0x20, 0x07, 0x07, 0x00, 0x18, 0x00
.BYTE 0x00, 0x19, 0x00, 0x07, 0x20, 0x20, 0x20, 0x20, 0x07, 0x00, 0x19, 0x00
.BYTE 0x00, 0x19, 0x1A, 0x07, 0x20, 0x20, 0x20, 0x20, 0x07, 0x1A, 0x19, 0x00
.BYTE 0x00, 0x1A, 0x1A, 0x07, 0x20, 0x20, 0x20, 0x20, 0x07, 0x1A, 0x1A, 0x00
.BYTE 0x00, 0x00, 0x00, 0x07, 0x07, 0x20, 0x20, 0x07, 0x07, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x07, 0x07, 0x07, 0x07, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

# 19 -- player going right
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x1A, 0x19, 0x19, 0x18, 0x18, 0x17, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x1A, 0x1A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x07, 0x07, 0x07, 0x07, 0x07, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x07, 0x07, 0x20, 0x20, 0x20, 0x07, 0x07, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x07, 0x20, 0x20, 0x20, 0x20, 0x20, 0x07, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x07, 0x20, 0x20, 0x20, 0x20, 0x20, 0x07, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x07, 0x07, 0x20, 0x20, 0x20, 0x07, 0x07, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x07, 0x07, 0x07, 0x07, 0x07, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x1A, 0x1A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x1A, 0x19, 0x19, 0x18, 0x18, 0x17, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

# 20 -- player going down
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x07, 0x07, 0x07, 0x07, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x07, 0x07, 0x20, 0x20, 0x07, 0x07, 0x00, 0x00, 0x00
.BYTE 0x00, 0x1A, 0x1A, 0x07, 0x20, 0x20, 0x20, 0x20, 0x07, 0x1A, 0x1A, 0x00
.BYTE 0x00, 0x19, 0x1A, 0x07, 0x20, 0x20, 0x20, 0x20, 0x07, 0x1A, 0x19, 0x00
.BYTE 0x00, 0x19, 0x00, 0x07, 0x20, 0x20, 0x20, 0x20, 0x07, 0x00, 0x19, 0x00
.BYTE 0x00, 0x18, 0x00, 0x07, 0x07, 0x20, 0x20, 0x07, 0x07, 0x00, 0x18, 0x00
.BYTE 0x00, 0x18, 0x00, 0x00, 0x07, 0x07, 0x07, 0x07, 0x00, 0x00, 0x18, 0x00
.BYTE 0x00, 0x17, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x17, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

# 21 -- player going left
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x17, 0x18, 0x18, 0x19, 0x19, 0x1A, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1A, 0x1A, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x07, 0x07, 0x07, 0x07, 0x07, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x07, 0x07, 0x20, 0x20, 0x20, 0x07, 0x07, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x07, 0x20, 0x20, 0x20, 0x20, 0x20, 0x07, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x07, 0x20, 0x20, 0x20, 0x20, 0x20, 0x07, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x07, 0x07, 0x20, 0x20, 0x20, 0x07, 0x07, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x07, 0x07, 0x07, 0x07, 0x07, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1A, 0x1A, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x17, 0x18, 0x18, 0x19, 0x19, 0x1A, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

# 22 -- player going up mask
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01
.BYTE 0x01, 0x01, 0x01, 0x00, 0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 0x01, 0x01
.BYTE 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
.BYTE 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
.BYTE 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
.BYTE 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
.BYTE 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
.BYTE 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
.BYTE 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

# 23 -- player going right mask
.BYTE 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
.BYTE 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
.BYTE 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
.BYTE 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00
.BYTE 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00
.BYTE 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00
.BYTE 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00
.BYTE 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00
.BYTE 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
.BYTE 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00

# 24 -- player going down mask
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00
.BYTE 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
.BYTE 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
.BYTE 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
.BYTE 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
.BYTE 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
.BYTE 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01
.BYTE 0x01, 0x01, 0x01, 0x00, 0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 0x01, 0x01
.BYTE 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

# 25 -- player going left mask
.BYTE 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00
.BYTE 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00
.BYTE 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00
.BYTE 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
.BYTE 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
.BYTE 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
.BYTE 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00
.BYTE 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00
.BYTE 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00
.BYTE 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00
.BYTE 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00

# 26 -- fruit #1 -- Andrew's red apple
.BYTE 0x31, 0x02, 0x31, 0x31, 0x31, 0x31, 0x06, 0x31, 0x31, 0x31, 0x32, 0x32
.BYTE 0x02, 0x0A, 0x0A, 0x02, 0x30, 0x06, 0x30, 0x30, 0x30, 0x31, 0x31, 0x32
.BYTE 0x30, 0x02, 0x02, 0x02, 0x02, 0x06, 0x02, 0x02, 0x02, 0x30, 0x30, 0x32
.BYTE 0x30, 0x30, 0x30, 0x04, 0x0C, 0x04, 0x04, 0x02, 0x02, 0x02, 0x30, 0x30
.BYTE 0x31, 0x30, 0x04, 0x0C, 0x04, 0x04, 0x04, 0x04, 0x02, 0x02, 0x02, 0x30
.BYTE 0x31, 0x30, 0x04, 0x0C, 0x04, 0x04, 0x04, 0x04, 0x04, 0x30, 0x30, 0x31
.BYTE 0x31, 0x30, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x30, 0x32, 0x32
.BYTE 0x31, 0x30, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x30, 0x32, 0x32
.BYTE 0x32, 0x30, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x30, 0x32, 0x32
.BYTE 0x32, 0x30, 0x30, 0x04, 0x04, 0x04, 0x04, 0x04, 0x30, 0x30, 0x32, 0x32
.BYTE 0x32, 0x32, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x32, 0x32, 0x32
.BYTE 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32

# 27 -- fruit #2 -- grapes
.BYTE 0x33, 0x32, 0x32, 0x32, 0x32, 0x32, 0x31, 0x31, 0x32, 0x31, 0x0A, 0x31
.BYTE 0x32, 0x32, 0x32, 0x31, 0x31, 0x31, 0x0D, 0x05, 0x00, 0x0A, 0x31, 0x32
.BYTE 0x32, 0x32, 0x31, 0x0D, 0x05, 0x00, 0x05, 0x05, 0x05, 0x0A, 0x31, 0x32
.BYTE 0x32, 0x32, 0x31, 0x05, 0x05, 0x05, 0x00, 0x05, 0x02, 0x31, 0x32, 0x32
.BYTE 0x33, 0x32, 0x31, 0x00, 0x05, 0x0D, 0x00, 0x0D, 0x05, 0x31, 0x32, 0x32
.BYTE 0x32, 0x31, 0x0D, 0x05, 0x00, 0x00, 0x00, 0x05, 0x05, 0x05, 0x31, 0x32
.BYTE 0x32, 0x31, 0x05, 0x05, 0x05, 0x0D, 0x05, 0x00, 0x05, 0x00, 0x32, 0x32
.BYTE 0x32, 0x32, 0x31, 0x05, 0x00, 0x05, 0x05, 0x05, 0x0D, 0x05, 0x31, 0x31
.BYTE 0x32, 0x32, 0x31, 0x00, 0x00, 0x00, 0x05, 0x00, 0x05, 0x05, 0x05, 0x31
.BYTE 0x32, 0x32, 0x31, 0x0D, 0x05, 0x00, 0x0D, 0x05, 0x00, 0x05, 0x31, 0x32
.BYTE 0x32, 0x31, 0x31, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x31, 0x30, 0x31
.BYTE 0x31, 0x31, 0x32, 0x31, 0x05, 0x31, 0x31, 0x05, 0x31, 0x32, 0x31, 0x31

# 28 -- fruit #3 -- Justin's white peach
.BYTE 0x31, 0x32, 0x32, 0x31, 0x06, 0x30, 0x30, 0x31, 0x32, 0x32, 0x32, 0x32
.BYTE 0x31, 0x32, 0x32, 0x31, 0x30, 0x06, 0x30, 0x31, 0x32, 0x32, 0x32, 0x32
.BYTE 0x31, 0x32, 0x32, 0x31, 0x30, 0x06, 0x30, 0x31, 0x31, 0x32, 0x32, 0x32
.BYTE 0x31, 0x32, 0x31, 0x0E, 0x0C, 0x06, 0x0C, 0x0E, 0x31, 0x32, 0x32, 0x32
.BYTE 0x31, 0x31, 0x0E, 0x0C, 0x0C, 0x0C, 0x0F, 0x0E, 0x0E, 0x31, 0x32, 0x32
.BYTE 0x32, 0x31, 0x0E, 0x0C, 0x0C, 0x0F, 0x0E, 0x0E, 0x0E, 0x31, 0x32, 0x32
.BYTE 0x32, 0x31, 0x0E, 0x0C, 0x0C, 0x0F, 0x0E, 0x0E, 0x0E, 0x31, 0x32, 0x32
.BYTE 0x32, 0x31, 0x0E, 0x0C, 0x0F, 0x0E, 0x0E, 0x0E, 0x0E, 0x31, 0x32, 0x32
.BYTE 0x32, 0x31, 0x0E, 0x0C, 0x0F, 0x0E, 0x0E, 0x0E, 0x0E, 0x31, 0x33, 0x32
.BYTE 0x32, 0x32, 0x31, 0x0C, 0x0F, 0x0E, 0x0E, 0x0E, 0x31, 0x32, 0x33, 0x32
.BYTE 0x32, 0x32, 0x32, 0x31, 0x0C, 0x0E, 0x0E, 0x31, 0x32, 0x32, 0x32, 0x33
.BYTE 0x31, 0x31, 0x32, 0x32, 0x31, 0x31, 0x31, 0x32, 0x32, 0x32, 0x32, 0x33

# 29 -- fruit #4 -- strawberry
.BYTE 0x32, 0x31, 0x02, 0x0A, 0x31, 0x02, 0x31, 0x32, 0x32, 0x32, 0x31, 0x31
.BYTE 0x32, 0x32, 0x31, 0x02, 0x02, 0x0A, 0x02, 0x31, 0x32, 0x32, 0x32, 0x31
.BYTE 0x32, 0x31, 0x31, 0x04, 0x02, 0x04, 0x04, 0x04, 0x31, 0x32, 0x32, 0x32
.BYTE 0x32, 0x31, 0x0C, 0x04, 0x04, 0x04, 0x0C, 0x04, 0x04, 0x31, 0x32, 0x32
.BYTE 0x32, 0x31, 0x04, 0x04, 0x04, 0x0C, 0x04, 0x04, 0x04, 0x31, 0x32, 0x32
.BYTE 0x32, 0x31, 0x04, 0x0C, 0x04, 0x04, 0x04, 0x0C, 0x04, 0x31, 0x32, 0x32
.BYTE 0x32, 0x31, 0x0C, 0x04, 0x0C, 0x04, 0x04, 0x04, 0x04, 0x31, 0x32, 0x32
.BYTE 0x32, 0x31, 0x04, 0x04, 0x04, 0x04, 0x0C, 0x04, 0x0C, 0x31, 0x32, 0x32
.BYTE 0x32, 0x31, 0x31, 0x04, 0x0C, 0x04, 0x04, 0x04, 0x04, 0x31, 0x32, 0x33
.BYTE 0x32, 0x32, 0x31, 0x0C, 0x04, 0x04, 0x0C, 0x04, 0x31, 0x31, 0x32, 0x33
.BYTE 0x32, 0x32, 0x31, 0x04, 0x04, 0x04, 0x04, 0x04, 0x31, 0x32, 0x32, 0x32
.BYTE 0x31, 0x32, 0x32, 0x31, 0x0C, 0x04, 0x04, 0x31, 0x32, 0x32, 0x32, 0x31

# 30 -- fruit #5 -- banana
.BYTE 0x31, 0x06, 0x31, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x31, 0x31, 0x31
.BYTE 0x31, 0x06, 0x31, 0x32, 0x32, 0x32, 0x31, 0x32, 0x32, 0x32, 0x31, 0x31
.BYTE 0x31, 0x06, 0x0E, 0x31, 0x32, 0x32, 0x32, 0x31, 0x32, 0x32, 0x32, 0x32
.BYTE 0x31, 0x0E, 0x0E, 0x31, 0x32, 0x32, 0x32, 0x32, 0x33, 0x33, 0x32, 0x32
.BYTE 0x31, 0x0E, 0x0E, 0x0E, 0x31, 0x32, 0x32, 0x32, 0x32, 0x33, 0x33, 0x32
.BYTE 0x32, 0x31, 0x0E, 0x0E, 0x0E, 0x31, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32
.BYTE 0x32, 0x31, 0x0E, 0x0F, 0x0E, 0x0E, 0x31, 0x31, 0x31, 0x31, 0x32, 0x32
.BYTE 0x32, 0x32, 0x31, 0x0E, 0x0F, 0x0E, 0x0E, 0x0E, 0x0E, 0x06, 0x31, 0x32
.BYTE 0x39, 0x32, 0x32, 0x31, 0x0E, 0x0F, 0x0E, 0x0E, 0x0E, 0x0E, 0x06, 0x31
.BYTE 0x32, 0x31, 0x32, 0x32, 0x31, 0x0E, 0x0E, 0x0E, 0x0E, 0x31, 0x31, 0x32
.BYTE 0x32, 0x31, 0x31, 0x32, 0x32, 0x31, 0x31, 0x31, 0x31, 0x32, 0x32, 0x32
.BYTE 0x31, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32

# 31 -- fruit #6 -- watermelon
.BYTE 0x32, 0x32, 0x32, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x32, 0x32, 0x32
.BYTE 0x32, 0x32, 0x31, 0x31, 0x0A, 0x0A, 0x0A, 0x0A, 0x31, 0x31, 0x32, 0x32
.BYTE 0x32, 0x31, 0x0A, 0x0A, 0x02, 0x02, 0x0A, 0x0A, 0x0A, 0x0A, 0x31, 0x32
.BYTE 0x31, 0x0A, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x0A, 0x0A, 0x31
.BYTE 0x02, 0x02, 0x02, 0x02, 0x0A, 0x0A, 0x0A, 0x02, 0x02, 0x02, 0x02, 0x0A
.BYTE 0x02, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x02, 0x02
.BYTE 0x0A, 0x0A, 0x0A, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x0A, 0x0A, 0x0A
.BYTE 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02
.BYTE 0x31, 0x0A, 0x0A, 0x0A, 0x02, 0x02, 0x02, 0x0A, 0x0A, 0x0A, 0x0A, 0x31
.BYTE 0x32, 0x31, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x02, 0x02, 0x02, 0x31, 0x32
.BYTE 0x32, 0x32, 0x31, 0x31, 0x02, 0x02, 0x02, 0x02, 0x31, 0x31, 0x32, 0x32
.BYTE 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32

# 32 -- fruit #7 -- Dew
.BYTE 0x31, 0x31, 0x32, 0x32, 0x31, 0x02, 0x02, 0x31, 0x32, 0x32, 0x31, 0x31
.BYTE 0x32, 0x32, 0x32, 0x31, 0x31, 0x02, 0x02, 0x31, 0x31, 0x32, 0x31, 0x32
.BYTE 0x32, 0x32, 0x32, 0x31, 0x02, 0x08, 0x08, 0x02, 0x31, 0x32, 0x31, 0x32
.BYTE 0x32, 0x32, 0x32, 0x31, 0x04, 0x02, 0x02, 0x04, 0x31, 0x32, 0x32, 0x32
.BYTE 0x32, 0x33, 0x32, 0x31, 0x0A, 0x04, 0x04, 0x0A, 0x31, 0x32, 0x32, 0x32
.BYTE 0x32, 0x33, 0x32, 0x31, 0x0A, 0x0F, 0x0F, 0x0A, 0x31, 0x32, 0x32, 0x32
.BYTE 0x32, 0x33, 0x32, 0x31, 0x0A, 0x0F, 0x0A, 0x0F, 0x31, 0x32, 0x32, 0x32
.BYTE 0x32, 0x32, 0x32, 0x31, 0x0A, 0x0F, 0x0A, 0x0F, 0x31, 0x32, 0x33, 0x32
.BYTE 0x32, 0x32, 0x32, 0x31, 0x0A, 0x0F, 0x0F, 0x0A, 0x31, 0x32, 0x33, 0x32
.BYTE 0x32, 0x32, 0x32, 0x31, 0x04, 0x0A, 0x0A, 0x04, 0x31, 0x32, 0x32, 0x32
.BYTE 0x31, 0x32, 0x32, 0x31, 0x02, 0x04, 0x04, 0x02, 0x31, 0x32, 0x32, 0x32
.BYTE 0x31, 0x32, 0x32, 0x31, 0x31, 0x02, 0x02, 0x31, 0x31, 0x32, 0x31, 0x31

# 33 -- hidden fruit
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x19, 0x19, 0x19, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x19, 0x1A, 0x1A, 0x19, 0x18, 0x17, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x19, 0x1A, 0x1A, 0x1A, 0x1A, 0x18, 0x17, 0x17, 0x18, 0x18
.BYTE 0x18, 0x18, 0x19, 0x1A, 0x1A, 0x1A, 0x19, 0x18, 0x17, 0x17, 0x18, 0x18
.BYTE 0x18, 0x18, 0x19, 0x1A, 0x1A, 0x19, 0x18, 0x17, 0x16, 0x17, 0x18, 0x18
.BYTE 0x18, 0x18, 0x19, 0x1A, 0x19, 0x18, 0x18, 0x17, 0x16, 0x17, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x19, 0x19, 0x18, 0x17, 0x16, 0x17, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x17, 0x17, 0x17, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18
.BYTE 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18

# 34 -- exit
.BYTE 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32
.BYTE 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x0F, 0x0F, 0x0F, 0x00, 0x0F, 0x00, 0x0F, 0x00, 0x0F, 0x0F, 0x0F, 0x00
.BYTE 0x0F, 0x00, 0x0F, 0x00, 0x0F, 0x00, 0x0F, 0x00, 0x00, 0x0F, 0x00, 0x00
.BYTE 0x0F, 0x00, 0x0F, 0x00, 0x0F, 0x00, 0x0F, 0x00, 0x00, 0x0F, 0x00, 0x00
.BYTE 0x0F, 0x00, 0x0F, 0x00, 0x0F, 0x00, 0x0F, 0x00, 0x00, 0x0F, 0x00, 0x00
.BYTE 0x0F, 0x00, 0x0F, 0x00, 0x0F, 0x00, 0x0F, 0x00, 0x00, 0x0F, 0x00, 0x00
.BYTE 0x0F, 0x00, 0x0F, 0x00, 0x0F, 0x00, 0x0F, 0x00, 0x00, 0x0F, 0x00, 0x00
.BYTE 0x0F, 0x0F, 0x0F, 0x00, 0x0F, 0x0F, 0x0F, 0x00, 0x00, 0x0F, 0x00, 0x00
.BYTE 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
.BYTE 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32, 0x32
