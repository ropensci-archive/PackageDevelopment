# Sed preprocessing
SECTION := h2
TASK := h3
SED_SECTION :="s@<section>\(.*\)</section>@<${SECTION}>\1</${SECTION}>@g" 
SED_TASK := "s@<task>\(.*\)</task>@<${TASK}>\1</${TASK}>@g" 
# SED_GH := "s@<gh>\(.*\)/\(.*\)</gh>@<a href='http://github.com/\1/\2'>\2</a>@g" 
SED_PREPROC :=  sed ${SED_SECTION} | sed ${SED_TASK} #| sed ${SED_GH} 
# Aspell skipping
HTML_SKIP := \
	 --add-html-skip=name --add-html-skip=maintainer --add-html-skip=pkg \
	 --add-html-skip=view --add-html-skip=bioc --add-html-skip=ohat \
	 --add-html-skip=rforge --add-html-skip=gcode


# -------------------------------------------------------------------------------------
# Main
# -------------------------------------------------------------------------------------

all: sed-preproc whisker-packagelist check html cran-links README clean

sed-preproc:
	cat pd.ctv | ${SED_PREPROC} > pd2.ctv

whisker-packagelist:
	Rscript --vanilla -e 'source("whiskerit.R")'

check:
	Rscript -e "library(ctv); (a <- check_ctv_packages('PackageDevelopment.ctv')); if (length(unlist(a)) != 0) stop('Missing Packages; look the report above')"

html:
	Rscript -e "library(ctv); ctv2html(read.ctv('PackageDevelopment.ctv'))"

cran-links:
	mv PackageDevelopment.html tmp.html
	sed 's@../packages/@http://cran.r-project.org/web/packages/@g' tmp.html > PackageDevelopment.html

README: 
	pandoc PackageDevelopment.html -o README.md

clean:
	rm -rf tmp.html pd2.ctv


# -------------------------------------------------------------------------------------
# Utils
# -------------------------------------------------------------------------------------

check-links:
	linkchecker --verbose --check-html --ignore-url=\.\./CRAN_web.css --check-extern PackageDevelopment.html

aspell:
	cat PackageDevelopment.ctv | aspell list --mode=html ${HTML_SKIP} --master=en_US --extra-dicts=./DICT | sort -f | less

aspell-dict:
	aspell --lang=en create master ./DICT < wordlist

view:
	x-www-browser PackageDevelopment.html

list-ctv:
	Rscript -e "library(ctv); ctv.dir <- system.file('ctv', package = 'ctv'); file.path(ctv.dir, list.files(path = ctv.dir, pattern = '.+')); "
