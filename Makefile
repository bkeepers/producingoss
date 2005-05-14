SHELL = /bin/sh
SVN = svn
SVNVERSION = svnversion
XSLTPROC = xsltproc

TOP = .
HTML_TARGET = ${TOP}/book.html
HTML_CHUNK_DIR = ${TOP}/html-chunk
HTML_CHUNK_TARGET = ${HTML_CHUNK_DIR}/index.html  # created last
PDF_TARGET = ${TOP}/book.pdf
PS_TARGET = ${TOP}/book.ps
FO_TARGET = ${TOP}/book.fo
XML_ROOT = ${TOP}/book.xml
ALL_SOURCE = ${TOP}/*.xml

XSL_FO = ${TOP}/tools/fo-stylesheet.xsl
XSL_HTML = ${TOP}/tools/html-stylesheet.xsl
XSL_HTML_CHUNK = ${TOP}/tools/chunk-stylesheet.xsl

RUN_FOP = ${TOP}/tools/bin/run-fop.sh

# Book xsltproc options for HTML output
# Note: --stringparam arguments no longer go here; 
# see tools/html-stylesheet.xsl and tools/chunk-stylesheet.xsl
HTML_XSLTPROC_OPTS = 

# Book xsltproc options for PDF and PostScript output
# PDF_XSLTPROC_OPTS = --stringparam page.height 9in --stringparam page.width 6.4in
# PS_XSLTPROC_OPTS = --stringparam page.height 9in --stringparam page.width 6.4in

all: all-html all-pdf all-ps

# The web site post-commit hook runs 'make www'.
www: html

install:
	@echo "No installation procedure yet."

all-html: html html-chunk

all-pdf: pdf

all-ps: ps

clean:
	@echo "Clean rule not implemented yet."


# HTML monolithic.
html: ${HTML_TARGET}

${HTML_TARGET}: ${ALL_SOURCE} ${TOP}/styles.css
	${XSLTPROC} ${HTML_XSLTPROC_OPTS} \
           --output ${HTML_TARGET} ${XSL_HTML} ${XML_ROOT}


# HTML chunked.
html-chunk: ${HTML_CHUNK_TARGET}

${HTML_CHUNK_TARGET}: ${ALL_SOURCE} ${TOP}/styles.css
	mkdir -p ${HTML_CHUNK_DIR}
	${XSLTPROC} ${HTML_XSLTPROC_OPTS} \
           --output ${HTML_CHUNK_DIR}/    \
            ${XSL_HTML_CHUNK} ${XML_ROOT}
	cp ${TOP}/styles.css ${HTML_CHUNK_DIR}


# PDF.
pdf: ${PDF_TARGET}

${PDF_TARGET}: ${ALL_SOURCE}
	${XSLTPROC} ${PDF_XSLTPROC_OPTS} \
	   --output ${FO_TARGET} ${XSL_FO} ${XML_ROOT}
	${RUN_FOP} ${TOP} -fo ${FO_TARGET} -pdf ${PDF_TARGET}


# PostScript.
ps: ${PS_TARGET}

${PS_TARGET}: ${ALL_SOURCE}
	${XSLTPROC} ${PS_XSLTPROC_OPTS} \
	   --output ${FO_TARGET} ${XSL_FO} ${XML_ROOT}
	${RUN_FOP} ${TOP} -fo ${FO_TARGET} -ps ${PS_TARGET}
