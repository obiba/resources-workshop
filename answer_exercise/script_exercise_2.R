# load the required packages
library(DSOpal) 
library(dsBaseClient)

# We add the two resources to the Opal server

o <- opal.login(username = 'administrator',
                password = 'password', 
                url = 'https://opal-demo.obiba.org')

opal.resource_create(opal = o, 
                     project = 'workshop', 
                     name = 'quebec_jrgonz', 
                     url = 'https://raw.githubusercontent.com/isglobal-brge/brgedata/master/inst/extdata/co2_quebec.tsv', 
                     format = 'tsv')

opal.resource_create(opal = o, 
                     project = 'workshop', 
                     name = 'mississippi_jrgonz', 
                     url = 'https://raw.githubusercontent.com/obiba/resources-workshop/main/data/co2_mississippi.tsv', 
                     format = 'tsv')

# check they have been uploaded
opal.resources(o, project='workshop')[, 1:2]

# logout
opal.logout(o)


# We prepare the login data and the resources to assign into DataSHIELD

builder <- DSI::newDSLoginBuilder()
builder$append(server = 'study1', url = 'https://opal-demo.obiba.org', 
               user = 'dsuser', password = 'password', 
               resource = 'RSRC.quebec_jrgonz', driver = 'OpalDriver')
builder$append(server = 'study2', url = 'https://opal-demo.obiba.org', 
               user = 'dsuser', password = 'password', 
               resource = 'RSRC.mississippi_jrgonz', driver = 'OpalDriver')

logindata <- builder$build()

conns <- datashield.login(logins = logindata, assign = TRUE, symbol = 'res')
ds.class('res')

# We then coerce the `ResourceClient` objects to data frames

datashield.assign.expr(conns, symbol = 'D', 
                       expr = quote(as.resource.data.frame(res, strict = TRUE)))
ds.class('D')

# Perform analyses
ds.colnames('D')
ds.table('D$Type')
ds.scatterPlot('D$conc', 'D$uptake', type = 'combine')
ds.glm('uptake ~ conc + Treatment', data='D', family='gaussian')

# Logout the connection
datashield.logout(conns)


# We remove the created resources
opal.resource_delete(opal=o, project='workshop', resource='quebec_jrgonz')
opal.resource_delete(opal=o, project='workshop', resource='mississippi_jrgonz')
