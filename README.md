CRAN Task View: Package Development
-----------------------------------

  ------------------------------------ ------------------------------------
  **Maintainer:**                      **Contact:**
  Luca Braglia                         lbraglia at gmail.com
  ------------------------------------ ------------------------------------

This Task View focuses on useful tools for R Packages Development,
grouped by topics.

Main reference for R Packages Development is ["Writing R
Extension"](http://cran.r-project.org/doc/manuals/R-exts.html) manual.
For further documentation and tutorial see the links section below.

If you think that some packages/tools are missing from the list, please
contact the [maintainer](mailto:lbraglia@gmail.com) or look
[here](http://github.com/lbraglia/PackageDevelopmentTaskView/blob/master/CONTRIBUTING.md).

First steps
-----------

### Searching for already existing packages

Before starting a new package it's worth searching for already available
packages, both from a developer's standpoint ("do not reinvent the
wheel") and from a user's one (many packages implementing same/similar
procedures can be confusing). If a package adressing the same
functionality already exist, you may consider contributing at it instead
of starting a new one.

-   `utils::RSiteSearch` allows to search for keywords/phrases in help
    pages (all the CRAN packages except those for Windows only and some
    from Bioconductor), vignettes or task views, using the search engine
    at <http://search.r-project.org>. A convenient wrapper around
    `RSiteSearch` that adds hits ranking is `findFn` function, from the
    [sos](http://cran.r-project.org/web/packages/sos/index.html)
    package.
-   [RSeek](http://rseek.org/) allows to search for keywords/phrases in
    books, task views, support lists, function/packages, blogs etc.
-   [Rdocumentation](http://rdocumentation.org/) allows to search for
    keywords/phrases in help pages for all CRAN and some
    Bioconductor/Github packages.

### Initializing an R packages

-   `utils::package.skeleton` automates some of the setup for a new
    source package. It creates directories, saves functions, data, and R
    code files provided to appropriate places, and creates skeleton help
    files and a `Read-and-delete-me` file describing further steps in
    packaging
-   `kitten` from the
    [pkgKitten](http://cran.r-project.org/web/packages/pkgKitten/index.html)
    package allows to specify the main `DESCRIPTION` entries and doesn't
    create source code and data files from global environment objects or
    sourced files. It's used to initialize a simple package that passes
    `R CMD check` cleanly.
-   `create` from the
    [devtools](http://cran.r-project.org/web/packages/devtools/index.html)
    package is similar to `package.skeleton` except it allows to specify
    `DESCRIPTION` entries and doesn't create source code and data files
    from global environment objects or sourced files.
-   `Rcpp.package.skeleton` from the
    [Rcpp](http://cran.r-project.org/web/packages/Rcpp/index.html)
    package adds to `package.skeleton` the C++ via Rcpp handling, by
    modifying eg. `DESCRIPTION` and `NAMESPACE` accordingly, creating
    examples if needed and allowing the user to specify (with a
    character vector of paths) which C++ files to include in `src`
    directory . Finally the user can decide main `DESCRIPTION` entries.

Source code
-----------

### Foreign Languages Interfaces

-   The
    [inline](http://cran.r-project.org/web/packages/inline/index.html)
    package eases adding code in C, C++ or Fortran to R. It takes care
    of the compilation, linking and loading of embedded code segments
    that are stored as R strings.
-   The [Rcpp](http://cran.r-project.org/web/packages/Rcpp/index.html)
    package offers a number of C++ classes that makes transferring R
    objects to C++ functions (and back) easier.
-   The [rJava](http://cran.r-project.org/web/packages/rJava/index.html)
    package provides a low-level interface to Java similar to the
    `.Call` interface for C and C++.

### Debugging

### Code Analysis

-   The
    [codetools](http://cran.r-project.org/web/packages/codetools/index.html)
    package.

### Profiling

-   Profiling data is provided by `utils::Rprof` and can be summarized
    by `utils::summaryRprof`
-   The [profr](http://cran.r-project.org/web/packages/profr/index.html)
    package can visualize output from the `Rprof` interface for
    profiling.
-   The
    [proftools](http://cran.r-project.org/web/packages/proftools/index.html)
    package and the
    [aprof](http://cran.r-project.org/web/packages/aprof/index.html)
    package can also be used to analyze profiling output.

### Benchmarking

-   `base::system.time` is a basic timing utility
-   [microbenchmark](http://cran.r-project.org/web/packages/microbenchmark/index.html)
-   [rbenchmark](http://cran.r-project.org/web/packages/rbenchmark/index.html)

### Unit Testing

[RUnit](http://cran.r-project.org/web/packages/RUnit/index.html)
[svUnit](http://cran.r-project.org/web/packages/svUnit/index.html)
[testthat](http://cran.r-project.org/web/packages/testthat/index.html)

Documentation
-------------

### Writing Package Documentation

### Writing Vignettes

### Spell Checking

Tools and services
------------------

### Editors

### IDEs

### Makefiles

[GNU Make](http://www.gnu.org/software/make/) utility that automatically
builds executable programs and libraries from source code by reading
files called makefiles. It can be used to manage R package as well;
[maker](http://github.com/ComputationalProteomicsUnit/maker) is a
Makefile completely devoted to R package development.

### Hosting services

Many [hosting
services](http://en.wikipedia.org/wiki/Comparison_of_open-source_software_hosting_facilities)
are available for package development. The most common in the R
community are:

-   [R-forge](http://r-forge.r-project.org/), based on
    [subversion](http://subversion.apache.org/).
-   [GitHub](http://github.com/), based on [git](http://git-scm.com/).
    It can handle [continuous
    integration](http://en.wikipedia.org/wiki/Continuous_integration)
    for R packages with [Travis CI](http://travis-ci.org/): more info on
    that [here](http://github.com/craigcitro/r-travis).

### Building services

-   [WinBuilder](http://win-builder.r-project.org/) is a service
    intended for useRs who do not have Windows available, for checking
    and building Windows binary packages. The package sources (after an
    `R CMD check`) can be uploaded via html form or passive ftp in
    binary mode; after checking/building a mail will be sent to the
    `Maintainer` with links to the package zip file and logs for
    download/inspection.

### CRAN packages:

-   [aprof](http://cran.r-project.org/web/packages/aprof/index.html)
-   [codetools](http://cran.r-project.org/web/packages/codetools/index.html)
-   [devtools](http://cran.r-project.org/web/packages/devtools/index.html)
-   [inline](http://cran.r-project.org/web/packages/inline/index.html)
-   [microbenchmark](http://cran.r-project.org/web/packages/microbenchmark/index.html)
-   [pkgKitten](http://cran.r-project.org/web/packages/pkgKitten/index.html)
-   [profr](http://cran.r-project.org/web/packages/profr/index.html)
-   [proftools](http://cran.r-project.org/web/packages/proftools/index.html)
-   [rbenchmark](http://cran.r-project.org/web/packages/rbenchmark/index.html)
-   [Rcpp](http://cran.r-project.org/web/packages/Rcpp/index.html)
-   [rJava](http://cran.r-project.org/web/packages/rJava/index.html)
-   [RUnit](http://cran.r-project.org/web/packages/RUnit/index.html)
-   [sos](http://cran.r-project.org/web/packages/sos/index.html)
-   [svUnit](http://cran.r-project.org/web/packages/svUnit/index.html)
-   [testthat](http://cran.r-project.org/web/packages/testthat/index.html)

### Related links:

-   [[Manual] "Writing R Extension" by R-core
    team](http://cran.r-project.org/doc/manuals/R-exts.html)
-   [[Tutorial] "Creating R Packages: A Tutorial" by Friedrich
    Leisch](http://cran.r-project.org/doc/contrib/Leisch-CreatingPackages.pdf)
-   [[Book] "Software for Data Analysis" by John
    Chambers](http://www.springer.com/mathematics/computational+science+%26+engineering/book/978-0-387-75935-7)
-   [[Book] "Advanced R" by Hadley Wickham](http://adv-r.had.co.nz)

