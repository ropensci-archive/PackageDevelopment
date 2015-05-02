all: buildxml ctv2html readme

buildxml:
	pandoc -w html -o PackageDevelopment.ctv pkgs.md
	Rscript --vanilla -e 'source("buildxml.R")'

checkctv:
	Rscript --vanilla -e 'options(repos=structure(c(CRAN="http://cran.rstudio.com/"))); if(!require("ctv")) install.packages("ctv"); print(ctv::check_ctv_packages("PackageDevelopment.ctv"))'

ctv2html:
	Rscript --vanilla -e 'options(repos=structure(c(CRAN="http://cran.rstudio.com/"))); if(!require("ctv")) install.packages("ctv");  ctv::ctv2html("PackageDevelopment.ctv", file = "PackageDevelopment.html")'

readme:
	pandoc -w markdown_github -o temp.md PackageDevelopment.html
	sed 's|../packages/|http://cran.rstudio.com/web/packages/|g' temp.md > README.md
	rm temp.md

md2html:
	pandoc -o README.html README.md
