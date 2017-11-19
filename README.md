# bible-study-handout
LaTeX-based handout for Bible study on a passage. Output format is PDF, meant to be printed on single 11x17 page, folded in half to make a 4-page booklet.

For an example, see [sample-handout.pdf](sample-handout.pdf).

## Content Sources
* Bible text is from the **ESV**.  Anyone can register to obtain your own (free) API Key at http://bibles.org/pages/api.
    * You're welcome to adapt the scripts to pull a different Bible version, if you wish
* Study notes are from the **ESV Study Bible**.  You'll need to use your own account at https://www.esv.org/ that provides access to the ESV Study Bible.  If your account does not give you access to the ESV Study Bible, then you're free to find another source
    * You're welcome to adapt the scripts to pull study commentary from a different source, if you wish

Optionally, you're free to include some sort of summary graphic at the beginning of your handout.  I happen to like the posters available per book from https://thebibleproject.com/explore/.

## Environment
Meant to run on Ubuntu

## Prerequisites
* LaTeX (Ubuntu installation instructions at https://help.ubuntu.com/community/LaTeX)
* xpath
* jq

## Getting Started
Start by obtaining the ESV Bible text for your chosen passage into `esv.txt` using something like this:
```
curl -Lg -u #{YOUR_BIBLES_ORG_API_KEY}:X "https://bibles.org/v2/passages.js?q[]=dan9&version=eng-ESV&include_marginalia=true" | python -mjson.tool > esv.txt
```
Be sure to replace `#{YOUR_BIBLES_ORG_API_KEY}` with your actual API Key.  Also, replace `dan9` with your chosen passage.

Next, obtain the ESV Study Bible notes for your chosen passage into `esvsb.html` using something like this:
```
PYTHONIOENCODING=UTF-8 ./curl-auth-csrf.py -i "https://my.crossway.org/cas/login/?service=https://www.esv.org/login/" -d email=#{YOUR_ACCOUNT_EMAIL} https://www.esv.org/partials/study-content/dan9/esv-study-bible/ > esvsb.html
```
The tool used here is [curl-auth-csrf](https://github.com/JElchison/curl-auth-csrf), but you're welcome to download `esvsb.html` manually if you want.  Be sure to replace `#{YOUR_ACCOUNT_EMAIL}` with your actual registered email address.  Also, replace `dan9` with your chosen passage.

Next, invoke the following:
```
make esv.out esvsb.out
```

Next, paste in the entire contents of `esv.out` into `handout.tex`.

Next, paste in the contents of `esvsb.out` into `handout.tex`, line by line.
* For study comments that cover a single verse, paste each line between `\begin{studycomment}` and `\end{studycomment}` right before the corresponding verse numbers.  This will place them in the margin, right next to the verses they apply to.
* For study comments that cover multiple verses, paste each line between `\begin{studycomment*}` and `\end{studycomment*}` right before the corresponding verse numbers.  This will place them inline, right before the verses they apply to.

Other classes available for use (from [bible-study-handout.cls](bible-study-handout.cls)):
* `bookoutline`: shaded boxes for book outline
* `studycommentinline`: study comments in column with Bible text (with indented margin if on odd pages)
* `studyblock*`: full-width block of study notes (never indent margin)
   
See the example for how these styles are used.

Next, invoke the following:
```
make clean all
```

Optionally, to see the final product:
```
xdg-open handout.pdf
```
As mentioned above, this is meant to be printed on single 11x17 page, folded in half to make a 4-page booklet.

Be sure to include all required copyright statements, to keep legal your usage of others' content.
