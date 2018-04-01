all: handout.pdf

sources: esv.out bible.out study.out

handout.pdf: handout.tex sources
	pdflatex handout
	pdflatex handout

esv.out: handout.sed esv.html
	sed -r -f handout.sed esv.html > $@

bible.out: handout.sed bible.html
	sed -r -f handout.sed bible.html > $@

study.out: handout.sed study.html
	xpath -q -e '/div/div[@rel]/p/..' study.html | sed -r -f handout.sed > $@

esv.html: esv.txt
	jq -r '.passages[0]' esv.txt > $@

bible.html: bible.txt
	jq -r '.response.search.result.passages[0].text' bible.txt > $@

clean:
	rm -fv handout.pdf esv.out bible.out study.out esv.html bible.html

.PHONY: all clean sources
