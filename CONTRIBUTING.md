# How to contribute

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

* an Internet connection (for `ctv::check_ctv_packages`, since it retrieves
  `PACKAGES` file from CRAN)
* [`pandoc`](http://johnmacfarlane.net/pandoc/)

Optionally you may want to add [`aspell`](http://www.aspell.net) and
[`linkchecker`](http://wummel.github.io/linkchecker). 

## Steps
You need to: 

1. edit `pd.ctv` (*more info* below). Do **not** edit
   `PackageDevelopment.ctv` (or your changes will be removed on next
   `make`); 
2. `make`

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
After a successful `make`, two other steps may be useful:
* spell checking
* checking links

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
and an ending message like ...
```
That's it. 14 links in 13 URLs checked. 0 warnings found. 0 errors found.
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
```
... is quite assuring.

### Editing `pd.ctv`
First, look at:
```R
vignette("ctv-howto")
```

Furthermore, since `pd.ctv` is processed by `sed` to compose
`PackageDevelopment.ctv`:
* tag section names with `<section>...</section>`
* tag task names with `<task>...</task>`
* if you link a GitHub (only, otherwise use CRAN's) repository of a
package, ad *if* `names(package) == names(githubRepo)` you can use the `gh`
tag, eg `<gh>hadley/devtools</gh>`


## Thanks

* [Contributors](http://github.com/lbraglia/PackageDevelopmentTaskView/graphs/contributors)
* [WebTechnologies](http://cran.r-project.org/web/views/WebTechnologies.html)
CRAN Task View group, for useful ideas on
[repo](http://github.com/ropensci/webservices) setup
* [`r-devel`](http://stat.ethz.ch/mailman/listinfo/r-devel) mailing list
  reader, for useful suggestions: especially Cristophe Dutang, Darren
  Norris, Gabor Grothendieck, John Maindonald, Spencer Graves, Tobias
  Verbeke
