CRAN Task View: Package Development
-----------------------------------

|-----------------|--------------------------|
| **Maintainer:** | Thomas J. Leeper         |
| **Contact:**    | thosjleeper at gmail.com |
| **Version:**    | 2015-05-01               |

Packages provide a mechanism for loading optional code, data, and documentation as needed. At the very minimum only a text editor and an R installation are needed for package creation. Nonetheless many useful tools and R packages themselves have been provided to ease or improve package development. This Task View focuses on these tools/R packages, grouped by topics.

The main reference for packages development is the ["Writing R Extension"](http://cran.r-project.org/doc/manuals/R-exts.html) manual. For further documentation and tutorials, see the "Related links" section below.

If you think that some packages or tools are missing from the list, feel free to
e-mail (lbraglia at gmail dot com) me or contribute directly to the Task View by submitting a pull request on [GitHub](http://github.com/lbraglia/PackageDevelopmentTaskView/blob/master/CONTRIBUTING.md).
Many thanks to Cristophe Dutang, Darren Norris, Dirk Eddelbuettel, Gabor Grothendieck, Gregory Jefferis, John Maindonald, Luca Braglia, Spencer Graves, Tobias Verbeke, and the R-core team for contributions.

### First steps

**Searching for Existing Packages**

Before starting a new package it's worth searching for already available packages, both from a developer's standpoint ("do not reinvent the wheel") and from a user's one (many packages implementing same/similar procedures can be confusing). If a package addressing the same functionality already exists, you may consider contributing at it instead of starting a new one. If you're looking to create a package, but want idea for what sorts of packages are in demand, the [rOpenSci](https://ropensci.org/) maintains [a wishlist for science-related packages](https://github.com/ropensci/wishlist) and [a TODO list of web services and data APIs in need of packaging](https://github.com/ropensci/webservices/wiki/ToDo).

-   `utils::RSiteSearch` allows to search for keywords/phrases in help pages (all the CRAN packages except those for Windows only and some from Bioconductor), vignettes or task views, using the search engine at <http://search.r-project.org>. A convenient wrapper around `RSiteSearch` that adds hits ranking is `findFn` function, from [sos](http://cran.rstudio.com/web/packages/sos/index.html).
-   [RSeek](http://rseek.org/) allows to search for keywords/phrases in books, task views, support lists, function/packages, blogs etc.
-   [Rdocumentation](http://rdocumentation.org/) allows to search for keywords/phrases in help pages for all CRAN and some Bioconductor/GitHub packages.
-   [Crantastic!](http://crantastic.org/) maintains an up-to-date and tagged directory of packages on CRAN. The [Managed R Archive Network](http://mran.revolutionanalytics.com/) from Revolution Analytics is a CRAN mirror that additionally provides visualizations of package dependency trees.

**Initializing an R package**

-   `utils::package.skeleton` automates some of the setup for a new source package. It creates directories, saves functions, data, and R code files provided to appropriate places, and creates skeleton help files and a `Read-and-delete-me` file describing further steps in packaging
-   `kitten` from [pkgKitten](http://cran.rstudio.com/web/packages/pkgKitten/index.html) allows one to specify the main `DESCRIPTION` entries and doesn't create source code and data files from global environment objects or sourced files. It's used to initialize a simple package that passes `R CMD check` cleanly.
-   `create` from [devtools](http://cran.rstudio.com/web/packages/devtools/index.html) is similar to `package.skeleton` except it allows to specify `DESCRIPTION` entries and doesn't create source code and data files from global environment objects or sourced files.
-   `Rcpp.package.skeleton` from [Rcpp](http://cran.rstudio.com/web/packages/Rcpp/index.html) adds to `package.skeleton` the C++ via `Rcpp` handling, by modifying eg. `DESCRIPTION` and `NAMESPACE` accordingly, creating examples if needed and allowing the user to specify (with a character vector of paths) which C++ files to include in `src` directory . Finally the user can decide main `DESCRIPTION` entries.

**Programming Paradigms**

R is first a functional programming language, but has three built-in forms of object-oriented programming as well as additional object-oriented paradigms available in add-on packages.

-   The built-in S3 classes involve wherein a generic function (e.g., `summary`) employs a distinct method for an object of a given class (i.e., it is possible to implement class-specific methods for a given generic function). If a package implements new object classes, it is common to implement methods for commonly used generics such as `print`, `summary`, etc. These methods must be registered in the package's NAMESPACE file. [R.methodsS3](http://cran.rstudio.com/web/packages/R.methodsS3/index.html) aims to simplify the creation of S3 generic functions and S3 methods.
-   S4 is a more formalized form of object orientation that is available through `methods`. S4 classes have formal definitions and can dispatch methods based on multiple arguments (not just the first argument, as in S3). S4 is notable for its use of the `@` symbol to extract slots from S4 objects. John Chambers's ["How S4 Methods Work"](http://developer.r-project.org/howMethodsWork.pdf) tutorial may serve as a useful introduction.
-   Reference classes were introduced in R2.12.0 and are also part of `methods`. They offer a distinct paradigm from S3 and S4 due to the fact that reference class objects are mutable and that methods belong to objects, not generic functions.
-   [aoos](http://cran.rstudio.com/web/packages/aoos/index.html) and [R.oo](http://cran.rstudio.com/web/packages/R.oo/index.html) are other packages facilitating object-oriented programming. [R6](http://cran.rstudio.com/web/packages/R6/index.html) ( [Github](https://github.com/wch/R6)) provides an alternative to reference classes without a dependency on `methods`.

Another feature of R is the ability to rely on both standard and non-standard evaluation of function arguments. Non-standard evaluation is seen in commonly used functions like `library` and `subset` and can also be used in packages.

-   `substitute()` provides the most straightforward interface to non-standard evaluation of function arguments.
-   [lazyeval](http://cran.rstudio.com/web/packages/lazyeval/index.html) ( [Github](https://github.com/hadley/lazyeval)) aims to help developers design packages with parallel function implementations that follow both standard and non-standard evaluation.
-   An increasingly popular form of non-standard evaluation involves chained expressions or "pipelines". [magrittr](http://cran.rstudio.com/web/packages/magrittr/index.html) provides the `%>%` chaining operator that passes the results of one expression evaluation to the next expression in the chain, as well as other similar piping operators. [pipeR](http://cran.rstudio.com/web/packages/pipeR/index.html) offers a larger set of pipe operators.

### Source Code

**Foreign Languages Interfaces**

-   [inline](http://cran.rstudio.com/web/packages/inline/index.html) eases adding code in C, C++, or Fortran to R. It takes care of the compilation, linking and loading of embedded code segments that are stored as R strings.
-   [Rcpp](http://cran.rstudio.com/web/packages/Rcpp/index.html) offers a number of C++ classes that makes transferring R objects to C++ functions (and back) easier.
-   [rJava](http://cran.rstudio.com/web/packages/rJava/index.html) package provides a low-level interface to Java similar to the `.Call` interface for C and C++.
-   [rPython](http://cran.rstudio.com/web/packages/rPython/index.html) and [rJython](http://cran.rstudio.com/web/packages/rJython/index.html) provide interfaces to python.
-   [V8](http://cran.rstudio.com/web/packages/V8/index.html) offers an embedded Javascript engine, useful for building packages around Javascript libraries. [js](http://cran.rstudio.com/web/packages/js/index.html) provides additional tools for working with Javascript code.

Writing packages that involve compiled code requires a developer toolchain. If developing on Windows, this requires [Rtools](http://cran.r-project.org/bin/windows/Rtools/), which is updated with each R minor release.

**Debugging**

**Code Analysis**

-   The [codetools](http://cran.rstudio.com/web/packages/codetools/index.html) package.

**Profiling**

-   Profiling data is provided by `utils::Rprof` and can be summarized by `utils::summaryRprof`
-   [profr](http://cran.rstudio.com/web/packages/profr/index.html) can visualize output from the `Rprof` interface for profiling.
-   [proftools](http://cran.rstudio.com/web/packages/proftools/index.html) and [aprof](http://cran.rstudio.com/web/packages/aprof/index.html) can also be used to analyze profiling output.

**Benchmarking**

-   `base::system.time` is a basic timing utility
-   [microbenchmark](http://cran.rstudio.com/web/packages/microbenchmark/index.html)
-   [rbenchmark](http://cran.rstudio.com/web/packages/rbenchmark/index.html)

**Unit Testing**

-   R documentation files can contain demonstrative examples of package functionality. Complete testing of correct package performance is better reserved for the `test` directory. Several packages provide testing functionality, including [RUnit](http://cran.rstudio.com/web/packages/RUnit/index.html), [svUnit](http://cran.rstudio.com/web/packages/svUnit/index.html), and [testthat](http://cran.rstudio.com/web/packages/testthat/index.html).

**Internationalization and Localization**

-   There is no standard mechanism for translation of package documentation into languages other than English. To create non-English documentation requires manual creation of supplemental .Rd files or package vignettes. Packages supplying non-English documentation should include a `Language` field in the DESCRIPTION file.
-   R provides useful features for the localization of diagnostic messages, warnings, and errors from functions at both the C and R levels based on GNU `gettext`. ["Translating R Messages"](http://developer.r-project.org/Translations30.html) describes the process of creating and installing message translations.

**Creating Graphical Interfaces**

-   For simple interactive interfaces, `readline()` can be used to create a simple prompt, while `utils::menu()`, `utils::select.list()` can provide graphical and console-based selection of items from a list, and `utils::txtProgressBar()` provides a simple text progress bar.
-   `tcltk` is an R base package that provides a large set of tools for creating interfaces uses tcl/tk (most functions are thin wrappers around corresponding tcl and tk functions), though the documentation is sparse. [tcltk2](http://cran.rstudio.com/web/packages/tcltk2/index.html) provides additional widgets and functionality. [qtbase](http://cran.rstudio.com/web/packages/qtbase/index.html) provides bindings for Qt. [<span class="Ohat">RGtk</span>](http://www.Omegahat.org/RGtk/) (not on CRAN) provides bindings for Gtk and gnome. [gWidgets2](http://cran.rstudio.com/web/packages/gWidgets2/index.html) offers a language-independent API for building graphical user interfaces in Gtk, Qt, or tcl/tk.
-   [Shiny](http://cran.rstudio.com/web/packages/Shiny/index.html) provides a browser-based infrastructure for creating dashboards and interfaces for R functionality.

### Documentation

**Writing Package Documentation**

Package documentation is written in a TeX-like format as .Rd files that are stored in the `man` subdirectory of a package. These files are compiled to plain text, HTML, or PDF by R as needed.

-   One can write .Rd files directly. A popular alternative is to rely on [roxygen2](http://cran.rstudio.com/web/packages/roxygen2/index.html), which uses special markup in R source files to generate documentation files before a package is built. This functionality is provided by `roxygen2::roxygenise()` and underlies `devtools::document()`. roxygen2 eliminates the need to learn *some* of the formatting requirements of an .Rd file at the cost of adding a step to the development process (the need to roxygenise before calling `R CMD build`).
-   [Rd2roxygen](http://cran.rstudio.com/web/packages/Rd2roxygen/index.html) can convert existing .Rd files to roxygen source documentation, facilitating the conversion of existing documentation to an roxygen workflow.
-   `tools::parse_Rd()` can be used to manipulate the contents of an .Rd file. `tools::checkRd()` is useful for validating an .Rd file. Duncan Murdoch's ["Parsing Rd files"](https://developer.r-project.org/parseRd.pdf) tutorial is a useful reference for advanced use of R documentation. [Rdpack](http://cran.rstudio.com/web/packages/Rdpack/index.html) provides additional tools for manipulating documentation files.

**Writing Vignettes**

Package vignettes provides additional documentation of package functionality that is not tied to a specific function (as in an .Rd file). Historically, vignettes were used to explain the statistical or computational approach taken by a package in an article-like format that would be rendered as a PDF document using `Sweave`. Since R 3.0.0, non-Sweave vignette engines have also been supported, including [knitr](http://cran.rstudio.com/web/packages/knitr/index.html), which can produce Sweave-like PDF vignettes but can also support HTML vignettes that are written in R-flavored markdown. To use a non-Sweave vignette engine, the vignette needs to start with a code block indicating the package and function to be used:

    %\VignetteEngine{knitr::knitr}
        %\VignetteIndexEntry{}
          

**Spell Checking**

### Data in Packages

### Tools and Services

**Text Editors and IDEs**

By far the most popular [integrated development environment (IDE)](http://en.wikibooks.org/wiki/R_Programming/Settings#Integrated_development_environment) for R is [RStudio](http://www.rstudio.com/), which is an open-source product available with both commercial and AGPL licensing. It can be run both locally and on a remote server. [rstudioapi](http://cran.rstudio.com/web/packages/rstudioapi/index.html) facilitates interaction from RStudio from within R.

**Makefiles**

[GNU Make](http://www.gnu.org/software/make/) is a tool that typically builds executable programs and libraries from source code by reading files called `Makefile`. It can be used to manage R package as well; [maker](http://github.com/ComputationalProteomicsUnit/maker) is a `Makefile` completely devoted to R package development.

**Version Control**

**Hosting and Package Building Services**

Many [hosting services](http://en.wikipedia.org/wiki/Comparison_of_open-source_software_hosting_facilities) are available. Use of different hosts depends largely on what type of version control software is used to maintain a package. The most common sites are:

-   [R-Forge](http://r-forge.r-project.org/), which relies on on [subversion](http://subversion.apache.org/).
-   [GitHub](http://github.com/), [mainly](http://help.github.com/articles/support-for-subversion-clients) which supports both Git and Mercurial [git](http://git-scm.com/). Packages hosted on Github can be installed directly using `devtools::install_github()`.
-   Github supports [continuous integration](http://en.wikipedia.org/wiki/Continuous_integration) for R packages. [Travis CI](http://travis-ci.org/) is a popular continuous integration tools that supports Linux and OS X build environments and has native R support. Use of other CI services may require additional code and examples are available from [r-travis](http://github.com/craigcitro/r-travis) and [r-builder](https://github.com/metacran/r-builder).
-   [WinBuilder](http://win-builder.r-project.org/) is a service intended for useRs who do not have Windows available for checking and building Windows binary packages. The package sources (after an `R CMD check`) can be uploaded via html form or passive ftp in binary mode; after checking/building a mail will be sent to the `Maintainer` with links to the package zip file and logs for download/inspection. [Appveyor](http://www.appveyor.com/) is a continuous integration service that offers a Windows build environment.
-   Some packages, especially some that are no longer under active development, remain hosted on [Google Code](https://code.google.com/). This service is closed to new projects, however, and will shut down in January 2016.

### CRAN packages:

-   [aoos](http://cran.rstudio.com/web/packages/aoos/index.html)
-   [aprof](http://cran.rstudio.com/web/packages/aprof/index.html)
-   [codetools](http://cran.rstudio.com/web/packages/codetools/index.html)
-   [devtools](http://cran.rstudio.com/web/packages/devtools/index.html) (core)
-   [gWidgets2](http://cran.rstudio.com/web/packages/gWidgets2/index.html)
-   [inline](http://cran.rstudio.com/web/packages/inline/index.html)
-   [js](http://cran.rstudio.com/web/packages/js/index.html)
-   [knitr](http://cran.rstudio.com/web/packages/knitr/index.html)
-   [lazyeval](http://cran.rstudio.com/web/packages/lazyeval/index.html)
-   [magrittr](http://cran.rstudio.com/web/packages/magrittr/index.html)
-   [microbenchmark](http://cran.rstudio.com/web/packages/microbenchmark/index.html)
-   [pipeR](http://cran.rstudio.com/web/packages/pipeR/index.html)
-   [pkgKitten](http://cran.rstudio.com/web/packages/pkgKitten/index.html)
-   [profr](http://cran.rstudio.com/web/packages/profr/index.html)
-   [proftools](http://cran.rstudio.com/web/packages/proftools/index.html)
-   [qtbase](http://cran.rstudio.com/web/packages/qtbase/index.html)
-   [R.methodsS3](http://cran.rstudio.com/web/packages/R.methodsS3/index.html)
-   [R.oo](http://cran.rstudio.com/web/packages/R.oo/index.html)
-   [R6](http://cran.rstudio.com/web/packages/R6/index.html)
-   [rbenchmark](http://cran.rstudio.com/web/packages/rbenchmark/index.html)
-   [Rcpp](http://cran.rstudio.com/web/packages/Rcpp/index.html)
-   [Rd2roxygen](http://cran.rstudio.com/web/packages/Rd2roxygen/index.html)
-   [Rdpack](http://cran.rstudio.com/web/packages/Rdpack/index.html)
-   [rJava](http://cran.rstudio.com/web/packages/rJava/index.html)
-   [rJython](http://cran.rstudio.com/web/packages/rJython/index.html)
-   [roxygen2](http://cran.rstudio.com/web/packages/roxygen2/index.html)
-   [rPython](http://cran.rstudio.com/web/packages/rPython/index.html)
-   [rstudioapi](http://cran.rstudio.com/web/packages/rstudioapi/index.html)
-   [RUnit](http://cran.rstudio.com/web/packages/RUnit/index.html)
-   [Shiny](http://cran.rstudio.com/web/packages/Shiny/index.html)
-   [sos](http://cran.rstudio.com/web/packages/sos/index.html)
-   [svUnit](http://cran.rstudio.com/web/packages/svUnit/index.html)
-   [tcltk2](http://cran.rstudio.com/web/packages/tcltk2/index.html)
-   [testthat](http://cran.rstudio.com/web/packages/testthat/index.html)
-   [V8](http://cran.rstudio.com/web/packages/V8/index.html)

### Related links:

-   [[Manual] "Writing R Extension" by R-core team](http://cran.r-project.org/doc/manuals/R-exts.html)
-   [[Tutorial] "Creating R Packages: A Tutorial" by Friedrich Leisch](http://cran.r-project.org/doc/contrib/Leisch-CreatingPackages.pdf)
-   [[Book] "Software for Data Analysis" by John Chambers](http://www.springer.com/mathematics/computational+science+%26+engineering/book/978-0-387-75935-7)
-   [[Book] "Advanced R" by Hadley Wickham](http://adv-r.had.co.nz)
-   [[Book] "R packages" by Hadley Wickham](http://r-pkgs.had.co.nz/)

