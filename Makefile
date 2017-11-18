all: handout.pdf

handout.pdf: handout.tex esv.out esvsb.out
	pdflatex handout
	pdflatex handout

esv.out: esv.sed esv.html
	sed -r -f esv.sed esv.html > $@

esvsb.out: esv.sed esvsb.html
	xpath -q -e '/div/div[@rel]/p/..' esvsb.html | sed -r -f esv.sed > $@

esv.html: esv.txt
	jq -r '.response.search.result.passages[0].text' esv.txt > $@

clean:
	rm -fv handout.pdf esv.out esvsb.out esv.html

.PHONY: all clean
