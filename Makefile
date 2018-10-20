all: handout-11x17.pdf

handout-11x17.pdf: handout.pdf
	pdfbook --paper letter --papersize '{17in,11in}' --outfile $@ $<

handout.pdf: handout.tex sources
	pdflatex handout
	pdflatex handout

sources: esv.out bible.out study.out

esv.out: handout.sed esv.html
	sed -r -f handout.sed esv.html > $@

bible.out: handout.sed bible.html
	sed -r -f handout.sed bible.html > $@

study.out: handout.sed study.html
	xpath -q -e '/div/div[@rel]/p/..' study.html | sed -r -f handout.sed > $@

esv.html: esv.txt
	jq -r '.passages[0]' $< > $@

bible.html: bible.txt
	jq -r '.response.search.result.passages[0].text' $< > $@

clean:
	rm -fv handout-11x17.pdf handout.pdf esv.out bible.out study.out esv.html bible.html

.PHONY: all clean sources
