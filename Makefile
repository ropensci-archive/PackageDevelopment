HTML_SKIP := \
	 --add-html-skip=name --add-html-skip=maintainer --add-html-skip=pkg \
	 --add-html-skip=view --add-html-skip=bioc --add-html-skip=ohat \
	 --add-html-skip=rforge --add-html-skip=gcode


# -------------------------------------------------------------------------------------
# main
# -------------------------------------------------------------------------------------

all: check html cran-links README clean


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
	rm -rf tmp.html


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

