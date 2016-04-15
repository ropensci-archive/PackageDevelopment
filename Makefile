all: README.md

PackageDevelopment.ctv: pkgs.md buildxml.R
	pandoc -w html -o PackageDevelopment.ctv pkgs.md
	Rscript --vanilla -e 'source("buildxml.R")'

PackageDevelopment.html: PackageDevelopment.ctv
	Rscript --vanilla -e 'if(!require("ctv")) install.packages("ctv", repos = "http://cran.rstudio.com/"); ctv::ctv2html("PackageDevelopment.ctv")'

README.md: PackageDevelopment.html
	pandoc -w markdown_github -o README.md PackageDevelopment.html
	sed -i.tmp -e 's|( \[|(\[|g' README.md
	sed -i.tmp -e 's| : |: |g' README.md
	sed -i.tmp -e 's|../packages/|http://cran.rstudio.com/web/packages/|g' README.md
	sed -i.tmp -e '4s/.*/| | |\n|---|---|/' README.md
	sed -i.tmp -e '4i*Do not edit this README by hand. See \[CONTRIBUTING.md\]\(CONTRIBUTING.md\).*\n' README.md
	rm *.tmp

check:
	Rscript --vanilla -e 'if(!require("ctv")) install.packages("ctv", repos = "http://cran.rstudio.com/"); print(ctv::check_ctv_packages("PackageDevelopment.ctv", repos = "http://cran.rstudio.com/"))'

README.html: README.md
	pandoc --from=markdown_github -o README.html README.md
