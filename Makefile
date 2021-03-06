PANDOC ?= pandoc

# Pandoc filters.
FILTERS = $(wildcard tools/filters/*.py)

all : index.html

tools/filters/linkTable : tools/filters/linkTable.hs
	ghc $<

index.html : slides.md #tools/filters/linkTable
	${PANDOC} -s --no-highlight --highlight-style=espresso --template=pandoc-revealjs.template -t revealjs -o $@ -V revealjs-width:1600 -V transition=slide -V revealjs-url:reveal_js --section-divs --filter tools/filters/columnfilter.py $< #links.md

clean :
	rm -f links.md index.html
