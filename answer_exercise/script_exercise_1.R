##########################################################
#                                                        #
# Add the resource to the opal server (project workshop) #
#                                                        #
##########################################################


library(opalr)
o <- opal.login('administrator','password', 
                url='https://opal-demo.obiba.org')

opal.resource_create(opal = o, 
                     project = 'workshop', 
                     name = 'eSet_DrMMuZ', 
                     url = 'https://github.com/isglobal-brge/brgedata/raw/master/data/GSE6012.Rdata', 
                     format = 'ExpressionSet')

opal.resources(o, project='RSRC')
opal.resources(o, project='workshop')

opal.logout(o)

##########################################################
#                                                        #
# Analysis with DataSHIELD                               #
#                                                        #
##########################################################

library(DSOpal)
library(dsBaseClient)
library(dsOmicsClient)

# prepare login data and resources to assign
builder <- newDSLoginBuilder()
builder$append(server = 'study1', url = 'https://opal-demo.obiba.org', 
               user = 'dsuser', password = 'password', 
               resource = 'workshop.eSet_DrMMuZ')
logindata <- builder$build()

# login and assign resources
conns <- datashield.login(logins = logindata, 
                          assign = TRUE, 
                          symbol = 'res')

# coerce ResourceClient object to ExpressionSet
datashield.assign.expr(conns, symbol = 'eSet_DrMMuZ', 
                       expr = quote(as.resource.object(res)))

# analysis with Client server
ds.class('res')
ds.class('eSet_DrMMuZ')


ds.nFeatures('eSet_DrMMuZ')
ds.nSamples('eSet_DrMMuZ')
ds.fvarLabels('eSet_DrMMuZ')

# logout the connection
datashield.logout(conns) 

# remove the created resource
o <- opal.login('administrator','password', 
                url='https://opal-demo.obiba.org')

opal.resource_delete(opal=o, project='workshop', resource='eSet_DrMMuz')

opal.logout(o)
