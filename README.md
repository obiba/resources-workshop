# Resources Workshop

## Prerequisites

The [resourcer](https://cran.r-project.org/package=resourcer) has quite some suggested dependencies. These are only suggestions,
meaning that it will depend on the kind of resource that will be accessed at runtime.

### Tidy files

* [haven](https://cran.r-project.org/package=haven): Import and Export 'SPSS', 'Stata' and 'SAS' Files
* [readr](https://cran.r-project.org/package=readr): Read Rectangular Text Data
* [readxl](https://cran.r-project.org/package=readxl): Read Excel Files
* [dplyr](https://cran.r-project.org/package=dplyr): A Grammar of Data Manipulation

### Databases

* [dbplyr](https://cran.r-project.org/package=dbplyr): A 'dplyr' Back End for Databases
* [DBI](https://cran.r-project.org/package=DBI): R Database Interface
* [RMariaDB](https://cran.r-project.org/package=RMariaDB): Database Interface and 'MariaDB' Driver
* [RPostgres](https://cran.r-project.org/package=RPostgres): 'Rcpp' Interface to 'PostgreSQL'
* [sparklyr](https://cran.r-project.org/package=sparklyr): R Interface to Apache Spark
* [RPresto](https://cran.r-project.org/package=RPresto): DBI Connector to Presto
* [nodbi](https://cran.r-project.org/package=nodbi): 'NoSQL' Database Connector
* [mongolite](https://cran.r-project.org/package=mongolite): Fast and Simple 'MongoDB' Client for R

### Remote computation server

* [ssh](https://cran.r-project.org/package=ssh): Secure Shell (SSH) Client for R

### System dependencies

R packages often depend on system libraries or other software external to R. These dependencies are not automatically installed.

See the provided example script for installing the system requirements, per R package, for a Ubuntu 18.04 system: [install-system-requirements-ubuntu18.sh](https://github.com/obiba/resources-workshop/blob/main/install-system-requirements-ubuntu18.sh)

