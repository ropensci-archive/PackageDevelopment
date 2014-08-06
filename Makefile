# Sed preprocessing
SECTION := h2
TASK := h3
SED_SECTION_S :="s@<section>@<${SECTION}>@g"
SED_SECTION_E :="s@</section>@</${SECTION}>@g"
SED_TASK_S :="s@<task>@<${TASK}>@g"
SED_TASK_E :="s@</task>@</${TASK}>@g"
# SED_GH := "s@<gh>\(.*\)/\(.*\)</gh>@<a href='http://github.com/\1/\2'>\2</a>@g" 
SED_PREPROC :=  sed ${SED_SECTION_S} | sed ${SED_SECTION_E} | sed ${SED_TASK_S} | sed ${SED_TASK_E} 

# Sed postprocessing for GitHub repo
SED_ABS_LINKS := "s@../packages/@http://cran.r-project.org/web/packages/@g"
SED_CRAN := "s@cran.r-project.org@cran.rstudio.com@g"
SED_POSTPROC := sed ${SED_ABS_LINKS} | sed ${SED_CRAN}

# Aspell skipping
HTML_SKIP := \
	 --add-html-skip=name --add-html-skip=maintainer --add-html-skip=pkg \
	 --add-html-skip=view --add-html-skip=bioc --add-html-skip=ohat \
	 --add-html-skip=rforge --add-html-skip=gcode --add-html-skip=code

# -------------------------------------------------------------------------------------
# Main
# -------------------------------------------------------------------------------------

all: sed-preproc whisker-packagelist check html cran-links README clean

sed-preproc:
	cat pd.ctv | ${SED_PREPROC} > tmp.ctv

whisker-packagelist:
	Rscript --vanilla -e 'source("whisker_packagelist.R")'

check:
	Rscript -e "library(ctv); (a <- check_ctv_packages('PackageDevelopment.ctv')); if (length(unlist(a)) != 0) stop('Missing Packages; look the report above')"

html:
	Rscript -e "library(ctv); ctv2html(read.ctv('PackageDevelopment.ctv'))"

# this is only for GitHub repo README.md
cran-links:
	mv PackageDevelopment.html tmp.html
	cat tmp.html | ${SED_POSTPROC} > PackageDevelopment.html

README: 
	pandoc PackageDevelopment.html -o README.md

clean:
	rm -rf tmp*

# -------------------------------------------------------------------------------------
# Utils
# -------------------------------------------------------------------------------------

check-links:
	linkchecker --verbose --check-html --ignore-url=\.\./CRAN_web.css --check-extern PackageDevelopment.html

aspell:
	cat PackageDevelopment.ctv | aspell list --mode=html ${HTML_SKIP} --master=en_US --extra-dicts=./DICT | sort | less

aspell-dict:
	cp wordlist tmpwordlist
	cat tmpwordlist | sort > wordlist
	aspell --lang=en create master ./DICT < wordlist
	make clean

view:
	x-www-browser PackageDevelopment.html

list-ctv:
	Rscript -e "library(ctv); ctv.dir <- system.file('ctv', package = 'ctv'); file.path(ctv.dir, list.files(path = ctv.dir, pattern = '.+')); "
