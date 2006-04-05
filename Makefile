include tools/Makefile.base-vars
TOOLS_DIR = tools
NAME = producingoss
OUTNAME = $(NAME)
XML_SOURCE = book.xml
# Suppress svnversion for now
VERSION_SOURCE = 

all: html html-chunk pdf ps xmldist

upload: all
	scp producingoss.pdf \
            kfogel@sp.red-bean.com:/www/producingoss/producingoss.pdf.NEW
	ssh kfogel@sp.red-bean.com \
          "(cd /www/producingoss && mv producingoss.pdf.NEW producingoss.pdf)"
	scp producingoss.ps \
            kfogel@sp.red-bean.com:/www/producingoss/producingoss.ps.NEW
	ssh kfogel@sp.red-bean.com \
          "(cd /www/producingoss && mv producingoss.ps.NEW producingoss.ps)"

# The web site post-commit hook runs 'make www'.
www: all-html xmldist

xmldist:
	rm -rf producingoss-xml
	mkdir producingoss-xml
	cp COPYING README Makefile *.xml producingoss-xml
	tar zcvf producingoss-xml.tar.gz producingoss-xml
	rm -rf producingoss-xml

include tools/Makefile.base-rules
