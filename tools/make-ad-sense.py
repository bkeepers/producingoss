#!/usr/bin/python

"""Usage: 'make-ad-sense.py BOOK-HTML-DIR'

Add AdSense bits to BOOK-HTML-DIR/*.html.  Note that if you run this
twice, it will dumbly add the bits again, resulting in weirdness."""

import sys
import os
import os.path
import re

adsense_left_data = """
<div id="adsense_left">
<script type="text/javascript"><!--
// Text Ad: Skyscraper (120x600)
google_ad_client = "pub-0505104349866057";
google_ad_width = 120;
google_ad_height = 600;
google_ad_format = "120x600_as";
google_ad_channel = "";
google_color_border = "ffffff";
google_color_bg = "ffffff";
google_color_link = "0000ff";
google_color_url = "008000";
google_color_text = "000000";
//--></script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
</div>

"""

adsense_bottom_data = """
<div id="adsense_bottom">
<script type="text/javascript"><!--
// Text Ad: Medium Rectangle (300x250)
google_ad_client = "pub-0505104349866057";
google_ad_width = 300;
google_ad_height = 250;
google_ad_format = "300x250_as";
google_ad_channel = "";
google_color_border = "ffffff";
google_color_bg = "ffffff";
google_color_link = "0000ff";
google_color_url = "000000";
google_color_text = "000000";
//--></script>
<script type="text/javascript"
src="http://pagead2.googlesyndication.com/pagead/show_ads.js">
</script>
</div>

"""

adsense_css = """
/* Added for AdSense Support */
body
{
    margin-left: 130px;
    margin-right: 130px;
}
#adsense_left
{
    position: absolute;
    left: 0px; 
    top: 0.5in;
    width: 120px;
    z-index: 2;
}
#adsense_bottom
{
}
"""

def die(msg):
    sys.stderr.write(msg + "\n")
    sys.exit(1)

def add_adsense_left_html(file):
    lines = open(file, 'r').readlines()
    for i in range(len(lines)):
        start_offset = lines[i].find('<body')
        if start_offset == -1:
            continue
        for j in range(i, len(lines)):
            end_offset = lines[j][start_offset:].find('>')
            if end_offset == -1:
                start_offset = 0
            else:
                end_offset = start_offset + end_offset
                lines[j] = '%s%s%s' \
                           % (lines[j][:end_offset + 1],
                              adsense_left_data,
                              lines[j][end_offset + 1:])
                open(file, 'w').writelines(lines)
                return
    raise Exception, "Never found <body> tag in file '%s'" % (file)

def add_adsense_bottom_html(file):
    lines = open(file, 'r').readlines()
    for i in range(len(lines)):
        start_offset = lines[i].find('<div class="navfooter"')
        if start_offset == -1:
            continue
        lines[i] = '%s%s%s' \
                   % (lines[i][0:start_offset],
                      adsense_bottom_data,
                      lines[i][start_offset:])
        open(file, 'w').writelines(lines)
        return
    raise Exception, "Never found <div class=\"nav_footer\"> tag in file '%s'" % (file)

def add_adsense_css(file):
    open(file, 'a').write(adsense_css)

def main():
    if len(sys.argv) != 2:
        die("Usage: %s BOOK-DIR" % (os.path.basename(sys.argv[0])))
    book_dir = sys.argv[1]
    stylesheet = os.path.join(book_dir, 'styles.css')
    if not os.path.exists(stylesheet):
        die("Book stylesheet is missing.")
    for child in os.listdir(sys.argv[1]):
        if child[-5:] == '.html':
            try:
                add_adsense_left_html(os.path.join(book_dir, child))
            except:
                pass
            try:
                add_adsense_bottom_html(os.path.join(book_dir, child))
            except:
                pass
    add_adsense_css(stylesheet)

if __name__ == "__main__":
    main()
        
        
        
