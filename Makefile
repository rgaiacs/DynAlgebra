## Variables

## - COMMONJS     : implementation of CommonJS to use: slimerjs, phantomjs
##                  or nodejs.
COMMONJS = slimerjs
## - TEXZILLAPATH : path to TeXZilla.js
TEXZILLAPATH = ./TeXZilla
#
# Command Options
XARGSOPTIONS = --no-run-if-empty

ICONS = $(foreach size, 32 60 90 120 128 256, icons/dynalgebra-$(size).png)

TEXFILES = help-click.tex \
	   help-replace.tex \
	   help-demos.tex

DEMOS = $(subst tex,html,$(TEXFILES))

PACKAGELIST = manifest.webapp \
	      ${ICONS} \
	      LICENSE \
	      TeXZilla \
	      building-blocks \
	      css \
	      index.html \
	      jquery \
	      js \
	      mathml.js

# main rules

## Commands
## - help         : print this message
help:
	@grep -e '^##' Makefile | sed 's/## //'

## - build        : build some files need for this webapp
build: index.html ${ICONS}

## - beaufify     : beautify files
beautify:
	html-beautify -r template.html
	css-beautify -r css/app.css
	js-beautify -r manifest.webapp

## - package      : package the webapp
package: build
	zip -r dynalgebra.zip ${PACKAGELIST}

## - cleanall     : remove the files built previously
cleanall:
	rm -f ${ICONS}
	rm -f dynalgebra.zip

# Auxiliar rules

index.html: template.sed template.html
	sed -f $^ > $@

template.sed: $(DEMOS)
	rm -f $@ && for i in $(DEMOS); \
	do \
		echo -e /\id=\"$${i/.html/}\"/ {\\nr $${i}\\n} >> $@; \
	done;

%.html: %.tex
	xargs $(XARGSOPTIONS) -a $< -L1 \
	    $(COMMONJS) $(TEXZILLAPATH)/TeXZilla.js parser > $@

icons/%.png: icons/math-cheat-sheet.svg
	convert -background none $< -resize $(subst icons/math-cheat-sheet-,,$(basename $@)) $@

icons/%.png: icons/dynalgebra.svg
	convert -density 512 -background none $< -resize $(subst icons/dynalgebra-,,$(basename $@)) $@
