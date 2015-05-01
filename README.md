CRAN Task View: Package Development
-----------------------------------

|-----------------|--------------------------|
| **Maintainer:** | Thomas J. Leeper         |
| **Contact:**    | thosjleeper at gmail.com |
| **Version:**    | 2015-05-01               |

Packages provide a mechanism for loading optional code, data, and documentation as needed. At the very minimum only a text editor and an R installation are needed for package creation. Nonetheless many useful tools and R packages themselves have been provided to ease or improve package development. This Task View focuses on these tools/R packages, grouped by topics.

The main reference for packages development is the ["Writing R Extension"](http://cran.r-project.org/doc/manuals/R-exts.html) manual. For further documentation and tutorials, see the "Related links" section below.

If you think that some packages or tools are missing from the list, feel free to [e-mail](mailto:lbraglia@gmail.com) me or contribute directly to the Task View by submitting a pull request on [GitHub](http://github.com/lbraglia/PackageDevelopmentTaskView/blob/master/CONTRIBUTING.md).

Many thanks to Cristophe Dutang, Darren Norris, Dirk Eddelbuettel, Gabor Grothendieck, Gregory Jefferis, John Maindonald, Luca Braglia, Spencer Graves, Tobias Verbeke, and the R-core team for contributions.

### First steps

**Searching for Existing Packages**

Before starting a new package it's worth searching for already available packages, both from a developer's standpoint ("do not reinvent the wheel") and from a user's one (many packages implementing same/similar procedures can be confusing). If a package addressing the same functionality already exists, you may consider contributing at it instead of starting a new one. If you're looking to create a package, but want idea for what sorts of packages are in demand, the [rOpenSci](https://ropensci.org/) maintains [a wishlist for science-related packages](https://github.com/ropensci/wishlist) and [a TODO list of web services and data APIs in need of packaging](https://github.com/ropensci/webservices/wiki/ToDo).
-   `utils::RSiteSearch` allows to search for keywords/phrases in help pages (all the CRAN packages except those for Windows only and some from Bioconductor), vignettes or task views, using the search engine at <http://search.r-project.org>. A convenient wrapper around `RSiteSearch` that adds hits ranking is `findFn` function, from the [sos](http://cran.rstudio.com/web/packages/sos/index.html) package.
-   [RSeek](http://rseek.org/) allows to search for keywords/phrases in books, task views, support lists, function/packages, blogs etc.
-   [Rdocumentation](http://rdocumentation.org/) allows to search for keywords/phrases in help pages for all CRAN and some Bioconductor/GitHub packages.
-   [Crantastic!](http://crantastic.org/) maintains an up-to-date and tagged directory of packages on CRAN. The [Managed R Archive Network](http://mran.revolutionanalytics.com/) from Revolution Analytics is a CRAN mirror that additionally provides visualizations of package dependency trees.

**Initializing an R package**

-   `utils::package.skeleton` automates some of the setup for a new source package. It creates directories, saves functions, data, and R code files provided to appropriate places, and creates skeleton help files and a `Read-and-delete-me` file describing further steps in packaging
-   `kitten` from [pkgKitten](http://cran.rstudio.com/web/packages/pkgKitten/index.html) allows one to specify the main `DESCRIPTION` entries and doesn't create source code and data files from global environment objects or sourced files. It's used to initialize a simple package that passes `R CMD check` cleanly.
-   `create` from [devtools](http://cran.rstudio.com/web/packages/devtools/index.html) is similar to `package.skeleton` except it allows to specify `DESCRIPTION` entries and doesn't create source code and data files from global environment objects or sourced files.
-   `Rcpp.package.skeleton` from [Rcpp](http://cran.rstudio.com/web/packages/Rcpp/index.html) adds to `package.skeleton` the C++ via `Rcpp` handling, by modifying eg. `DESCRIPTION` and `NAMESPACE` accordingly, creating examples if needed and allowing the user to specify (with a character vector of paths) which C++ files to include in `src` directory . Finally the user can decide main `DESCRIPTION` entries.

### Source Code

**Foreign Languages Interfaces**

-   The [inline](http://cran.rstudio.com/web/packages/inline/index.html) package eases adding code in C, C++ or Fortran to R. It takes care of the compilation, linking and loading of embedded code segments that are stored as R strings.
-   The [Rcpp](http://cran.rstudio.com/web/packages/Rcpp/index.html) package offers a number of C++ classes that makes transferring R objects to C++ functions (and back) easier.
-   The [rJava](http://cran.rstudio.com/web/packages/rJava/index.html) package provides a low-level interface to Java similar to the `.Call` interface for C and C++.

**Debugging**

**Code Analysis**

-   The [codetools](http://cran.rstudio.com/web/packages/codetools/index.html) package.

**Profiling**

-   Profiling data is provided by `utils::Rprof` and can be summarized by `utils::summaryRprof`
-   The [profr](http://cran.rstudio.com/web/packages/profr/index.html) package can visualize output from the `Rprof` interface for profiling.
-   The [proftools](http://cran.rstudio.com/web/packages/proftools/index.html) package and the [aprof](http://cran.rstudio.com/web/packages/aprof/index.html) package can also be used to analyze profiling output.

**Benchmarking**

-   `base::system.time` is a basic timing utility
-   [microbenchmark](http://cran.rstudio.com/web/packages/microbenchmark/index.html)
-   [rbenchmark](http://cran.rstudio.com/web/packages/rbenchmark/index.html)

**Unit Testing**

[RUnit](http://cran.rstudio.com/web/packages/RUnit/index.html) [svUnit](http://cran.rstudio.com/web/packages/svUnit/index.html) [testthat](http://cran.rstudio.com/web/packages/testthat/index.html)
### Documentation

**Writing Package Documentation**

Package documentation is written in a TeX-like format as .Rd files that are stored in the `man` subdirectory of a package. These files are compiled to plain text, HTML, or PDF by R as needed.

-   One can write .Rd files directly. A popular alternative is to rely on [roxygen2](http://cran.rstudio.com/web/packages/roxygen2/index.html), which uses special markup in R source files to generate documentation files before a package is built. This functionality is provided by `roxygen2::roxygenise()` and underlies `devtools::document()`. roxygen2 eliminates the need to learn *some* of the formatting requirements of an .Rd file at the cost of adding a step to the development process (the need to roxygenise before calling `R CMD build`).
-   [Rd2roxygen](http://cran.rstudio.com/web/packages/Rd2roxygen/index.html) can convert existing .Rd files to roxygen source documentation, facilitating the conversion of existing documentation to an roxygen workflow.

**Writing Vignettes**

Package vignettes provides additional documentation of package functionality that is not tied to a specific function (as in an .Rd file). Historically, vignettes were used to explain the statistical or computational approach taken by a package in an article-like format that would be rendered as a PDF document using Sweave. Since R 3.0.0, non-Sweave vignette engines have also been supported, including [knitr](http://cran.rstudio.com/web/packages/knitr/index.html), which can produce Sweave-like PDF vignettes but can also support HTML vignettes that are written in R-flavored markdown. To use a non-Sweave vignette engine, the vignette needs to start with a code block indicating the package and function to be used:

`%\VignetteEngine{knitr::knitr}     %\VignetteIndexEntry{}`

**Spell Checking**

### Tools and Services

**Editors**

**Integrated Development Environments**

By far the most popular [integrated development environment (IDE)](http://en.wikibooks.org/wiki/R_Programming/Settings#Integrated_development_environment) for R is [RStudio](http://www.rstudio.com/), which is an open-source product available with both commercial and AGPL licensing. It can be run both locally and on a remote server. [rstudioapi](http://cran.rstudio.com/web/packages/rstudioapi/index.html) facilitates interaction from RStudio from within R.
**Makefiles**

[GNU Make](http://www.gnu.org/software/make/) is a tool that tipically builds executable programs and libraries from source code by reading files called `Makefile`. It can be used to manage R package as well; [maker](http://github.com/ComputationalProteomicsUnit/maker) is a `Makefile` completely devoted to R package development.
**Version Control**

**Hosting and Package Building Services**

Many [hosting services](http://en.wikipedia.org/wiki/Comparison_of_open-source_software_hosting_facilities) are available. Use of different hosts depends largely on what type of version control software is used to maintain a package. The most common sites are:
-   [R-Forge](http://r-forge.r-project.org/), which relies on on [subversion](http://subversion.apache.org/).
-   [GitHub](http://github.com/), [mainly](http://help.github.com/articles/support-for-subversion-clients) which supports both Git and Mercurial [git](http://git-scm.com/). It supports [continuous integration](http://en.wikipedia.org/wiki/Continuous_integration) for R packages. [Travis CI](http://travis-ci.org/) is a popular continuous integration tools that supports Linux and OS X build environments and has native R support. Use of other CI services may require additional code and examples are available from [r-travis](http://github.com/craigcitro/r-travis) and [r-builder](https://github.com/metacran/r-builder).
-   Some packages, especially some that are no longer under active development, remain hosted on [Google Code](https://code.google.com/). This service is closed to new projects, however, and will shut down in January 2016.
-   [WinBuilder](http://win-builder.r-project.org/) is a service intended for useRs who do not have Windows available for checking and building Windows binary packages. The package sources (after an `R CMD check`) can be uploaded via html form or passive ftp in binary mode; after checking/building a mail will be sent to the `Maintainer` with links to the package zip file and logs for download/inspection. [Appveyor](http://www.appveyor.com/) is a continuous integration service that offers a Windows build environment.

### CRAN packages:

-   [aprof](http://cran.rstudio.com/web/packages/aprof/index.html)
-   [codetools](http://cran.rstudio.com/web/packages/codetools/index.html)
-   [devtools](http://cran.rstudio.com/web/packages/devtools/index.html) (core)
-   [inline](http://cran.rstudio.com/web/packages/inline/index.html)
-   [knitr](http://cran.rstudio.com/web/packages/knitr/index.html)
-   [microbenchmark](http://cran.rstudio.com/web/packages/microbenchmark/index.html)
-   [pkgKitten](http://cran.rstudio.com/web/packages/pkgKitten/index.html)
-   [profr](http://cran.rstudio.com/web/packages/profr/index.html)
-   [proftools](http://cran.rstudio.com/web/packages/proftools/index.html)
-   [rbenchmark](http://cran.rstudio.com/web/packages/rbenchmark/index.html)
-   [Rcpp](http://cran.rstudio.com/web/packages/Rcpp/index.html)
-   [Rd2roxygen](http://cran.rstudio.com/web/packages/Rd2roxygen/index.html)
-   [rJava](http://cran.rstudio.com/web/packages/rJava/index.html)
-   [roxygen2](http://cran.rstudio.com/web/packages/roxygen2/index.html)
-   [rstudioapi](http://cran.rstudio.com/web/packages/rstudioapi/index.html)
-   [RUnit](http://cran.rstudio.com/web/packages/RUnit/index.html)
-   [sos](http://cran.rstudio.com/web/packages/sos/index.html)
-   [svUnit](http://cran.rstudio.com/web/packages/svUnit/index.html)
-   [testthat](http://cran.rstudio.com/web/packages/testthat/index.html)

### Related links:

-   [[Manual] "Writing R Extension" by R-core team](http://cran.r-project.org/doc/manuals/R-exts.html)
-   [[Tutorial] "Creating R Packages: A Tutorial" by Friedrich Leisch](http://cran.r-project.org/doc/contrib/Leisch-CreatingPackages.pdf)
-   [[Book] "Software for Data Analysis" by John Chambers](http://www.springer.com/mathematics/computational+science+%26+engineering/book/978-0-387-75935-7)
-   [[Book] "Advanced R" by Hadley Wickham](http://adv-r.had.co.nz)
-   [[Book] "R packages" by Hadley Wickham](http://r-pkgs.had.co.nz/)

