# strip newlines
:a;N;$!ba;s/\n/ /g

# get rid of footnotes (for now)
s|<span>\+</span>||g

# headings
s|<h2( [^>]*)?>([^<]+)</h2>|\n\n\\subsection{\2}|g
s|<h3( [^>]*)?>([^<]+)</h3>|\n\n\\subsection{\2}|g

# replace <p> tags with 2 newlines
s|<p( [^>]*)?>|\n\n|g

# small caps
s|<span class="nd">Lord</span>|\\textsc{Lord}|g
s|<span class="divine-name small-caps"><span class="small-caps-upper">L</span><span class="small-caps-lower">ord</span></span>|\\textsc{Lord}|g
s|<span class="time small-caps"><span class="small-caps-lower">b.c.</span></span>|\\textsc{b.c.}|g
s|<span class="time small-caps"><span class="small-caps-lower">a.d.</span></span>|\\textsc{a.d.}|g
s|LORD|\\textsc{Lord}|g

# verse numbers
s|<sup( [^>]*)?>([^<]+)</sup>|\\V{\2}|g
s|<b class="chapter-num"( [^>]*)?>([0-9]+)&nbsp;</b>|\\V{\2}|g
s|<b class="verse-num"( [^>]*)?>([0-9]+)&nbsp;</b>|\\V{\2}|g

# bold
s|<strong( [^>]*)?>|\\textbf\{|g
s|</strong>|}|g
s|<b( [^>]*)?>|\\textbf\{|g
s|</b>|}|g

# italic
s|<em( [^>]*)?>|\\textit\{|g
s|</em>|}|g
s|<i( [^>]*)?>|\\textit\{|g
s|</i>|}|g

# get rid of all other tags
s|<[^>]*>||g

# spaces before/after verse numbers
s|[ ]*\\V\{([0-9]+)\}[ ]*| \\V{\1}|g

# replace multiple spaces with one
s|[ ]{2,}| |g

# get rid of leading and trailing spaces
s|[ ]*\n[ ]*|\n|g
