##
## Resources demo
##

# Install the resourcer package if not already available
if (!require(resourcer)) {
  install.packages("resourcer")
}

# Load the resourcer package
library(resourcer)

##
## Building a Data Resource Object
##

### CSV File Resource

# Define the resource: a CSV file downloadable from the web, without credentials
CAPostalCodes.res <- resourcer::newResource(
  url = "https://github.com/obiba/obiba-home/raw/master/opal/seed/fs/home/administrator/geo/CAPostalCodes.csv",
  format = "csv"
)
CAPostalCodes.res

# Resolve the resource and make a connection client
CAPostalCodes.client <- resourcer::newResourceClient(CAPostalCodes.res)
class(CAPostalCodes.client)

# The resource was identified as a "tidy" data file, i.e. data that can be read using one of
# the reader developed by the "tidyverse" project. In the case of the `csv` data format,
# the readr package is used. This CSV reader tries to guess the data type of the columns.

# Execute the file download and read it as a data.frame
CAPostalCodes.data <- CAPostalCodes.client$asDataFrame()
head(CAPostalCodes.data)

# Another way to do this is to directly coerce the resource to a data.frame
CAPostalCodes.data <- as.data.frame(CAPostalCodes.res)
head(CAPostalCodes.data)


### R Data File Resource

# Define the resource: a file stored in a Opal server's file system. Authentication and
# authorization apply and is performed with a Opal Personal Access Token.
gps_participant.res <- resourcer::newResource(
  url = "opal+https://opal-demo.obiba.org/ws/files/projects/RSRC/gps_participant.RData",
  format = "data.frame",
  secret = "EeTtQGIob6haio5bx6FUfVvIGkeZJfGq"
)
gps_participant.res

# Resolve the resource and make a connection client
gps_participant.client <- resourcer::newResourceClient(gps_participant.res)
class(gps_participant.client)

# The resource was identified as an R data file, containing a `data.frame` object.

# Execute the file download, load the R data file and extract the raw object
gps_participant.data <- gps_participant.client$getValue()
head(gps_participant.data)


##
## Building a Computation Resource Object
##

### SSH Resource

# Define the resource: a server accessible through a secure shell. The path part of the URL
# is the remote working directory. The available commands are defined by the `exec` query parameter.
ssh.res <- resourcer::newResource(
  url = "ssh://plink-demo.obiba.org:2222/home/master/brge?exec=ls,pwd",
  identity = "master",
  secret = "master"
)

# Resolve the resource and make a connection client
ssh.client <- resourcer::newResourceClient(ssh.res)
class(ssh.client)

# This type of client allows to issue shell commands through a SSH connection.
# List the avaliable commands:
ssh.client$getAllowedCommands()

# To illustrate that it is not a data resource, trying to coerce to a `data.frame`
# raises an error, because there is no tabular data representation of such a resource:
ssh.client$asDataFrame()

# Interact with the computation resource by issuing shell commands
rval <- ssh.client$exec("ls", "-la")
rval

# The resulting value contains different information:
# `status` of the command (failure if not 0),
rval$status
# `output` the character vector of the command output,
rval$output
# `error` is the error message if command failed,
rval$error
# `command` is the actual shell command that was executed.
rval$command


# Bad shell command arguments would return a value with an error:
rval <- ssh.client$exec("ls", "-xyz")
rval

# Calling a shell command that is not allowed raises an error.
ssh.client$exec("plink")
