if(!require("stringr")) install.packages("stringr", repos="http://cran.rstudio.com")
template <- readLines("PackageDevelopment.ctv")
pattern <- "pkg>[A-Za-z0-9]+|pkg>[A-Za-z0-9]+\\.[A-Za-z0-9]+|pkg>[A-Za-z0-9]+\\.[A-Za-z0-9]+\\.[A-Za-z0-9]+"
out <- paste0(template, collapse = " ")
pkgs <- stringr::str_extract_all(out, pattern)[[1]]
pkgs <- unique(gsub("^pkg>", "", pkgs))
pkgs <- pkgs[ !pkgs %in% c("devtools", "knitr", "roxygen2") ] # remove priority packages
pkgs <- sort(pkgs)
pkgs <- as.list(pkgs)
pkgs <- lapply(pkgs, function(x) list(package=x))
output <- 
c(paste0('<CRANTaskView>
  <name>PackageDevelopment</name>
  <topic>Package Development</topic>
  <maintainer email="thosjleeper@gmail.com">Thomas J. Leeper</maintainer>
  <version>',Sys.Date(),'</version>'), 
  '  <info>',
  paste0("    ",template), 
  '  </info>',
  '  <packagelist>',
  # list priority packages explicitly
  '    <pkg priority="core">devtools</pkg>',
  '    <pkg priority="core">knitr</pkg>',
  '    <pkg priority="core">roxygen2</pkg>',
  # add all other packages from `pkgs`
  paste0('    <pkg>', unlist(unname(pkgs)), '</pkg>', collapse = "\n"),
  '  </packagelist>',
  '  <links>',
  '    <a href="http://cran.r-project.org/doc/manuals/R-exts.html">[Manual] "Writing R Extension" by R-core team </a>',
  '    <a href="http://cran.r-project.org/doc/contrib/Leisch-CreatingPackages.pdf">[Tutorial] "Creating R Packages: A Tutorial" by Friedrich Leisch </a>',
  '    <a href="http://cran.r-project.org/web/packages/httr/vignettes/api-packages.html">[Tutorial] "Best practices for writing an API package" by Hadley Wickham</a>',
  '    <a href="http://cran.r-project.org/web/packages/policies.html">[Webpage] "CRAN Repository Policy" lists rules for hosting packages on CRAN</a>', 
  '    <a href="https://github.com/eddelbuettel/crp">[Webpage] Dirk Eddelbuettel provides a feed of CRAN policy changes</a>',
  '    <a href="http://www.springer.com/mathematics/computational+science+%26+engineering/book/978-0-387-75935-7">[Book] "Software for Data Analysis" by John Chambers</a>',
  '    <a href="http://adv-r.had.co.nz">[Book] "Advanced R" by Hadley Wickham</a>',
  '    <a href="http://r-pkgs.had.co.nz/">[Book] "R packages" by Hadley  Wickham</a>',
  '  </links>',
  '</CRANTaskView>')

writeLines(output, "PackageDevelopment.ctv")
