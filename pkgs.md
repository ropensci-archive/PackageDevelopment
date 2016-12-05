Packages provide a mechanism for loading optional code, data, and documentation as needed. At the very minimum only a text editor and an R installation are needed for package creation. Nonetheless many useful tools and R packages themselves have been provided to ease or improve package development. This Task View focuses on these tools/R packages, grouped by topics.

The main reference for packages development is the ["Writing R Extension"](http://cran.r-project.org/doc/manuals/R-exts.html) manual. For further documentation and tutorials, see the "Related links" section below.

If you think that some packages or tools are missing from the list, feel free to [e-mail](mailto:thosjleeper@gmail.com) me or contribute directly to the Task View by submitting a pull request on [GitHub](http://github.com/ropensci/PackageDevelopment/blob/master/CONTRIBUTING.md).

Many thanks to Christopher Gandrud, Cristophe Dutang, Darren Norris, Dirk Eddelbuettel, Gabor Grothendieck, Gregory Jefferis, John Maindonald, Luca Braglia, Spencer Graves, Tobias Verbeke, and the R-core team for contributions.

### First steps

**Searching for Existing Packages**

Before starting a new package it's worth searching for already available packages, both from a developer's standpoint ("do not reinvent the wheel") and from a user's one (many packages implementing same/similar procedures can be confusing). If a package addressing the same functionality already exists, you may consider contributing at it instead of starting a new one.

-   `utils::RSiteSearch()` allows to search for keywords/phrases in help pages (all the CRAN packages except those for Windows only and some from Bioconductor), vignettes or task views, using the search engine at <http://search.r-project.org/>. A convenient wrapper around `RSiteSearch` that adds hits ranking is `findFn()` function, from <pkg>sos</pkg>.
-   [RSeek](http://rseek.org/) allows to search for keywords/phrases in books, task views, support lists, function/packages, blogs etc.
-   [Rdocumentation](http://www.rdocumentation.org/) allows to search for keywords/phrases in help pages for all CRAN and some Bioconductor/GitHub packages. <pkg>RDocumentation</pkg> ([GitHub](https://github.com/datacamp/RDocumentation/)) provides an R client for the site. 
-   [Crantastic!](http://crantastic.org/) maintains an up-to-date and tagged directory of packages on CRAN. The [Managed R Archive Network](https://mran.revolutionanalytics.com/) from Revolution Analytics is a CRAN mirror that additionally provides visualizations of package dependency trees.
-   [http://www.r-pkg.org/](http://www.r-pkg.org/) is an unofficial CRAN mirror that provides a relatively complete archive of package and read-only access to package sources on Github.
-   [CRANberries](http://dirk.eddelbuettel.com/cranberries/) provides a feed of new, updated, and removed packages for CRAN.
-   If you're looking to create a package, but want ideas for what sorts of packages are in demand, the [rOpenSci](https://ropensci.org/) maintains [a wishlist for science-related packages](https://github.com/ropensci/wishlist) and [a TODO list of web services and data APIs in need of packaging](https://github.com/ropensci/webservices/wiki/ToDo).

**Initializing an R package**

-   `utils::package.skeleton()` automates some of the setup for a new source package. It creates directories, saves functions, data, and R code files provided to appropriate places, and creates skeleton help files and a `Read-and-delete-me` file describing further steps in packaging
-   `kitten()` from <pkg>pkgKitten</pkg> allows one to specify the main `DESCRIPTION` entries and doesn't create source code and data files from global environment objects or sourced files. It's used to initialize a simple package that passes `R CMD check` cleanly.
-   `create()` from <pkg>devtools</pkg> is similar to `package.skeleton` except it allows to specify `DESCRIPTION` entries and doesn't create source code and data files from global environment objects or sourced files.
-   <a href="https://github.com/metacran/mason">mason</a> provides a fun, interactive tool for creating a package based on a variety of inputs.
-   `Rcpp.package.skeleton()` from <pkg>Rcpp</pkg> adds to `package.skeleton` the C++ via `Rcpp` handling, by modifying eg. `DESCRIPTION` and `NAMESPACE` accordingly, creating examples if needed and allowing the user to specify (with a character vector of paths) which C++ files to include in `src` directory . Finally the user can decide main `DESCRIPTION` entries.
-   <pkg>mvbutils</pkg> provides a variety of useful functions for development which include tools for managing and analyzing the development environment, auto-generating certain function types, and visualizing a function dependency graph. [pagerank](https://github.com/andrie/pagerank) (not on CRAN) can calculate a package's PageRank from its dependency graph.
-   [swagger](https://github.com/hrbrmstr/swagger) (not on CRAN) uses the [Swagger](http://swagger.io/) JSON web service API specification to automatically generate an R client package for a web service API.

When initializing a package, it is worth considering how it should be licensed. CRAN provides [a list of the most commonly used software licences](https://cran.r-project.org/web/licenses/) for R packages. <pkg>osi</pkg> ([GitHub](https://github.com/Ironholds/osi/)) provides a more comprehensive list in a standardized format.

**Programming Paradigms**

R is foremost a functional programming language with dynamic typing, but has three built-in forms of object-oriented programming as well as additional object-oriented paradigms available in add-on packages.

-   The built-in S3 classes involve wherein a generic function (e.g., `summary`) employs a distinct method for an object of a given class (i.e., it is possible to implement class-specific methods for a given generic function). If a package implements new object classes, it is common to implement methods for commonly used generics such as `print`, `summary`, etc. These methods must be registered in the package's NAMESPACE file. <pkg>R.methodsS3</pkg> aims to simplify the creation of S3 generic functions and S3 methods.
-   S4 is a more formalized form of object orientation that is available through `methods`. S4 classes have formal definitions and can dispatch methods based on multiple arguments (not just the first argument, as in S3). S4 is notable for its use of the `@` symbol to extract slots from S4 objects. John Chambers's ["How S4 Methods Work"](http://developer.r-project.org/howMethodsWork.pdf) tutorial may serve as a useful introduction.
-   Reference classes were introduced in R2.12.0 and are also part of `methods`. They offer a distinct paradigm from S3 and S4 due to the fact that reference class objects are mutable and that methods belong to objects, not generic functions.
-   <pkg>aoos</pkg> and <pkg>R.oo</pkg> are other packages facilitating object-oriented programming. <pkg>R6</pkg> ([Github](https://github.com/wch/R6)) provides an alternative to reference classes without a dependency on `methods`.
-   <pkg>proto</pkg> provides a prototype-based object orientated programming paradigm.
-   <pkg>rtype</pkg> provides a strong type system. 
-   [argufy](https://github.com/gaborcsardi/argufy) (Not on CRAN), provides a syntax for creating functions with strictly typed arguments, among other possible checks.
-   <pkg>lambda.r</pkg>, [lambdaR](https://github.com/hoxo-m/lambdaR) (not on CRAN), and <pkg>purrr</pkg> provide interfaces for creating lambda (anonymous) functions.
-   <pkg>functools</pkg> ([GitHub](https://github.com/paulhendricks/functools)) provides higher-order functions (Map, Reduce, etc.) common in funcitonal programming.

Another feature of R is the ability to rely on both standard and non-standard evaluation of function arguments. Non-standard evaluation is seen in commonly used functions like `library` and `subset` and can also be used in packages.

-   `substitute()` provides the most straightforward interface to non-standard evaluation of function arguments.
-   <pkg>lazyeval</pkg> ([Github](https://github.com/hadley/lazyeval)) aims to help developers design packages with parallel function implementations that follow both standard and non-standard evaluation.
-   An increasingly popular form of non-standard evaluation involves chained expressions or "pipelines". <pkg>magrittr</pkg> provides the `%>%` chaining operator that passes the results of one expression evaluation to the next expression in the chain, as well as other similar piping operators. <pkg>pipeR</pkg> offers a larger set of pipe operators. <pkg>assertr</pkg> and <pkg>ensurer</pkg> provide (fairly similar) testing frameworks for pipelines.

**Dependency Management**

Packages that have dependencies on other packages need to be vigilant of changes to the functionality, behaviour, or API of those packages. 

-   <pkg>packrat</pkg> (<a href="https://github.com/rstudio/packrat">Github</a>) provides facilities for creating local package repositories to manage and check dependencies. 
-   <pkg>checkpoint</pkg> relies on the Revolution Analytics MRAN repository to access packages from specified dates. 
-   <pkg>pacman</pkg> (<a href="https://github.com/trinker/pacman">Github</a>) can install, uninstall, load, and unload various versions of packages from CRAN and Github.
-   <pkg>GRANBase</pkg> ([GitHub](https://github.com/gmbecker/gRAN)) provides some sophisticated tools for managing dependencies and testing packages conditional on changes.
-   Two packages currently provide alternative ways to import objects from packages in non-standard ways (e.g., to assign those objects different names from the names used in their host packages). <pkg>import</pkg> (<a href="https://github.com/smbache/import">Github</a>) can import numerous objects from a namespace and assign arbitrary names. <a href="https://github.com/klmr/modules">modules</a> (not on CRAN) provides functionality for importing alternative non-package code from Python-like "modules".
-   [functionMap](https://github.com/MangoTheCat/functionMap) provides a visualization tool useful for understanding function dependencies within and across packages. [atomize](https://github.com/ropenscilabs/atomize) can quickly extract functions from within a package into their own package.


### Source Code

**Foreign Languages Interfaces**

-   [processx](https://github.com/MangoTheCat/processx) (not on CRAN) provides a unified, platform-independent API for running system processes.
-   <pkg>inline</pkg> eases adding code in C, C++, or Fortran to R. It takes care of the compilation, linking and loading of embedded code segments that are stored as R strings.
-   <pkg>Rcpp</pkg> offers a number of C++ classes that makes transferring R objects to C++ functions (and back) easier. <pkg>RInside</pkg> provides C++ classes for embedding within C++ applications.
-   <pkg>rGroovy</pkg> integrates with the [Groovy scripting language](http://www.groovy-lang.org/).
-   <pkg>rJava</pkg> provides a low-level interface to Java similar to the `.Call` interface for C and C++. <pkg>helloJavaWorld</pkg> provides an example rJava-based package. [jvmr](https://dahl.byu.edu/software/jvmr/) (archived on CRAN) provides a bi-directional interface to Java, Scala, and related languages, while <pkg>rscala</pkg> is designed specifically for Scala.
-   [rustr](https://github.com/rustr/rustr) provides bindings to Rust.
-   [reach](https://github.com/schmidtchristoph/reach) (not on CRAN) and <pkg>matlabr</pkg> provide rough interfaces to Matlab.
-   <pkg>rPython</pkg>, <pkg>rJython</pkg>, <pkg>PythonInR</pkg>, [rpy2](http://rpy.sourceforge.net/) (not on CRAN), and [SnakeCharmR](https://github.com/asieira/SnakeCharmR) (not on CRAN) provide interfaces to python.
-   [RJulia](https://github.com/armgong/RJulia) (not on CRAN) provides an interface with Julia, as does <pkg>XRJulia</pkg>. [RCall](https://github.com/JuliaStats/RCall.jl) embeds R within Julia.
-   <pkg>RStata</pkg> is an interface with Stata. [RCall](https://github.com/haghish/Rcall) embeds R in Stata.
-   `tcltk`, which is a package built in to R, provides an general interface to Tcl, usefully especially for accessing Tcl/tk (for graphical interfaces). <pkg>after</pkg> ([GitHub](https://github.com/gaborcsardi/after)) uses tcltk to run R code in a separate event loop.
-   <pkg>V8</pkg> offers an embedded Javascript engine, useful for building packages around Javascript libraries. <pkg>js</pkg> provides additional tools for working with Javascript code.

The <pkg>knitr</pkg> package, which supplies [various foreign language engines](http://yihui.name/knitr/demo/engines/), can also be used to generate documents that call python, awk, ruby, haskell, bash, perl, dot, tikz, sas, coffeescript, and polyglot.

Writing packages that involve compiled code requires a developer toolchain. If developing on Windows, this requires [Rtools](http://cran.r-project.org/bin/windows/Rtools/), which is updated with each R minor release.

**Debugging**

-   <pkg>log4r</pkg> ([Github](https://github.com/johnmyleswhite/log4r)) and <pkg>logging</pkg> provide logging functionality in the style of [log4j](https://en.wikipedia.org/wiki/Log4j).
-   [loggr](https://github.com/smbache/loggr) (not on CRAN) aims to provide a simplified logging interface without the need for `withCallingHandlers()` expressions.
-   <pkg>rollbar</pkg> reports messages and errors to [Rollbar](https://rollbar.com), a web service.
-   The [rchk](https://github.com/kalibera/rchk) tool provides tools for identifying memory-protection bugs in C code, including base R and packages.

**Code Analysis and Formatting**

-   <pkg>codetools</pkg> provides a number of low-level functions for identifying possible problems with source code.
-   <pkg>lintr</pkg> provides tools for checking source code compliance with a style guide.
-   <pkg>formatR</pkg> and [rfmt](https://github.com/google/rfmt/) (not on CRAN) can be used to neatly format source code.
-   <pkg>FuncMap</pkg> provides a graphical representation of function calls used in a package.

**Profiling**

-   Profiling data is provided by `utils::Rprof()` and can be summarized by `utils::summaryRprof()`. <pkg>prof.tree</pkg> ([GitHub](https://github.com/artemklevtsov/prof.tree)) provides an alternative output data structure to `Rprof()`. <pkg>profmem</pkg> ([GitHub](https://github.com/HenrikBengtsson/profmem)) adds a simple interface on top of this.
-   <pkg>profr</pkg> can visualize output from the `Rprof` interface for profiling.
-   <pkg>proftools</pkg> and <pkg>aprof</pkg> can also be used to analyse profiling output.
-   [profvis](https://github.com/rstudio/profvis) (not on CRAN) provides an interactive, graphical interface for examining profile results.
-   [lineprof](https://github.com/hadley/lineprof) (not on CRAN) provides a visualization tool for examining profiling results.
-   [Rperform](https://github.com/analyticalmonk/Rperform) (not on CRAN) compares package performance across different git versions and branches.

**Benchmarking**

-   `base::system.time()` is a basic timing utility that calculates times based on one iteration of an expression.
-   <pkg>microbenchmark</pkg> and <pkg>rbenchmark</pkg> provide timings based on multiple iterations of an expression and potentially provide more reliable timings than `system.time()`

**Unit Testing**

-   Packages should pass all basic code and documentation checks provided by the `R CMD check` quality assurance tools built in to R. <pkg>rcmdcheck</pkg> provides programmatic access to `R CMD check` from within R and [callr](https://github.com/MangoTheCat/callr) (not on CRAN) provides a generic interface for calling R from within R.
-   R documentation files can contain demonstrative examples of package functionality. Complete testing of correct package performance is better reserved for the `test` directory. Several packages provide testing functionality, including <pkg>RUnit</pkg>, <pkg>svUnit</pkg>, <pkg>testit</pkg> ([GitHub](https://github.com/yihui/testit)), <pkg>testthat</pkg>, [testthatsomemore](https://github.com/robertzk/testthatsomemore) (not on CRAN), and <pkg>pkgmaker</pkg>. <pkg>runittotestthat</pkg> provides utilities for converting exiting RUnit tests to testthat tests.
-   <pkg>assertive</pkg>, <pkg>assertr</pkg>, <pkg>checkmate</pkg> <pkg>ensurer</pkg>, and <pkg>assertthat</pkg> provide test-like functions for use at run-time or in examples that will trigger messages, warnings, or errors if an R object differs from what is expected by the user or developer.
-   <pkg>covr</pkg> and [testCoverage](https://github.com/MangoTheCat/testCoverage) (not on CRAN) offer utilities for monitoring how well tests cover a package's source code. These can be complemented by services such as [Codecov](https://codecov.io/) or [Coveralls](https://coveralls.io/) that provide web interfaces for assessing code coverage.
-   <pkg>withr</pkg> ([GitHub](https://github.com/jimhester/withr)) provides functions to evaluate code within a temporarily modified global state, which may be useful for unit testing, debugging, or package development.
-   The `devtools::use_revdep()` and `revdep_check()` functions from <pkg>devtools</pkg> can be used to test reverse package dependencies to ensure code changes have not affected downstream package functionality. [crandalf](https://github.com/yihui/crandalf) (not on CRAN) provides an alternative mechanism for testing reverse dependencies.

**Internationalization and Localization**

-   There is no standard mechanism for translation of package documentation into languages other than English. To create non-English documentation requires manual creation of supplemental .Rd files or package vignettes. Packages supplying non-English documentation should include a `Language` field in the DESCRIPTION file.
-   R provides useful features for the localization of diagnostic messages, warnings, and errors from functions at both the C and R levels based on GNU `gettext`. ["Translating R Messages"](http://developer.r-project.org/Translations30.html) describes the process of creating and installing message translations.

**Creating Graphical Interfaces**

-   For simple interactive interfaces, `readline()` can be used to create a simple prompt. <pkg>getPass</pkg> provides cross-platform mechanisms for securely requesting user input without displaying the intput (e.g., for passwords). `utils::menu()`, `utils::select.list()` can provide graphical and console-based selection of items from a list, and `utils::txtProgressBar()` provides a simple text progress bar.
-   `tcltk` is an R base package that provides a large set of tools for creating interfaces uses Tcl/tk (most functions are thin wrappers around corresponding Tcl and tk functions), though the documentation is sparse. <pkg>tcltk2</pkg> provides additional widgets and functionality. <pkg>qtbase</pkg> provides bindings for Qt. <ohat>RGtk</ohat> (not on CRAN) provides bindings for Gtk and gnome. <pkg>gWidgets2</pkg> offers a language-independent API for building graphical user interfaces in Gtk, Qt, or Tcl/tk.
-   <pkg>fgui</pkg> can create a Tcl/tk interface for any arbitrary function.
-   <pkg>shiny</pkg> provides a browser-based infrastructure for creating dashboards and interfaces for R functionality. <pkg>htmlwidgets</pkg> is a shiny enhancement that provides a framework for creating HTML widgets.
-   <pkg>progress</pkg> ([Github](https://github.com/gaborcsardi/progress)) offers progress bars for the terminal, including a C++ API.

**Command Line Argument Parsing**

-   Several packages provide functionality for parsing command line arguments: <pkg>argparse</pkg>, <pkg>argparser</pkg>, <pkg>commandr</pkg>, <pkg>docopt</pkg>, <pkg>GetoptLong</pkg>, and <pkg>optigrab</pkg>.

**Using Options in Packages**

-   <pkg>pkgconfig</pkg> ([GitHu](https://github.com/gaborcsardi/pkgconfig)) allows developers to set package-specific options, which will not affect options set or used by other packages.

### Documentation

**Writing Package Documentation**

Package documentation is written in a TeX-like format as .Rd files that
are stored in the `man` subdirectory of a package. These files are
compiled to plain text, HTML, or PDF by R as needed.

-   One can write .Rd files directly. A popular alternative is to rely on <pkg>roxygen2</pkg>, which uses special markup in R source files to generate documentation files before a package is built. This functionality is provided by `roxygen2::roxygenise()` and underlies `devtools::document()`. roxygen2 eliminates the need to learn *some* of the formatting requirements of an .Rd file at the cost of adding a step to the development process (the need to roxygenise before calling `R CMD build`).
-   <pkg>Rd2roxygen</pkg> can convert existing .Rd files to roxygen source documentation, facilitating the conversion of existing documentation to an roxygen workflow. [roxygen2md](https://github.com/r-pkgs/roxygen2md) (not on CRAN) provides tools for further converting Rd markup within roxygen comments to markdown format (supported by the latest versions of roxygen2).
-   <pkg>inlinedocs</pkg> and <pkg>documair</pkg> provide further alternative documentation schemes based on source code commenting.
-   `tools::parse_Rd()` can be used to manipulate the contents of an .Rd file. `tools::checkRd()` is useful for validating an .Rd file. Duncan Murdoch's ["Parsing Rd files"](https://developer.r-project.org/parseRd.pdf) tutorial is a useful reference for advanced use of R documentation. <pkg>Rdpack</pkg> provides additional tools for manipulating documentation files.

**Writing Vignettes**

Package vignettes provides additional documentation of package functionality that is not tied to a specific function (as in an .Rd file). Historically, vignettes were used to explain the statistical or computational approach taken by a package in an article-like format that would be rendered as a PDF document using `Sweave`. Since R 3.0.0, non-Sweave vignette engines have also been supported, including <pkg>knitr</pkg>, which can produce Sweave-like PDF vignettes but can also support HTML vignettes that are written in R-flavored markdown. To use a non-Sweave vignette engine, the vignette needs to start with a code block indicating the package and function to be used:

```
%\VignetteEngine{knitr::knitr}
%\VignetteIndexEntry{}
```

**Spell Checking**

-   `utils` provides multiple functions for spell-checking portions of packages, including .Rd files (`utils::aspell_package_Rd_files`) and vignettes (`utils::aspell_package_vignettes`) via the general purpose `aspell` function, which requires a system spell checking library, such as http://aspell.net/, http://hunspell.github.io/, or http://lasr.cs.ucla.edu/geoff/ispell.html.
-   <pkg>hunspell</pkg> provides an interface to hunspell.

### Data in Packages

-   <pkg>lazyData</pkg> offers the ability to use data contained within packages that have not been configured using LazyData.

### Tools and Services

**Text Editors and IDEs**

-   By far the most popular [integrated development environment (IDE)](https://en.wikibooks.org/wiki/R_Programming/Settings#Integrated_development_environment) for R is [RStudio](https://www.rstudio.com/), which is an open-source product available with both commercial and AGPL licensing. It can be run both locally and on a remote server. <pkg>rstudioapi</pkg> facilitates interaction from RStudio from within R.
-   [StatET](http://www.walware.de/goto/statet) is an R plug-in for the Eclipse IDE.
-   [Emacs Speaks Statistics (ESS)](http://ess.r-project.org/) is a feature-rich add-on package for editors like Emacs or XEmacs.

**Makefiles**

-   [GNU Make](http://www.gnu.org/software/make/) is a tool that typically builds executable programs and libraries from source code by reading files called `Makefile`. It can be used to manage R package as well; [maker](https://github.com/ComputationalProteomicsUnit/maker) is a `Makefile` completely devoted to R package development based on [makeR](https://github.com/tudo-r/makeR).
-   [remake](https://github.com/richfitz/remake) (not on CRAN) provides a yaml-based, Makefile-like format that can be used in Make-like workflows from within R.

**Version Control**

-   R itself is maintained under version control using [Subversion](https://subversion.apache.org/).
-   Many packages are maintained using [git](https://git-scm.com/), particularly those hosted on [GitHub](https://github.com/). <pkg>git2r</pkg> ([Github](https://github.com/ropensci/git2r)) provides bindings to [libgit2](http://libgit2.github.com/) for programmatic use of git within R.

**Hosting and Package Building Services**

Many [hosting services](https://en.wikipedia.org/wiki/Comparison_of_open-source_software_hosting_facilities) are available. Use of different hosts depends largely on what type of version control software is used to maintain a package. The most common sites are:

-   [R-Forge](http://r-forge.r-project.org/), which relies on [Subversion](http://subversion.apache.org/). [Rforge.net](https://rforge.net/) is another popular Subversion-based system.
-   [r-hub](http://log.r-hub.io/) is a modern package test service funded by the RConsortium . [rhub](https://github.com/r-hub/rhub) (not on CRAN) provides an R client for the site's API.
-   [GitHub](https://github.com/) [mainly](https://help.github.com/articles/support-for-subversion-clients/) supports Git and Mercurial. Packages hosted on Github can be installed directly using `devtools::install_github()` or `ghit::install_github()` from <pkg>ghit</pkg> or `remotes::install_github()` from <pkg>remotes</pkg>. [gh](https://github.com/gaborcsardi/gh) (not on CRAN) is a lightweight client for the GitHub API. [Bitbucket](https://bitbucket.org/) is an alternative host that provides no-cost private repositories and [GitLab](https://about.gitlab.com/) is an open source alternative. <pkg>gitlabr</pkg> provides is an API client for managing Gitlab projects.
-   Github supports [continuous integration](https://en.wikipedia.org/wiki/Continuous_integration) for R packages. [Travis CI](https://travis-ci.org/) is a popular continuous integration tools that supports Linux and OS X build environments. Travis has native R support, and can easily provide code coverage information via <pkg>covr</pkg> to [Codecov.io](https://codecov.io/) or [Coveralls](https://coveralls.io/). [travisci](https://github.com/cloudyr/travisci) (not on CRAN) provides an API client for Travis. Use of other CI services, such as [Circle CI](https://circleci.com/) may require additional code and examples are available from [r-travis](https://github.com/craigcitro/r-travis) and/or [r-builder](https://github.com/metacran/r-builder). [circleci](https://github.com/cloudyr/circleci) (not on CRAN) provides an API client for Circle CI. <pkg>badgecreatr</pkg> ([GitHub](https://github.com/RMHogervorst/badgecreatr)) provides a convenient way of creating standardized badges (or "shields") for package READMEs.
-   [WinBuilder](http://win-builder.r-project.org/) is a service intended for useRs who do not have Windows available for checking and building Windows binary packages. The package sources (after an `R CMD check`) can be uploaded via html form or passive ftp in binary mode; after checking/building a mail will be sent to the `Maintainer` with links to the package zip file and logs for download/inspection. [Appveyor](http://www.appveyor.com/) is a continuous integration service that offers a Windows build environment. [r-appveyor](https://github.com/krlmlr/r-appveyor) (not on CRAN) and [appveyor](https://github.com/cloudyr/appveyor) (not on CRAN) provide API clients for Appveyor.
-   [Rocker](https://github.com/rocker-org/rocker) provides containers for use with [Docker](https://www.docker.com/). [harbor](https://github.com/wch/harbor) can be used to control docker containers on remote and local hosts and [dockertest](https://github.com/traitecoevo/dockertest) provides facilities for running tests on docker.
-   Some packages, especially some that are no longer under active development, remain hosted on [Google Code](https://code.google.com/). This service is closed to new projects, however, and will shut down in January 2016.
-   <pkg>drat</pkg> can be used to distribute pre-built packages via Github or another server.
-   CRAN does not provide package download statistics, but the RStudio CRAN mirror does. <pkg>packagetrackr</pkg> ([Source](http://gitlab.points-of-interest.cc/points-of-interest/packagetrackr)) facilitates downloading and analyzing those logs.
