<!--- -*- mode: markdown-*- -->
# Package Development "Task View" - How to contribute

You are welcome to:
- fork and send a pull request, if you use GitHub;
- submit suggestions and bug-reports
[here](http://github.com/lbraglia/PackageDevelopmentTaskView/issues);
- send an e-mail to: lbraglia@gmail.com.

## Tools

You need:
* `R` with `ctv` package installed
```R
install.packages("ctv", dep = TRUE)
```
* an internet connection (for `ctv::check_ctv_packages`, since it retrieves
  `PACKAGES` file from CRAN)
* [`pandoc`](http://johnmacfarlane.net/pandoc/)

Optionally you may want to add [`aspell`](http://www.aspell.net) and
[`linkchecker`](http://wummel.github.io/linkchecker). 

## Steps
You need to: 

1. edit `pd.ctv`. Do **not** edit `PackageDevelopment.ctv`
2. type `make`

**If everything works**, last lines should be like:
```bash
...
pandoc PackageDevelopment.html -o README.md
rm -rf tmp.html
```
Then you can push back up to your account and send a pull request.

**If not**, aside problems with Internet connection, you have to
look at `ctv::check_ctv_packages` report and fix missing packages.

### Utils
After a successful `make`, two other tools may be useful:
* spell checking
* link checking

#### Spell checking
A check, via `aspell`, is done with:
```bash
make aspell
```
You may want to add words to the local dictionary used; after editing
`wordlist` file, type:
```bash
make aspell-dict
```

#### Checking links
A check, via `linkchecker`, is done with:
```bash
make check-links
```

### Editing `pd.ctv`


## Thanks

* [Contributors](http://github.com/lbraglia/PackageDevelopmentTaskView/graphs/contributors)
* [WebTechnologies](http://cran.r-project.org/web/views/WebTechnologies.html)
CRAN Task View group, for useful ideas on
[repo](http://github.com/ropensci/webservices) setup
* [`r-devel`](http://stat.ethz.ch/mailman/listinfo/r-devel) mailing list
  reader, for useful suggestions: especially Cristophe Dutang, Darren
  Norris, Gabor Grothendieck, John Maindonald, Spencer Graves, Tobias
  Verbeke
