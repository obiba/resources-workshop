# Resources Workshop

The two tutorials can be found here:

- [Vignette resources demo](https://rpubs.com/obiba/resources-in-r)
- [Vignette resources examples](https://rpubs.com/jrgonzalezISGlobal/tutorial_resources)

In order to reproduce the two vignettes follow the instructions described in the next sections

## Quick Start

For those in hurry:

```
install.packages(c("readr", "dplyr", "ssh", "resourcer", "DSOpal", "ggrepel"))
install.packages("dsBaseClient", repos = c("https://cran.obiba.org"))
devtools::install_github("isglobal-brge/dsOmicsClient")
```

Some dependencies can be needed:

```
install.packages(c("fields","metafor","ggplot2","gridExtra",
                   "data.table", "ggrepel"))
```

An probably [Rtools](https://cran.r-project.org/bin/windows/Rtools/).


For the others or if you encounter issues, see instructions that follows.

## Prerequisites

The [resourcer](https://cran.r-project.org/package=resourcer) has quite some suggested dependencies. These are only suggestions, meaning that it will depend on the kind of resource that will be accessed at runtime. See the [resourcer's Install](https://github.com/obiba/resourcer#install) section for the detail of the dependencies.

**For the need of this workshop, only the following R packages are needed: readr, dplyr, ssh, DSOpal, dsBaseClient** (Installing **dsOmicsClient** is optional) 

Tidy files:

* [readr](https://cran.r-project.org/package=readr): Read Rectangular Text Data
* [dplyr](https://cran.r-project.org/package=dplyr): A Grammar of Data Manipulation

Remote computation server:

* [ssh](https://cran.r-project.org/package=ssh): Secure Shell (SSH) Client for R

We also need to install those packages to illustrate how to make use of the resources in DataSHIELD

* [DSOpal](https://cran.r-project.org/web/packages/DSOpal/index.html): DataSHIELD Implementation for Opal
* [dsBaseClient](https://github.com/datashield/dsBaseClient): DataSHIELD Client Functions
* [dsOmicsClient](https://github.com/isglobal-brge/dsOmicsClient): DataSHIELD client site Omics association functions

In a R console, install these R packages using the commands:

```
install.packages(c("readr", "dplyr", "ssh"))
install.packages(c("resourcer", "DSOpal"))
install.packages("dsBaseClient", repos = c("https://cran.obiba.org"))
devtools::install_github("isglobal-brge/dsOmicsClient")
```

Some dependencies can be needed:

```
install.packages(c("fields","metafor","ggplot2","gridExtra","data.table",
                  "ggrepel"))
```

### 1. R environment

For a friendly R environment and being able to run the proposed examples, [Rstudio](https://rstudio.com/products/rstudio/) is highly recommended.

Recommended readings from the DataSHIELD's wiki:

* [Introduction to R and the R tutorial](https://data2knowledge.atlassian.net/wiki/spaces/DSDEV/pages/1722122263/2020-21+Winter+DataSHIELD+beginners+workshops+including+ATHLETE+GA+workshop)
* [Become familiar with R Studio and basic concepts of R](https://data2knowledge.atlassian.net/wiki/spaces/DSDEV/pages/707428353/Become+familiar+with+R+Studio+and+basic+concepts+of+R)

### 2. Install system dependencies

R packages often depend on system libraries or other software external to R. These dependencies are not automatically installed.

#### Ubuntu

```
# curl requirements:
sudo apt-get install libcurl4-openssl-dev libssl-dev

# openssl requirements:
sudo apt-get install libssl-dev

# ssh requirements:
sudo apt-get install libssh2-1-dev libssh-dev
```

#### Conda

```
# curl requirements:
conda install -c anaconda libcurl

# openssl requirements:
conda install -c conda-forge openssl

# ssh requirements:
conda install -c conda-forge libssh2

# git requirements:
conda install -c conda-forge libgit2
```

#### Windows

Additional libraries are not needed.


### 3. Try it yourself

Try the R code in the [R](https://github.com/obiba/resources-workshop/tree/main/R) folder.
