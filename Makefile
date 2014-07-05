## ############################### Variables ################################

## COMMONJS     : implementation of CommonJS to use: slimerjs, phantomjs
##                  or nodejs.
COMMONJS = slimerjs
## JQUERY : path to jQuery.js
JQUERY = js/jquery-2.1.1.min.js
## TEXZILLA : path to TeXZilla.js
TEXZILLA = js/TeXZilla.js
## MATHMLJS : path to mathml.js
MATHMLJS = js/mathml.js

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

## 
## ################################ Commands ################################
## help         : print this message
help:
	@grep -e '^##' Makefile | sed 's/## //'

## build        : build some files need for this webapp
build: index.html ${ICONS} ${JQUERY} ${TEXFILES} ${MATHMLJS}

## beaufify     : beautify files
beautify:
	html-beautify -r template.html
	css-beautify -r css/app.css
	js-beautify -r manifest.webapp

## package      : package the webapp
package: build
	zip -r dynalgebra.zip ${PACKAGELIST}

## cleanall     : remove the files built previously
cleanall:
	rm -f ${ICONS} ${TEXFILES} ${MATHMLJS}
	rm -f dynalgebra.zip

# Auxiliar rules

index.html: template.sed template.html
	sed -f $^ > $@

template.sed: ${DEMOS}
	rm -f $@ && for i in $(DEMOS); \
	do \
		echo -e /\id=\"$${i/.html/}\"/ {\\nr $${i}\\n} >> $@; \
	done;

%.html: %.tex ${TEXZILLA}
	xargs ${XARGSOPTIONS} -a $< -L1 \
	    ${COMMONJS} ${TEXZILLA} parser > $@

${JQUERY}:
	wget http://code.jquery.com/jquery-2.1.1.min.js \
	    -O ${JQUERY}

${TEXZILLA}:
	wget https://raw.githubusercontent.com/fred-wang/TeXZilla/TeXZilla-0.9.7/TeXZilla.js \
	    -O ${TEXZILLA}

${MATHMLJS}:
	wget https://raw.githubusercontent.com/r-gaia-cs/mathml.js/gh-pages/mathml.js \
	    -O ${MATHMLJS}

icons/%.png: icons/dynalgebra.svg
	convert -density 512 -background none $< -resize $(subst icons/dynalgebra-,,$(basename $@)) $@
