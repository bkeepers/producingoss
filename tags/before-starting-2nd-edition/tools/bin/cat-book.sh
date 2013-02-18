#!/bin/bash

# cat-book.sh prints a book.xml to standard out that uses only
# those entities that are given as parameters. to be run from where the
# book.xml resides.

# usage: 
# ../tools/bin/cat-book.sh ch01 ch02 ch03 | xsltproc ../tools/html-stylesheet.xsl - > /tmp/poss.html
#
# map such a command to a key or something in your favorite editor:

# vim: :let &makeprg='../tools/bin/cat-book.sh %:r \| xsltproc ../tools/html-stylesheet.xsl - > /tmp/poss.html'
# 


# First print the static part of the book. 
# includes entity definitions,
# excludes booktitle etc.
cat <<EOF
<?xml version="1.0"?>
<!DOCTYPE book SYSTEM "../tools/dtd/dblite.dtd"
[
<!ENTITY dedication SYSTEM "dedication.xml">
<!ENTITY ch00       SYSTEM "ch00.xml">
<!ENTITY ch01       SYSTEM "ch01.xml">
<!ENTITY ch02       SYSTEM "ch02.xml">
<!ENTITY ch03       SYSTEM "ch03.xml">
<!ENTITY ch04       SYSTEM "ch04.xml">
<!ENTITY ch05       SYSTEM "ch05.xml">
<!ENTITY ch06       SYSTEM "ch06.xml">
<!ENTITY ch07       SYSTEM "ch07.xml">
<!ENTITY ch08       SYSTEM "ch08.xml">
<!ENTITY ch09       SYSTEM "ch09.xml">
<!ENTITY appa       SYSTEM "appa.xml">
<!ENTITY appb       SYSTEM "appb.xml">
<!ENTITY appc       SYSTEM "appc.xml">
<!ENTITY appd       SYSTEM "appd.xml">
<!ENTITY copyright  SYSTEM "copy.xml">
]>
EOF

# start book
grep "<book id=" book.xml

# add entities
while (($#))
do
  echo "&$1;"
  shift
done

# finish book
echo "</book>"
