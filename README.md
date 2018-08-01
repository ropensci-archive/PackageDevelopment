CRAN Task View: Package Development
-----------------------------------

*Do not edit this README by hand. See [CONTRIBUTING.md](CONTRIBUTING.md).*

| | |
|---|---|
|-----------------|------------------------------------------------------|
| **Maintainer:** | Thomas J. Leeper                                     |
| **Contact:**    | thosjleeper at gmail.com                             |
| **Version:**    | 2018-07-31                                           |
| **URL:**        | <https://CRAN.R-project.org/view=PackageDevelopment> |

Packages provide a mechanism for loading optional code, data, and documentation as needed. At the very minimum only a text editor and an R installation are needed for package creation. Nonetheless many useful tools and R packages themselves have been provided to ease or improve package development. This Task View focuses on these tools/R packages, grouped by topics.

The main reference for packages development is the ["Writing R Extension"](http://cran.r-project.org/doc/manuals/R-exts.html) manual. For further documentation and tutorials, see the "Related links" section below.

If you think that some packages or tools are missing from the list, feel free to [e-mail](mailto:thosjleeper@gmail.com) me or contribute directly to the Task View by submitting a pull request on [GitHub](https://github.com/ropensci/PackageDevelopment/blob/master/CONTRIBUTING.md).

Many thanks to Christopher Gandrud, Cristophe Dutang, Darren Norris, Dirk Eddelbuettel, Gabor Grothendieck, Gregory Jefferis, John Maindonald, Luca Braglia, Spencer Graves, Tobias Verbeke, and the R-core team for contributions.

First steps
-----------

### Searching for Existing Packages

Before starting a new package it's worth searching for already available packages, both from a developer's standpoint ("do not reinvent the wheel") and from a user's one (many packages implementing same/similar procedures can be confusing). If a package addressing the same functionality already exists, you may consider contributing at it instead of starting a new one.

-   `utils::RSiteSearch()` allows to search for keywords/phrases in help pages (all the CRAN packages except those for Windows only and some from Bioconductor), vignettes or task views, using the search engine at <a href="http://search.r-project.org/" class="uri" class="uri">http://search.r-project.org/</a>. A convenient wrapper around `RSiteSearch` that adds hits ranking is `findFn()` function, from [sos](http://cran.rstudio.com/web/packages/sos/index.html).
-   [RSeek](http://rseek.org/) allows to search for keywords/phrases in books, task views, support lists, function/packages, blogs etc.
-   [Rdocumentation](https://www.rdocumentation.org/) allows to search for keywords/phrases in help pages for all CRAN and some Bioconductor/GitHub packages. [RDocumentation](http://cran.rstudio.com/web/packages/RDocumentation/index.html) ([GitHub](https://github.com/datacamp/RDocumentation/)) provides an R client for the site.
-   <a href="http://www.r-pkg.org/" class="uri" class="uri">http://www.r-pkg.org/</a> is an unofficial CRAN mirror that provides a relatively complete archive of package and read-only access to package sources on Github.
-   [CRANberries](http://dirk.eddelbuettel.com/cranberries/) provides a feed of new, updated, and removed packages for CRAN.
-   If you're looking to create a package, but want ideas for what sorts of packages are in demand, the [rOpenSci](https://ropensci.org/) maintains [a wishlist for science-related packages](https://github.com/ropensci/wishlist) and [a TODO list of web services and data APIs in need of packaging](https://github.com/ropensci/webservices/wiki/ToDo).

### Initializing an R package

-   `utils::package.skeleton()` automates some of the setup for a new source package. It creates directories, saves functions, data, and R code files provided to appropriate places, and creates skeleton help files and a `Read-and-delete-me` file describing further steps in packaging
-   `create()` from [devtools](http://cran.rstudio.com/web/packages/devtools/index.html) is similar to `package.skeleton` except it allows to specify `DESCRIPTION` entries and doesn't create source code and data files from global environment objects or sourced files.
-   Non-devtools alternatives also exist. `kitten()` from [pkgKitten](http://cran.rstudio.com/web/packages/pkgKitten/index.html) allows one to specify the main `DESCRIPTION` entries and doesn't create source code and data files from global environment objects or sourced files. It's used to initialize a simple package that passes `R CMD check` cleanly. [skeletor](http://cran.rstudio.com/web/packages/skeletor/index.html) provides another non-devtools skeleton-building function with a wider set of defaults and options.
-   [mason](https://github.com/metacran/mason) (not the package on CRAN of the same name) provides a fun, interactive tool for creating a package based on a variety of inputs.
-   [available](http://cran.rstudio.com/web/packages/available/index.html) ([GitHub](https://github.com/ropenscilabs/available)) checks whether a package name is available and checks for unintended (typically bad) meanings in a potential package name.
-   `Rcpp.package.skeleton()` from [Rcpp](http://cran.rstudio.com/web/packages/Rcpp/index.html) adds to `package.skeleton` the C++ via `Rcpp` handling, by modifying eg. `DESCRIPTION` and `NAMESPACE` accordingly, creating examples if needed and allowing the user to specify (with a character vector of paths) which C++ files to include in `src` directory . Finally the user can decide main `DESCRIPTION` entries.
-   [mvbutils](http://cran.rstudio.com/web/packages/mvbutils/index.html) provides a variety of useful functions for development which include tools for managing and analyzing the development environment, auto-generating certain function types, and visualizing a function dependency graph. [pagerank](https://github.com/andrie/pagerank) (not on CRAN) can calculate a package's PageRank from its dependency graph.
-   [swagger](https://github.com/hrbrmstr/swagger) (not on CRAN) uses the [Swagger](http://swagger.io/) JSON web service API specification to automatically generate an R client package for a web service API.

R packages require a `Version` string in the `DESCRIPTION` file. Traditionally, packages have been versioned using a `MAJOR.MINOR-PATCH` format, sometimes using the version's date as the `PATCH` component. More recently, [semantic versioning](http://semver.org/) has become common. [semver](http://cran.rstudio.com/web/packages/semver/index.html) ([GitHub](https://github.com/johndharrison/semver)) provides tools to parse and manipulate semantic version strings.

When initializing a package, it is worth considering how it should be licensed. CRAN provides [a list of the most commonly used software licences](https://cran.r-project.org/web/licenses/) for R packages. [osi](http://cran.rstudio.com/web/packages/osi/index.html) ([GitHub](https://github.com/Ironholds/osi/)) provides a more comprehensive list in a standardized format.

### Programming Paradigms

R is foremost a functional programming language with dynamic typing, but has three built-in forms of object-oriented programming as well as additional object-oriented paradigms available in add-on packages.

-   The built-in S3 classes involve wherein a generic function (e.g., `summary`) employs a distinct method for an object of a given class (i.e., it is possible to implement class-specific methods for a given generic function). If a package implements new object classes, it is common to implement methods for commonly used generics such as `print`, `summary`, etc. These methods must be registered in the package's NAMESPACE file. [R.methodsS3](http://cran.rstudio.com/web/packages/R.methodsS3/index.html) aims to simplify the creation of S3 generic functions and S3 methods.
-   S4 is a more formalized form of object orientation that is available through `methods`. S4 classes have formal definitions and can dispatch methods based on multiple arguments (not just the first argument, as in S3). S4 is notable for its use of the `@` symbol to extract slots from S4 objects. John Chambers's ["How S4 Methods Work"](http://developer.r-project.org/howMethodsWork.pdf) tutorial may serve as a useful introduction.
-   Reference classes were introduced in R2.12.0 and are also part of `methods`. They offer a distinct paradigm from S3 and S4 due to the fact that reference class objects are mutable and that methods belong to objects, not generic functions.
-   [aoos](http://cran.rstudio.com/web/packages/aoos/index.html) and [R.oo](http://cran.rstudio.com/web/packages/R.oo/index.html) are other packages facilitating object-oriented programming. [R6](http://cran.rstudio.com/web/packages/R6/index.html) ([Github](https://github.com/wch/R6)) provides an alternative to reference classes without a dependency on `methods`.
-   [proto](http://cran.rstudio.com/web/packages/proto/index.html) provides a prototype-based object orientated programming paradigm.
-   [rtype](http://cran.rstudio.com/web/packages/rtype/index.html) provides a strong type system.
-   [argufy](https://github.com/gaborcsardi/argufy) (Not on CRAN), provides a syntax for creating functions with strictly typed arguments, among other possible checks.
-   [lambda.r](http://cran.rstudio.com/web/packages/lambda.r/index.html), [lambdaR](https://github.com/hoxo-m/lambdaR) (not on CRAN), and [purrr](http://cran.rstudio.com/web/packages/purrr/index.html) provide interfaces for creating lambda (anonymous) functions.
-   [functools](http://cran.rstudio.com/web/packages/functools/index.html) ([GitHub](https://github.com/paulhendricks/functools)) provides higher-order functions (Map, Reduce, etc.) common in funcitonal programming.
-   [later](http://cran.rstudio.com/web/packages/later/index.html) ([GitHub](https://github.com/r-lib/later)) provides the ability to postpone execution of R or C code.

Another feature of R is the ability to rely on both standard and non-standard evaluation of function arguments. Non-standard evaluation is seen in commonly used functions like `library` and `subset` and can also be used in packages.

-   `substitute()` provides the most straightforward interface to non-standard evaluation of function arguments.
-   [rlang](http://cran.rstudio.com/web/packages/rlang/index.html) ([Github](https://github.com/tidyverse/rlang)) aims to help developers tools for non-standard evaluation.
-   An increasingly popular form of non-standard evaluation involves chained expressions or "pipelines". [magrittr](http://cran.rstudio.com/web/packages/magrittr/index.html) provides the `%>%` chaining operator that passes the results of one expression evaluation to the next expression in the chain, as well as other similar piping operators. [pipeR](http://cran.rstudio.com/web/packages/pipeR/index.html) offers a larger set of pipe operators. [assertr](http://cran.rstudio.com/web/packages/assertr/index.html) and [ensurer](http://cran.rstudio.com/web/packages/ensurer/index.html) provide (fairly similar) testing frameworks for pipelines.

### Dependency Management

Packages that have dependencies on other packages need to be vigilant of changes to the functionality, behaviour, or API of those packages.

-   [CodeDepends](http://cran.rstudio.com/web/packages/CodeDepends/index.html) provides tools for examining dependencies between blocks of code.
-   [backports](http://cran.rstudio.com/web/packages/backports/index.html) ([GitHub](https://github.com/mllg/backports)) provides reimplementations of functions added to base R packages since v3.0.0, making them available in older versions of R. This gives package developers the ability to reduce or eliminate a dependency on specific versions of R itself.
-   [pkgverse](https://github.com/mkearney/pkgverse) (not on CRAN) provides tools for creating an integrated, installable "universe" of R packages, in the style of the ["tidyverse"](https://www.tidyverse.org/).
-   [packrat](http://cran.rstudio.com/web/packages/packrat/index.html) ([GitHub](https://github.com/rstudio/packrat)) provides facilities for creating local package repositories to manage and check dependencies.
-   [checkpoint](http://cran.rstudio.com/web/packages/checkpoint/index.html) relies on the Revolution Analytics MRAN repository to access packages from specified dates.
-   [pacman](http://cran.rstudio.com/web/packages/pacman/index.html) ([GitHub](https://github.com/trinker/pacman)) can install, uninstall, load, and unload various versions of packages from CRAN and Github.
-   [GRANBase](http://cran.rstudio.com/web/packages/GRANBase/index.html) ([GitHub](https://github.com/gmbecker/gRAN)) provides some sophisticated tools for managing dependencies and testing packages conditional on changes.
-   [cranly](http://cran.rstudio.com/web/packages/cranly/index.html) ([GitHub](https://github.com/ikosmidis/cranly)) provides tools for creating and visualizing dependency graphs among packages on CRAN.
-   Two packages currently provide alternative ways to import objects from packages in non-standard ways (e.g., to assign those objects different names from the names used in their host packages). [import](http://cran.rstudio.com/web/packages/import/index.html) ([GitHub](https://github.com/smbache/import)) can import numerous objects from a namespace and assign arbitrary names. [modules](https://github.com/klmr/modules) (not on CRAN) provides functionality for importing alternative non-package code from Python-like "modules".
-   [Rocker](https://github.com/rocker-org) is an initiative to create Docker configurations for R and packages. [containerit](https://github.com/o2r-project/containerit/) (not on CRAN) can be used to package an R workspace and all dependencies as a Docker container.

Source Code
-----------

### Foreign Languages Interfaces

-   R's base functions `system()`, `system2()`, and - on Windows - `shell.exec()` - provide interfaces for calling system functions. [sys](http://cran.rstudio.com/web/packages/sys/index.html) ([GitHub](https://github.com/jeroen/sys/)) and [processx](https://github.com/r-pkgs/processx) (not on CRAN) provide unified, platform-independent APIs for running system processes.
-   [inline](http://cran.rstudio.com/web/packages/inline/index.html) eases adding code in C, C++, or Fortran to R. It takes care of the compilation, linking and loading of embedded code segments that are stored as R strings.
-   [Rcpp](http://cran.rstudio.com/web/packages/Rcpp/index.html) offers a number of C++ classes that makes transferring R objects to C++ functions (and back) easier. [RInside](http://cran.rstudio.com/web/packages/RInside/index.html) provides C++ classes for embedding within C++ applications.
-   [rGroovy](http://cran.rstudio.com/web/packages/rGroovy/index.html) integrates with the [Groovy scripting language](http://www.groovy-lang.org/).
-   [rJava](http://cran.rstudio.com/web/packages/rJava/index.html) provides a low-level interface to Java similar to the `.Call` interface for C and C++. [helloJavaWorld](http://cran.rstudio.com/web/packages/helloJavaWorld/index.html) provides an example rJava-based package. [jvmr](https://dahl.byu.edu/software/jvmr/) (archived on CRAN) provides a bi-directional interface to Java, Scala, and related languages, while [rscala](http://cran.rstudio.com/web/packages/rscala/index.html) is designed specifically for Scala.
-   [rustr](https://github.com/rustr/rustr) provides bindings to Rust.
-   [reach](https://github.com/schmidtchristoph/reach) (not on CRAN) and [matlabr](http://cran.rstudio.com/web/packages/matlabr/index.html) provide rough interfaces to Matlab.
-   [rPython](http://cran.rstudio.com/web/packages/rPython/index.html), [rJython](http://cran.rstudio.com/web/packages/rJython/index.html), [PythonInR](http://cran.rstudio.com/web/packages/PythonInR/index.html), [rpy2](http://rpy.sourceforge.net/) (not on CRAN), and [SnakeCharmR](https://github.com/asieira/SnakeCharmR) (not on CRAN) provide interfaces to python. [reticulate](http://cran.rstudio.com/web/packages/reticulate/index.html) ([GitHub](https://github.com/rstudio/reticulate)) is a relatively recent interface built by RStudio.
-   [RJulia](https://github.com/armgong/RJulia) (not on CRAN) provides an interface with Julia, as does [XRJulia](http://cran.rstudio.com/web/packages/XRJulia/index.html). [RCall](https://github.com/JuliaInterop/RCall.jl) embeds R within Julia.
-   [RStata](http://cran.rstudio.com/web/packages/RStata/index.html) is an interface with Stata. [RCall](https://github.com/haghish/Rcall) embeds R in Stata.
-   `tcltk`, which is a package built in to R, provides an general interface to Tcl, usefully especially for accessing Tcl/tk (for graphical interfaces). [after](https://github.com/gaborcsardi/after) (not on CRAN) uses tcltk to run R code in a separate event loop.
-   [V8](http://cran.rstudio.com/web/packages/V8/index.html) offers an embedded Javascript engine, useful for building packages around Javascript libraries. [js](http://cran.rstudio.com/web/packages/js/index.html) provides additional tools for working with Javascript code.

The [knitr](http://cran.rstudio.com/web/packages/knitr/index.html) package, which supplies [various foreign language engines](https://yihui.name/knitr/demo/engines/), can also be used to generate documents that call python, awk, ruby, haskell, bash, perl, dot, tikz, sas, coffeescript, and polyglot.

Writing packages that involve compiled code requires a developer toolchain. If developing on Windows, this requires [Rtools](http://cran.r-project.org/bin/windows/Rtools/), which is updated with each R minor release.

### Debugging

-   [futile.logger](http://cran.rstudio.com/web/packages/futile.logger/index.html), [log4r](http://cran.rstudio.com/web/packages/log4r/index.html), and [logging](http://cran.rstudio.com/web/packages/logging/index.html) provide logging functionality in the style of [log4j](https://en.wikipedia.org/wiki/Log4j).
-   [loggr](https://github.com/smbache/loggr) (not on CRAN) aims to provide a simplified logging interface without the need for `withCallingHandlers()` expressions.
-   [rollbar](http://cran.rstudio.com/web/packages/rollbar/index.html) reports messages and errors to [Rollbar](https://rollbar.com/), a web service.
-   The [rchk](https://github.com/kalibera/rchk) tool provides tools for identifying memory-protection bugs in C code, including base R and packages.

### Code Analysis and Formatting

-   [codetools](http://cran.rstudio.com/web/packages/codetools/index.html) provides a number of low-level functions for identifying possible problems with source code.
-   [lintr](http://cran.rstudio.com/web/packages/lintr/index.html) provides tools for checking source code compliance with a style guide.
-   [formatR](http://cran.rstudio.com/web/packages/formatR/index.html) and [rfmt](https://github.com/google/rfmt/) (not on CRAN) can be used to neatly format source code.
-   [FuncMap](http://cran.rstudio.com/web/packages/FuncMap/index.html) provides a graphical representation of function calls used in a package.
-   [pkggraph](http://cran.rstudio.com/web/packages/pkggraph/index.html) ([GitHub](https://github.com/talegari/pkggraph)) and [functionMap](https://github.com/MangoTheCat/functionMap) provide tools useful for understanding function dependencies within and across packages. [atomize](https://github.com/ropenscilabs/atomize) can quickly extract functions from within a package into their own package. [requirements](https://github.com/hadley/requirements) (not on CRAN) checks R code files for implicit and explicit package dependencies.
-   [pkgnet](http://cran.rstudio.com/web/packages/pkgnet/index.html) ([GitHub](https://github.com/UptakeOpenSource/pkgnet)) uses concepts from graph theory to quantify the complexity and vulnerability to failure of a software package based upon dependencies between functions and between package dependencies.

### Profiling

-   Profiling data is provided by `utils::Rprof()` and can be summarized by `utils::summaryRprof()`. [prof.tree](http://cran.rstudio.com/web/packages/prof.tree/index.html) ([GitHub](https://github.com/artemklevtsov/prof.tree)) provides an alternative output data structure to `Rprof()`. [profmem](http://cran.rstudio.com/web/packages/profmem/index.html) ([GitHub](https://github.com/HenrikBengtsson/profmem)) adds a simple interface on top of this.
-   [profr](http://cran.rstudio.com/web/packages/profr/index.html) can visualize output from the `Rprof` interface for profiling.
-   [proftools](http://cran.rstudio.com/web/packages/proftools/index.html) and [aprof](http://cran.rstudio.com/web/packages/aprof/index.html) can also be used to analyse profiling output.
-   [profvis](https://github.com/rstudio/profvis) (not on CRAN) provides an interactive, graphical interface for examining profile results.
-   [lineprof](https://github.com/hadley/lineprof) (not on CRAN) provides a visualization tool for examining profiling results.
-   [Rperform](https://github.com/analyticalmonk/Rperform) (not on CRAN) compares package performance across different git versions and branches.

### Benchmarking

-   `base::system.time()` is a basic timing utility that calculates times based on one iteration of an expression.
-   [microbenchmark](http://cran.rstudio.com/web/packages/microbenchmark/index.html) and [rbenchmark](http://cran.rstudio.com/web/packages/rbenchmark/index.html) provide timings based on multiple iterations of an expression and potentially provide more reliable timings than `system.time()`

### Unit Testing

-   Packages should pass all basic code and documentation checks provided by the `R CMD check` quality assurance tools built in to R. [rcmdcheck](http://cran.rstudio.com/web/packages/rcmdcheck/index.html) provides programmatic access to `R CMD check` from within R and [callr](https://github.com/r-pkgs/callr) (not on CRAN) provides a generic interface for calling R from within R.
-   R documentation files can contain demonstrative examples of package functionality. Complete testing of correct package performance is better reserved for the `test` directory. Several packages provide testing functionality, including [RUnit](http://cran.rstudio.com/web/packages/RUnit/index.html), [svUnit](http://cran.rstudio.com/web/packages/svUnit/index.html), [testit](http://cran.rstudio.com/web/packages/testit/index.html) ([GitHub](https://github.com/yihui/testit)), [testthat](http://cran.rstudio.com/web/packages/testthat/index.html), [testthatsomemore](https://github.com/robertzk/testthatsomemore) (not on CRAN), and [pkgmaker](http://cran.rstudio.com/web/packages/pkgmaker/index.html). [runittotestthat](http://cran.rstudio.com/web/packages/runittotestthat/index.html) provides utilities for converting exiting RUnit tests to testthat tests.
-   [unitizer](http://cran.rstudio.com/web/packages/unitizer/index.html) ([GitHub](https://github.com/brodieG/unitizer)) provides tools for regression testing by comparing test output against previous runs of the same tests. The package has extensive vignette-based documentation.
-   [vdiffr](http://cran.rstudio.com/web/packages/vdiffr/index.html) ([GitHub](https://github.com/lionel-/vdiffr)) can be used for graphical unit tests.
-   [assertive](http://cran.rstudio.com/web/packages/assertive/index.html), [assertr](http://cran.rstudio.com/web/packages/assertr/index.html), [checkmate](http://cran.rstudio.com/web/packages/checkmate/index.html) [ensurer](http://cran.rstudio.com/web/packages/ensurer/index.html), and [assertthat](http://cran.rstudio.com/web/packages/assertthat/index.html) provide test-like functions for use at run-time or in examples that will trigger messages, warnings, or errors if an R object differs from what is expected by the user or developer.
-   [mockr](http://cran.rstudio.com/web/packages/mockr/index.html) ([GitHub](https://github.com/krlmlr/mockr)) provides tools to mock a function in a test context. This can be useful for standardizing the test of a function that calls other functions by fixing the output of those function dependencies.
-   [covr](http://cran.rstudio.com/web/packages/covr/index.html) and [testCoverage](https://github.com/MangoTheCat/testCoverage) (not on CRAN) offer utilities for monitoring how well tests cover a package's source code. These can be complemented by services such as [Codecov](https://codecov.io/) or [Coveralls](https://coveralls.io/) that provide web interfaces for assessing code coverage.
-   [withr](http://cran.rstudio.com/web/packages/withr/index.html) ([GitHub](https://github.com/jimhester/withr)) provides functions to evaluate code within a temporarily modified global state, which may be useful for unit testing, debugging, or package development.
-   The `devtools::use_revdep()` and `revdep_check()` functions from [devtools](http://cran.rstudio.com/web/packages/devtools/index.html) can be used to test reverse package dependencies to ensure code changes have not affected downstream package functionality. [crandalf](https://github.com/yihui/crandalf) (not on CRAN) provides an alternative mechanism for testing reverse dependencies.

### Internationalization and Localization

-   There is no standard mechanism for translation of package documentation into languages other than English. To create non-English documentation requires manual creation of supplemental .Rd files or package vignettes. Packages supplying non-English documentation should include a `Language` field in the DESCRIPTION file.
-   R provides useful features for the localization of diagnostic messages, warnings, and errors from functions at both the C and R levels based on GNU `gettext`. ["Translating R Messages"](http://developer.r-project.org/Translations30.html) describes the process of creating and installing message translations.

### Creating Graphical Interfaces

-   For simple interactive interfaces, `readline()` can be used to create a simple prompt. [getPass](http://cran.rstudio.com/web/packages/getPass/index.html) provides cross-platform mechanisms for securely requesting user input without displaying the intput (e.g., for passwords). `utils::menu()`, `utils::select.list()` can provide graphical and console-based selection of items from a list, and `utils::txtProgressBar()` provides a simple text progress bar.
-   `tcltk` is an R base package that provides a large set of tools for creating interfaces uses Tcl/tk (most functions are thin wrappers around corresponding Tcl and tk functions), though the documentation is sparse. [tcltk2](http://cran.rstudio.com/web/packages/tcltk2/index.html) provides additional widgets and functionality. [qtbase](http://cran.rstudio.com/web/packages/qtbase/index.html) provides bindings for Qt. [<span class="Ohat">RGtk</span>](http://www.Omegahat.net/RGtk/) (not on CRAN) provides bindings for Gtk and gnome. [gWidgets2](http://cran.rstudio.com/web/packages/gWidgets2/index.html) offers a language-independent API for building graphical user interfaces in Gtk, Qt, or Tcl/tk.
-   [fgui](http://cran.rstudio.com/web/packages/fgui/index.html) can create a Tcl/tk interface for any arbitrary function.
-   [shiny](http://cran.rstudio.com/web/packages/shiny/index.html) provides a browser-based infrastructure for creating dashboards and interfaces for R functionality. [htmlwidgets](http://cran.rstudio.com/web/packages/htmlwidgets/index.html) is a shiny enhancement that provides a framework for creating HTML widgets.
-   [progress](http://cran.rstudio.com/web/packages/progress/index.html) ([Github](https://github.com/gaborcsardi/progress)) offers progress bars for the terminal, including a C++ API.

### Command Line Argument Parsing

-   Several packages provide functionality for parsing command line arguments: [argparse](http://cran.rstudio.com/web/packages/argparse/index.html), [argparser](http://cran.rstudio.com/web/packages/argparser/index.html), [commandr](http://cran.rstudio.com/web/packages/commandr/index.html), [docopt](http://cran.rstudio.com/web/packages/docopt/index.html), [GetoptLong](http://cran.rstudio.com/web/packages/GetoptLong/index.html), and [optigrab](http://cran.rstudio.com/web/packages/optigrab/index.html).

### Using Options in Packages

-   [pkgconfig](http://cran.rstudio.com/web/packages/pkgconfig/index.html) ([GitHu](https://github.com/gaborcsardi/pkgconfig)) allows developers to set package-specific options, which will not affect options set or used by other packages.

Documentation
-------------

### Writing Package Documentation

Package documentation is written in a TeX-like format as .Rd files that are stored in the `man` subdirectory of a package. These files are compiled to plain text, HTML, or PDF by R as needed.

-   One can write .Rd files directly. A popular alternative is to rely on [roxygen2](http://cran.rstudio.com/web/packages/roxygen2/index.html), which uses special markup in R source files to generate documentation files before a package is built. This functionality is provided by `roxygen2::roxygenise()` and underlies `devtools::document()`. roxygen2 eliminates the need to learn *some* of the formatting requirements of an .Rd file at the cost of adding a step to the development process (the need to roxygenise before calling `R CMD build`). Recent versions of roxygen2 support full markdown-based documentation without the need for any native Rd formatting.
-   [Rd2roxygen](http://cran.rstudio.com/web/packages/Rd2roxygen/index.html) can convert existing .Rd files to roxygen source documentation, facilitating the conversion of existing documentation to an roxygen workflow. [roxygen2md](https://github.com/r-pkgs/roxygen2md) (not on CRAN) provides tools for further converting Rd markup within roxygen comments to markdown format (supported by the latest versions of roxygen2).
-   [roxyPackage](https://github.com/unDocUMeantIt/roxyPackage) (not on CRAN) provides some additional functionality for maintaining package documentation.
-   [inlinedocs](http://cran.rstudio.com/web/packages/inlinedocs/index.html) and [documair](http://cran.rstudio.com/web/packages/documair/index.html) provide further alternative documentation schemes based on source code commenting.
-   `tools::parse_Rd()` can be used to manipulate the contents of an .Rd file. `tools::checkRd()` is useful for validating an .Rd file. Duncan Murdoch's ["Parsing Rd files"](https://developer.r-project.org/parseRd.pdf) tutorial is a useful reference for advanced use of R documentation. [Rdpack](http://cran.rstudio.com/web/packages/Rdpack/index.html) provides additional tools for manipulating documentation files.
-   [packagedocs](http://cran.rstudio.com/web/packages/packagedocs/index.html) and [pkgdown](http://cran.rstudio.com/web/packages/pkgdown/index.html) can be used to generate static websites from R documentation files.

### Writing Vignettes

Package vignettes provides additional documentation of package functionality that is not tied to a specific function (as in an .Rd file). Historically, vignettes were used to explain the statistical or computational approach taken by a package in an article-like format that would be rendered as a PDF document using `Sweave`. Since R 3.0.0, non-Sweave vignette engines have also been supported, including [knitr](http://cran.rstudio.com/web/packages/knitr/index.html), which can produce Sweave-like PDF vignettes but can also support HTML vignettes that are written in R-flavored markdown. To use a non-Sweave vignette engine, the vignette needs to start with a code block indicating the package and function to be used:

> % %

### Spell Checking

-   `utils` provides multiple functions for spell-checking portions of packages, including .Rd files ( `utils::aspell_package_Rd_files`) and vignettes ( `utils::aspell_package_vignettes`) via the general purpose `aspell` function, which requires a system spell checking library, such as http://aspell.net/, http://hunspell.github.io/, or https://www.cs.hmc.edu/~geoff/ispell.html.
-   [hunspell](http://cran.rstudio.com/web/packages/hunspell/index.html) provides an interface to hunspell.

### Data in Packages

-   [lazyData](http://cran.rstudio.com/web/packages/lazyData/index.html) offers the ability to use data contained within packages that have not been configured using LazyData.

Tools and Services
------------------

### Text Editors and IDEs

-   By far the most popular [integrated development environment (IDE)](https://en.wikibooks.org/wiki/R_Programming/Settings) for R is [RStudio](https://www.rstudio.com/), which is an open-source product available with both commercial and AGPL licensing. It can be run both locally and on a remote server. [rstudioapi](http://cran.rstudio.com/web/packages/rstudioapi/index.html) facilitates interaction from RStudio from within R.
-   [StatET](http://www.walware.de/goto/statet) is an R plug-in for the Eclipse IDE.
-   [Emacs Speaks Statistics (ESS)](http://ess.r-project.org/) is a feature-rich add-on package for editors like Emacs or XEmacs.

### Makefiles

-   [GNU Make](http://www.gnu.org/software/make/) is a tool that typically builds executable programs and libraries from source code by reading files called `Makefile`. It can be used to manage R package as well; [maker](https://github.com/ComputationalProteomicsUnit/maker) is a `Makefile` completely devoted to R package development based on [makeR](https://github.com/tudo-r/makeR).
-   [remake](https://github.com/richfitz/remake) (not on CRAN) provides a yaml-based, Makefile-like format that can be used in Make-like workflows from within R.

### Version Control

-   R itself is maintained under version control using [Subversion](https://subversion.apache.org/).
-   Many packages are maintained using [git](https://git-scm.com/), particularly those hosted on [GitHub](https://github.com/). [git2r](http://cran.rstudio.com/web/packages/git2r/index.html) ([Github](https://github.com/ropensci/git2r)) provides bindings to [libgit2](https://libgit2.github.com/) for programmatic use of git within R.

### Hosting and Package Building Services

Many [hosting services](https://en.wikipedia.org/wiki/Comparison_of_open-source_software_hosting_facilities) are available. Use of different hosts depends largely on what type of version control software is used to maintain a package. The most common sites are:

-   [R-Forge](http://r-forge.r-project.org/), which relies on [Subversion](http://subversion.apache.org/). [Rforge.net](https://rforge.net/) is another popular Subversion-based system.
-   [r-hub](http://log.r-hub.io/) is a modern package test service funded by the RConsortium . [rhub](http://cran.rstudio.com/web/packages/rhub/index.html) ([GitHub](https://github.com/r-hub/rhub)) provides an R client for the site's API.
-   [GitHub](https://github.com/) [mainly](https://help.github.com/articles/support-for-subversion-clients/) supports Git and Mercurial. Packages hosted on Github can be installed directly using `devtools::install_github()` or `remotes::install_github()` from [remotes](http://cran.rstudio.com/web/packages/remotes/index.html). [gh](https://github.com/r-pkgs/gh) (not on CRAN) is a lightweight client for the GitHub API. [githubtools](https://github.com/jonocarroll/githubtools) (not on CRAN) provides some resources for including GitHub-related links in package documentation and for analyzing packages installed from GitHub.
-   [Bitbucket](https://bitbucket.org/) is an alternative host that provides no-cost private repositories and [GitLab](https://about.gitlab.com/) is an open source alternative. [gitlabr](http://cran.rstudio.com/web/packages/gitlabr/index.html) provides is an API client for managing Gitlab projects.
-   Github supports [continuous integration](https://en.wikipedia.org/wiki/Continuous_integration) for R packages. [Travis CI](https://travis-ci.org/) is a popular continuous integration tools that supports Linux and OS X build environments. Travis has native R support, and can easily provide code coverage information via [covr](http://cran.rstudio.com/web/packages/covr/index.html) to [Codecov.io](https://codecov.io/) or [Coveralls](https://coveralls.io/). [travis](https://github.com/ropenscilabs/travis) (not on CRAN) provides an API client for Travis. Use of other CI services, such as [Circle CI](https://circleci.com/) may require additional code and examples are available from [r-travis](https://github.com/craigcitro/r-travis) and/or [r-builder](https://github.com/metacran/r-builder). [circleci](https://github.com/cloudyr/circleci) (not on CRAN) provides an API client for Circle CI. [badgecreatr](http://cran.rstudio.com/web/packages/badgecreatr/index.html) ([GitHub](https://github.com/RMHogervorst/badgecreatr)) provides a convenient way of creating standardized badges (or "shields") for package READMEs.
-   [WinBuilder](http://win-builder.r-project.org/) is a service intended for useRs who do not have Windows available for checking and building Windows binary packages. The package sources (after an `R CMD check`) can be uploaded via html form or passive ftp in binary mode; after checking/building a mail will be sent to the `Maintainer` with links to the package zip file and logs for download/inspection. [Appveyor](https://www.appveyor.com/) is a continuous integration service that offers a Windows build environment. [r-appveyor](https://github.com/krlmlr/r-appveyor) (not on CRAN) and [appveyor](https://github.com/cloudyr/appveyor) (not on CRAN) provide API clients for Appveyor.
-   [Rocker](https://github.com/rocker-org/rocker) provides containers for use with [Docker](https://www.docker.com/). [harbor](https://github.com/wch/harbor) can be used to control docker containers on remote and local hosts and [dockertest](https://github.com/traitecoevo/dockertest) provides facilities for running tests on docker.
-   Some packages, especially some that are no longer under active development, remain hosted on [Google Code](https://code.google.com/). This service is closed to new projects, however, and will shut down in January 2016.
-   [drat](http://cran.rstudio.com/web/packages/drat/index.html) can be used to distribute pre-built packages via Github or another server. [craneur](https://github.com/ColinFay/craneur) (not on CRAN) provides another way of creating the same. [miniCRAN](http://cran.rstudio.com/web/packages/miniCRAN/index.html) can be used to create a subset of CRAN, for example for self-hosting of packages and their dependencies.
-   CRAN does not provide package download statistics, but the RStudio CRAN mirror does. [packagetrackr](http://cran.rstudio.com/web/packages/packagetrackr/index.html) ([Source](http://gitlab.points-of-interest.cc/points-of-interest/packagetrackr)) facilitates downloading and analyzing those logs.

### CRAN packages:

-   [aoos](http://cran.rstudio.com/web/packages/aoos/index.html)
-   [aprof](http://cran.rstudio.com/web/packages/aprof/index.html)
-   [argparse](http://cran.rstudio.com/web/packages/argparse/index.html)
-   [argparser](http://cran.rstudio.com/web/packages/argparser/index.html)
-   [assertive](http://cran.rstudio.com/web/packages/assertive/index.html)
-   [assertr](http://cran.rstudio.com/web/packages/assertr/index.html)
-   [assertthat](http://cran.rstudio.com/web/packages/assertthat/index.html)
-   [available](http://cran.rstudio.com/web/packages/available/index.html)
-   [backports](http://cran.rstudio.com/web/packages/backports/index.html)
-   [badgecreatr](http://cran.rstudio.com/web/packages/badgecreatr/index.html)
-   [checkmate](http://cran.rstudio.com/web/packages/checkmate/index.html)
-   [checkpoint](http://cran.rstudio.com/web/packages/checkpoint/index.html)
-   [CodeDepends](http://cran.rstudio.com/web/packages/CodeDepends/index.html)
-   [codetools](http://cran.rstudio.com/web/packages/codetools/index.html)
-   [commandr](http://cran.rstudio.com/web/packages/commandr/index.html)
-   [covr](http://cran.rstudio.com/web/packages/covr/index.html)
-   [cranly](http://cran.rstudio.com/web/packages/cranly/index.html)
-   [devtools](http://cran.rstudio.com/web/packages/devtools/index.html) (core)
-   [docopt](http://cran.rstudio.com/web/packages/docopt/index.html)
-   [documair](http://cran.rstudio.com/web/packages/documair/index.html)
-   [drat](http://cran.rstudio.com/web/packages/drat/index.html)
-   [ensurer](http://cran.rstudio.com/web/packages/ensurer/index.html)
-   [fgui](http://cran.rstudio.com/web/packages/fgui/index.html)
-   [formatR](http://cran.rstudio.com/web/packages/formatR/index.html)
-   [FuncMap](http://cran.rstudio.com/web/packages/FuncMap/index.html)
-   [functools](http://cran.rstudio.com/web/packages/functools/index.html)
-   [futile.logger](http://cran.rstudio.com/web/packages/futile.logger/index.html)
-   [GetoptLong](http://cran.rstudio.com/web/packages/GetoptLong/index.html)
-   [getPass](http://cran.rstudio.com/web/packages/getPass/index.html)
-   [git2r](http://cran.rstudio.com/web/packages/git2r/index.html)
-   [gitlabr](http://cran.rstudio.com/web/packages/gitlabr/index.html)
-   [GRANBase](http://cran.rstudio.com/web/packages/GRANBase/index.html)
-   [gWidgets2](http://cran.rstudio.com/web/packages/gWidgets2/index.html)
-   [helloJavaWorld](http://cran.rstudio.com/web/packages/helloJavaWorld/index.html)
-   [htmlwidgets](http://cran.rstudio.com/web/packages/htmlwidgets/index.html)
-   [hunspell](http://cran.rstudio.com/web/packages/hunspell/index.html)
-   [import](http://cran.rstudio.com/web/packages/import/index.html)
-   [inline](http://cran.rstudio.com/web/packages/inline/index.html)
-   [inlinedocs](http://cran.rstudio.com/web/packages/inlinedocs/index.html)
-   [js](http://cran.rstudio.com/web/packages/js/index.html)
-   [knitr](http://cran.rstudio.com/web/packages/knitr/index.html) (core)
-   [lambda.r](http://cran.rstudio.com/web/packages/lambda.r/index.html)
-   [later](http://cran.rstudio.com/web/packages/later/index.html)
-   [lazyData](http://cran.rstudio.com/web/packages/lazyData/index.html)
-   [lintr](http://cran.rstudio.com/web/packages/lintr/index.html)
-   [log4r](http://cran.rstudio.com/web/packages/log4r/index.html)
-   [logging](http://cran.rstudio.com/web/packages/logging/index.html)
-   [magrittr](http://cran.rstudio.com/web/packages/magrittr/index.html)
-   [matlabr](http://cran.rstudio.com/web/packages/matlabr/index.html)
-   [microbenchmark](http://cran.rstudio.com/web/packages/microbenchmark/index.html)
-   [miniCRAN](http://cran.rstudio.com/web/packages/miniCRAN/index.html)
-   [mockr](http://cran.rstudio.com/web/packages/mockr/index.html)
-   [mvbutils](http://cran.rstudio.com/web/packages/mvbutils/index.html)
-   [optigrab](http://cran.rstudio.com/web/packages/optigrab/index.html)
-   [osi](http://cran.rstudio.com/web/packages/osi/index.html)
-   [packagedocs](http://cran.rstudio.com/web/packages/packagedocs/index.html)
-   [packagetrackr](http://cran.rstudio.com/web/packages/packagetrackr/index.html)
-   [packrat](http://cran.rstudio.com/web/packages/packrat/index.html)
-   [pacman](http://cran.rstudio.com/web/packages/pacman/index.html)
-   [pipeR](http://cran.rstudio.com/web/packages/pipeR/index.html)
-   [pkgconfig](http://cran.rstudio.com/web/packages/pkgconfig/index.html)
-   [pkgdown](http://cran.rstudio.com/web/packages/pkgdown/index.html)
-   [pkggraph](http://cran.rstudio.com/web/packages/pkggraph/index.html)
-   [pkgKitten](http://cran.rstudio.com/web/packages/pkgKitten/index.html)
-   [pkgmaker](http://cran.rstudio.com/web/packages/pkgmaker/index.html)
-   [pkgnet](http://cran.rstudio.com/web/packages/pkgnet/index.html)
-   [prof.tree](http://cran.rstudio.com/web/packages/prof.tree/index.html)
-   [profmem](http://cran.rstudio.com/web/packages/profmem/index.html)
-   [profr](http://cran.rstudio.com/web/packages/profr/index.html)
-   [proftools](http://cran.rstudio.com/web/packages/proftools/index.html)
-   [progress](http://cran.rstudio.com/web/packages/progress/index.html)
-   [proto](http://cran.rstudio.com/web/packages/proto/index.html)
-   [purrr](http://cran.rstudio.com/web/packages/purrr/index.html)
-   [PythonInR](http://cran.rstudio.com/web/packages/PythonInR/index.html)
-   [qtbase](http://cran.rstudio.com/web/packages/qtbase/index.html)
-   [R.methodsS3](http://cran.rstudio.com/web/packages/R.methodsS3/index.html)
-   [R.oo](http://cran.rstudio.com/web/packages/R.oo/index.html)
-   [R6](http://cran.rstudio.com/web/packages/R6/index.html)
-   [rbenchmark](http://cran.rstudio.com/web/packages/rbenchmark/index.html)
-   [rcmdcheck](http://cran.rstudio.com/web/packages/rcmdcheck/index.html)
-   [Rcpp](http://cran.rstudio.com/web/packages/Rcpp/index.html)
-   [Rd2roxygen](http://cran.rstudio.com/web/packages/Rd2roxygen/index.html)
-   [RDocumentation](http://cran.rstudio.com/web/packages/RDocumentation/index.html)
-   [Rdpack](http://cran.rstudio.com/web/packages/Rdpack/index.html)
-   [remotes](http://cran.rstudio.com/web/packages/remotes/index.html)
-   [reticulate](http://cran.rstudio.com/web/packages/reticulate/index.html)
-   [rGroovy](http://cran.rstudio.com/web/packages/rGroovy/index.html)
-   [rhub](http://cran.rstudio.com/web/packages/rhub/index.html)
-   [RInside](http://cran.rstudio.com/web/packages/RInside/index.html)
-   [rJava](http://cran.rstudio.com/web/packages/rJava/index.html)
-   [rJython](http://cran.rstudio.com/web/packages/rJython/index.html)
-   [rlang](http://cran.rstudio.com/web/packages/rlang/index.html)
-   [rollbar](http://cran.rstudio.com/web/packages/rollbar/index.html)
-   [roxygen2](http://cran.rstudio.com/web/packages/roxygen2/index.html) (core)
-   [rPython](http://cran.rstudio.com/web/packages/rPython/index.html)
-   [rscala](http://cran.rstudio.com/web/packages/rscala/index.html)
-   [RStata](http://cran.rstudio.com/web/packages/RStata/index.html)
-   [rstudioapi](http://cran.rstudio.com/web/packages/rstudioapi/index.html)
-   [rtype](http://cran.rstudio.com/web/packages/rtype/index.html)
-   [RUnit](http://cran.rstudio.com/web/packages/RUnit/index.html)
-   [runittotestthat](http://cran.rstudio.com/web/packages/runittotestthat/index.html)
-   [semver](http://cran.rstudio.com/web/packages/semver/index.html)
-   [shiny](http://cran.rstudio.com/web/packages/shiny/index.html)
-   [skeletor](http://cran.rstudio.com/web/packages/skeletor/index.html)
-   [sos](http://cran.rstudio.com/web/packages/sos/index.html)
-   [svUnit](http://cran.rstudio.com/web/packages/svUnit/index.html)
-   [sys](http://cran.rstudio.com/web/packages/sys/index.html)
-   [tcltk2](http://cran.rstudio.com/web/packages/tcltk2/index.html)
-   [testit](http://cran.rstudio.com/web/packages/testit/index.html)
-   [testthat](http://cran.rstudio.com/web/packages/testthat/index.html)
-   [unitizer](http://cran.rstudio.com/web/packages/unitizer/index.html)
-   [V8](http://cran.rstudio.com/web/packages/V8/index.html)
-   [vdiffr](http://cran.rstudio.com/web/packages/vdiffr/index.html)
-   [withr](http://cran.rstudio.com/web/packages/withr/index.html)
-   [XRJulia](http://cran.rstudio.com/web/packages/XRJulia/index.html)

### Related links:

-   [\[Manual\] "Writing R Extension" by R-core team](http://cran.r-project.org/doc/manuals/R-exts.html)
-   [\[Tutorial\] "Creating R Packages: A Tutorial" by Friedrich Leisch](http://cran.r-project.org/doc/contrib/Leisch-CreatingPackages.pdf)
-   [\[Tutorial\] "Best practices for writing an API package" by Hadley Wickham](http://cran.r-project.org/whttp://cran.rstudio.com/web/packages/httr/vignettes/api-packages.html)
-   [\[Webpage\] "CRAN Repository Policy" lists rules for hosting packages on CRAN](http://cran.r-project.org/whttp://cran.rstudio.com/web/packages/policies.html)
-   [\[Webpage\] Dirk Eddelbuettel provides a feed of CRAN policy changes](https://github.com/eddelbuettel/crp)
-   [\[Webpage\] "Developing R packages" by Jeff Leek](https://github.com/jtleek/rpackages)
-   [\[Book\] "Software for Data Analysis" by John Chambers](http://www.springer.com/mathematics/computational+science+%26+engineering/book/978-0-387-75935-7)
-   [\[Book\] "Advanced R" by Hadley Wickham](http://adv-r.had.co.nz)
-   [\[Book\] "R packages" by Hadley Wickham](http://r-pkgs.had.co.nz/)

