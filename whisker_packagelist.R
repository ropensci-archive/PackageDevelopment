library("stringr"); library("whisker")

## package list
pattern <- "pkg>[A-Za-z0-9]+|pkg>[A-Za-z0-9]+\\.[A-Za-z0-9]+|pkg>[A-Za-z0-9]+\\.[A-Za-z0-9]+\\.[A-Za-z0-9]+"
out <- paste0(readLines("tmp.ctv"), collapse = " ")
pkgs <- str_extract_all(out, pattern)[[1]]
pkgs <- unique(gsub("^pkg>", "", pkgs))
## core packages here
core.pkgs <- c()
pkgs <- pkgs[ !pkgs %in% core.pkgs ]
pkgs <- sort(pkgs)
pkgs <- as.list(pkgs)
pkgs <- lapply(pkgs, function(x) list(package=x))

## template
template <- readLines("tmp.ctv")
writeLines(whisker.render(template), "PackageDevelopment.ctv")
