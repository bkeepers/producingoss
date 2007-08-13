LANGUAGES=de en fr he ja pl zh ml es

.PHONY: ${LANGUAGES}
${LANGUAGES}: 
	@cd $@; make -f ../lang-makefile all; cd ..

all:
	@for name in ${LANGUAGES}; do                \
          cd $${name}; make -f ../lang-makefile all; \
          cd ..;                                     \
        done

# The web site post-commit hook runs 'make www'.
www: lang-www dist
lang-www:
	@for name in ${LANGUAGES}; do                \
          cd $${name}; make -f ../lang-makefile www; \
          cd ..;                                     \
        done

clean:
	@for name in ${LANGUAGES}; do                  \
          cd $${name}; make -f ../lang-makefile clean; \
          cd ..;                                       \
        done

upload: all
	@for d in ${LANGUAGES}; do cd $${d};                                \
          scp producingoss.pdf                                              \
            kfogel@sp.red-bean.com:/www/producingoss/$${d}/pnew.pdf;        \
          ssh kfogel@sp.red-bean.com                                        \
            "(cd /www/producingoss/$${d} && mv pnew.pdf producingoss.pdf)"; \
          scp producingoss.ps                                               \
            kfogel@sp.red-bean.com:/www/producingoss/$${d}/pnew.ps;         \
          ssh kfogel@sp.red-bean.com                                        \
            "(cd /www/producingoss/$${d} && mv pnew.ps producingoss.ps)";   \
          cd ..;                                                            \
        done

dist:
	@rm -rf tmp
	@mkdir tmp
	@svnversion -n . > tmp/rev
	@if cat tmp/rev | grep --silent ":"; then                          \
          echo -n "Cannot make dist from a mixed-revision working copy: "; \
          cat tmp/rev;                                                     \
          echo "";                                                         \
          exit 1;                                                          \
        fi
	@if cat tmp/rev | grep --silent "M"; then                          \
          echo -n "Cannot make dist from a modified working copy: ";       \
          cat tmp/rev;                                                     \
          echo "";                                                         \
          exit 1;                                                          \
        fi
	@echo -n "1." > tmp/vn
	@cat tmp/rev >> tmp/vn
	@mkdir tmp/producingoss-`cat tmp/vn`
	@cp COPYING README styles.css Makefile lang-makefile \
          tmp/producingoss-`cat tmp/vn`
	@for d in ??; do cp -a $${d} tmp/producingoss-`cat tmp/vn`/; done
	@find tmp -name ".svn" | xargs rm -rf
	@find tmp -name "*.ps" | xargs rm -rf
	@(cd tmp; tar zcvf producingoss-`cat vn`.tar.gz producingoss-`cat vn`)
	@(cd tmp; zip -r producingoss-`cat vn`.zip producingoss-`cat vn`)
	@if [ -f tmp/producingoss-`cat tmp/vn`.tar.gz ]; then \
           rm -rf producingoss-*.tar.gz;                      \
        fi
	@if [ -f tmp/producingoss-`cat tmp/vn`.zip ]; then \
           rm -rf producingoss-*.zip;                      \
        fi
	@mv tmp/producingoss-`cat tmp/vn`.tar.gz .
	@mv tmp/producingoss-`cat tmp/vn`.zip .
	@sed -e "s/REPLACEME/producingoss-`cat tmp\/vn`/g" \
          < download.html.tmpl > download.html
	@rm -rf tmp
