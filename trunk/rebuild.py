#!/usr/bin/python

# Rebuild one of the ProducingOSS languages, showing errors to browser.

import os
import os.path
import sys
import subprocess
import cgi
import types
import string
import cgitb; cgitb.enable()

# EZT comes from the ezt/ subdir here.
sys.path.insert(0, "ezt")
import ezt


form = cgi.FieldStorage()

# Two letter ISO language code, e.g., "en", "de", "zh", etc.
lang = form.getvalue('lang')

# Safety check: ensure that lang is a two-letter string and is one of
# the approved languages.
if (not isinstance (lang, str)) or (len(lang) != 2):
  raise Exception("Error: Invalid language code.  " \
                    "Need a two-letter ISO 639-1 or 639-2 code.\n")
if not lang[0].isalpha() or not lang[1].isalpha():
  raise Exception("Error: Invalid language code: must be alphabetic.\n")
if not os.path.isdir(lang):
  raise Exception("Error: Invalid language code: " \
                    "we don't support '%s'\n" % lang)

# There must be a more elegant way to do this, hmmm.
def escape_html(s):
  return string.replace(string.replace(string.replace(s, '&', '&amp;'),
                                       '<', '&lt;'),
                        '>', '&gt;')

proc = subprocess.Popen(["echo -n 'Build started '; "
                         + "date; "                   
                         + "echo; "                   
                         + "make %s 2>&1; " % lang    
                         + "echo; "                   
                         + "echo 'Please check the sizes and dates on the result files:'; "
                         + "echo;"
                         + "echo -n '  '; ls -g -G -h -l --time-style='+%%a %%b %%e %%T %%Z %%Y' %s/index.html | cut -d ' ' -f 3-; " % lang
                         + "echo -n '  '; ls -g -G -h -l --time-style='+%%a %%b %%e %%T %%Z %%Y' %s/producingoss.html | cut -d ' ' -f 3-; " % lang
                         + "echo -n '  '; ls -g -G -h -l --time-style='+%%a %%b %%e %%T %%Z %%Y' %s/producingoss.pdf | cut -d ' ' -f 3-; " % lang
                         + "echo;"
                         + "echo -n 'Build finished '; "
                         + "date; "
                         ], stdout=subprocess.PIPE, shell=True)
(out, err) = proc.communicate()

ezt_template = ezt.Template("rebuild.ezt")
ezt_data = { 'lang' : lang,
             'out' : out,
             'err' : err,
             }
print "Content-type: text/html\n\n"
ezt_template.generate(sys.stdout, ezt_data)
