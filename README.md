# Resources Workshop

## Prerequisites

The [resourcer](https://cran.r-project.org/package=resourcer) has quite some suggested dependencies. These are only suggestions, meaning that it will depend on the kind of resource that will be accessed at runtime. See the [resourcer's Install](https://github.com/obiba/resourcer#install) section for the detail of the dependencies.

**For the need of this workshop, only the following R packages are needed: readr, dplyr and ssh.**

Tidy files:

* [readr](https://cran.r-project.org/package=readr): Read Rectangular Text Data
* [dplyr](https://cran.r-project.org/package=dplyr): A Grammar of Data Manipulation

Remote computation server:

* [ssh](https://cran.r-project.org/package=ssh): Secure Shell (SSH) Client for R

### 0. R environment

For a friendly R environment and being able to run the proposed examples, [Rstudio](https://rstudio.com/products/rstudio/) is highly recommended.

Recommended readings from the DataSHIELD's wiki:

* [Introduction to R and the R tutorial](https://data2knowledge.atlassian.net/wiki/spaces/DSDEV/pages/1722122263/2020-21+Winter+DataSHIELD+beginners+workshops+including+ATHLETE+GA+workshop)
* [Become familiar with R Studio and basic concepts of R](https://data2knowledge.atlassian.net/wiki/spaces/DSDEV/pages/707428353/Become+familiar+with+R+Studio+and+basic+concepts+of+R)

### 1. Install system dependencies

R packages often depend on system libraries or other software external to R. These dependencies are not automatically installed.

#### Ubuntu

```
# curl requirements:
sudo apt-get install libcurl4-openssl-dev libssl-dev

# openssl requirements:
sudo apt-get install libssl-dev

# ssh requirements:
sudo apt-get install libssh2-1-dev
```

#### Windows

????

### 2. Install R packages

In a R console, install the R packages using the commands:

```
install.packages(c("readr", "dplyr", "ssh"))
install.packages("resourcer")
```
