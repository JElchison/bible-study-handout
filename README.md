# bible-study-handout
LaTeX-based handout for group study on a Bible passage.  Handout style is based on [Tufte-LaTeX](https://github.com/Tufte-LaTeX/tufte-latex).  Output format is PDF, meant to be printed on single 11x17 page, folded in half to make a 4-page booklet.

See [sample-handout.pdf](sample-handout.pdf) for an example handout on Exodus 20.  Keep in mind that pages 2 and 3 will be side-by-side in the middle of the 4-page booklet.

## Goals
This handout format is the product of many iterations.  Here are some of the goals:

* Provide all information needed to engage in a group study session on a **single handout**.  For lack of a better term, everyone can be on the same page.
  * This way, at any given moment, each person in the group can be looking at different information (**parallel random access**).  (This is not true when a presenter uses slides, where everyone is looking at the same slide).  This encourages individuals to follow their own interest as he/she wades through a passage.
* Provide all study information (from different sources) **interleaved sequentially**, so that the reader doesn't have to bounce between resources to engage deeper on a question or topic.  As a reader ponders a particular verse, the study note is inches away (instead of in a different book, device, or section).
  * Keep the **focus on the Biblical text**, not the study notes
* Provide more information in the handout than you intend to cover together as a group.  Generally, humans can read 6x faster than a presenter can speak.  This type of **self-study** can be done while the group as a whole is engaged in a related verbal discussion.
* Show the passage of interest **in context with the rest of its Bible book**.  Show the passage interleaved within the book outline.
* Optionally, show a summary graphic at the beginning of the handout that encompasses the entire book.  This helps the reader **remember the overall story of the book**--not just the passage at hand.
* **Good typography** and visual appeal.  (Sadly, this is sometimes a lost art.)
* Provide **something physical that attendees can take with them** to continue their study on their own time.
  * Alternatively, make this handout (digitally?) available for group members who were not able to attend the specific group study.

## Content Sources
* Bible text is from the **ESV**.  Anyone can register to obtain your own (free) API Key at https://api.esv.org/account/.
    * You're welcome to adapt the scripts to pull a different Bible version from another source, if you wish
        * Anyone can register to obtain your own (free) API Key at http://bibles.org/pages/api
* Study notes are from the **ESV Study Bible**.  You'll need to use your own account at https://www.esv.org/ that provides access to the ESV Study Bible.  If your account does not give you access to the ESV Study Bible, then you're free to find another source
    * You're welcome to adapt the scripts to pull study commentary from a different source, if you wish

Optionally, you're free to include some sort of summary graphic at the beginning of your handout.  I happen to like the posters available per book from [The Bible Project](https://thebibleproject.com/explore/).

## Environment
Meant to run on Ubuntu

## Prerequisites
* LaTeX (Ubuntu installation instructions at https://help.ubuntu.com/community/LaTeX)
* xpath (Ubuntu installation via `libxml-xpath-perl` package)
* jq

## Getting Started
Start by downloading the submodule code:
```
git submodule update --init --recursive
```

Next, obtain the ESV Bible text for your chosen passage into `esv.txt` using something like this:
```
curl -X GET --header 'Accept: application/json' --header 'Authorization: Token #{YOUR_ESV_ORG_API_KEY}' 'https://api.esv.org/v3/passage/html/?q=dan9&include-passage-references=false&include-chapter-numbers=false&include-first-verse-numbers=true&include-verse-numbers=true&include-footnotes=false&include-surrounding-chapters-below=false' | python -mjson.tool > esv.txt
```
Be sure to replace `#{YOUR_ESV_ORG_API_KEY}` with your actual API Key.  Also, replace `dan9` with your chosen passage.

If you're pulling a non-ESV version from bibles.org, use following instead:
```
curl -Lg -u #{YOUR_BIBLES_ORG_API_KEY}:X "https://bibles.org/v2/passages.js?q[]=dan9&version=spa-RVR1960&include_marginalia=true" | python -mjson.tool > bible.txt
```

Next, obtain the ESV Study Bible notes for your chosen passage into `study.html` using something like this:
```
PYTHONIOENCODING=UTF-8 ./curl-auth-csrf.py -i "https://my.crossway.org/cas/login/?service=https://www.esv.org/login/" -d email=#{YOUR_ACCOUNT_EMAIL} https://www.esv.org/partials/study-content/dan9/esv-study-bible/ > study.html
```
The tool used here is [curl-auth-csrf](https://github.com/JElchison/curl-auth-csrf), but you're welcome to download `study.html` manually if you want.  Be sure to replace `#{YOUR_ACCOUNT_EMAIL}` with your actual registered email address.  Also, replace `dan9` with your chosen passage.

Next, invoke the following:
```
make clean sources
```

Next, paste in the entire contents of `esv.out` (`bible.out`) into `handout.tex`.

Next, paste in the contents of `study.out` into `handout.tex`, line by line.
* For study comments that cover a single verse, paste each line between `\begin{studycomment}` and `\end{studycomment}` right before the corresponding verse numbers.  This will place them in the margin, right next to the verses they apply to.
* For study comments that cover multiple verses, paste each line between `\begin{studycomment*}` and `\end{studycomment*}` right before the corresponding verse numbers.  This will place them inline, right before the verses they apply to.
  * Use `\noindent{}` if you're interrupting a paragraph

Tips:
* For any study comments that precede the Biblical text, you may wish to use `studyblock*` instead of `studycomment*` (as indentation isn't necessary)
* For any `studycomment*` instances which overlap text from other `studycomment` instances, simply convert the `studycomment*` to `studycommentinline`.  This will pull the study comment to be inline with the Bible text.
* You can add context via an outline of the book of the Bible via `bookoutline`
* For other hints, please see [Tufte-LaTeX](https://github.com/Tufte-LaTeX/tufte-latex)

See the [sample-handout.pdf](sample-handout.pdf) for how these styles are used.

As mentioned above, this is meant to be printed on single 11x17 page, folded in half to make a 4-page booklet.

Any remaining space in the handout (through the end of page 4) can be filled with your own LaTeX content, such as your main points, additional graphics, etc.

Be sure to include all required copyright statements, to keep legal your usage of others' content.

Once you're ready to render, invoke the following:
```
make clean all
```

Optionally, to see the final product:
```
xdg-open handout.pdf
```
As mentioned above, this is meant to be printed on single 11x17 page, folded in half to make a 4-page booklet.
