html:
	Rscript -e "library(ctv); ctv2html(read.ctv('PackageDevelopment.ctv'))"

list_ctv:
	Rscript -e "library(ctv); ctv.dir <- system.file('ctv', package = 'ctv'); file.path(ctv.dir, list.files(path = ctv.dir, pattern = '.+')); "

