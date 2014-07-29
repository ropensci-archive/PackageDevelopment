HTML_SKIP := \
	 --add-html-skip=name --add-html-skip=maintainer --add-html-skip=pkg \
	 --add-html-skip=view --add-html-skip=bioc --add-html-skip=ohat \
	 --add-html-skip=rforge --add-html-skip=gcode

# --------------------------------------------------------------------------------------

all: html check link README clean

html:
	Rscript -e "library(ctv); ctv2html(read.ctv('PackageDevelopment.ctv'))"

check:
	Rscript -e "library(ctv); check_ctv_packages('PackageDevelopment.ctv')"

link:
	mv PackageDevelopment.html tmp.html
	sed 's@../packages/@http://cran.r-project.org/web/packages/@g' tmp.html > PackageDevelopment.html

README: 
	pandoc PackageDevelopment.html -o README.md

clean:
	rm -rf tmp.html

aspell:
	cat PackageDevelopment.ctv | aspell list --mode=html ${HTML_SKIP} --master=en_US --extra-dicts=./DICT | sort -f | less

aspell-make-dict:
	aspell --lang=en create master ./DICT < wordlist

view:
	x-www-browser PackageDevelopment.html

list_ctv:
	Rscript -e "library(ctv); ctv.dir <- system.file('ctv', package = 'ctv'); file.path(ctv.dir, list.files(path = ctv.dir, pattern = '.+')); "

