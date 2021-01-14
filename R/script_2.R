#################################################################################################
##
##   Adding a new resource to the OPAL server
##
#################################################################################################

#
# Load the required R packages
#
library(DSOpal) # opalr is loaded
library(dsBaseClient)

#
# 1. Text file
#

o <- opal.login('administrator','password', 
                url='https://opal-demo.obiba.org')

# we can see the existing resources
opal.resources(o, project='RSRC')

# add a new resource (data frame)

opal.resource_create(opal = o, 
                     project = 'RSRC', 
                     name = 'pheno_TCGA', 
                     url = 'http://duffel.rail.bio/recount/TCGA/TCGA.tsv', 
                     format = 'tsv',
                     secret = 'AoLlQde') # optional (just to illustrating purposes)

# to test the resource assignment
opal.assign.resource(o, 'client', 'RSRC.pheno_TCGA')
opal.execute(o, 'class(client)')

# logout
opal.logout(o)

# using the resource
builder <- newDSLoginBuilder()
builder$append(server = 'study1', url = 'https://opal-demo.obiba.org', 
               user = 'dsuser', password = 'password', 
               resource = 'RSRC.pheno_TCGA', driver = 'OpalDriver')
logindata <- builder$build()

# the resource is loaded into R as the object called 'res' 
conns <- datashield.login(logins = logindata, 
                          assign = TRUE, 
                          symbol = 'res')

# the resource is assigned to a data.frame called 'asthma'
datashield.assign.expr(conns, symbol = 'pheno', 
                       expr = quote(as.resource.data.frame(res)))

ds.class('pheno')
ds.dim('pheno')

datashield.logout(conns)

#
# 2. R object - data frame
#

o <- opal.login('administrator','password', 
                url='https://opal-demo.obiba.org')


# add a new resource (data frame)

opal.resource_create(opal = o, 
                     project = 'RSRC', 
                     name = 'asthma', 
                     url = 'https://github.com/isglobal-brge/brgedata/raw/master/data/asthma.rda', 
                     format = 'data.frame',
                     secret = 'EeTtQGI') # optional (just to illustrating purposes)

# to test the resource assignment
opal.assign.resource(o, 'client', 'RSRC.asthma')
opal.execute(o, 'class(client)')


# logout
opal.logout(o)


# using  the resource
builder <- newDSLoginBuilder()
builder$append(server = 'study1', url = 'https://opal-demo.obiba.org', 
               user = 'dsuser', password = 'password', 
               resource = 'RSRC.asthma', driver = 'OpalDriver')
logindata <- builder$build()

# the resource is loaded into R as the object called 'res' 
conns <- datashield.login(logins = logindata, 
                          assign = TRUE, 
                          symbol = 'res')

# the resource is assigned to a data.frame called 'asthma'
datashield.assign.expr(conns, symbol = 'asthma', 
                       expr = quote(as.resource.object(res)))

ds.class('asthma')

ds.colnames('asthma')

ds.glm(casecontrol ~ rs1422993 + smoke + bmi, data='asthma', family='binomial')

datashield.logout(conns)


#
# 3. R object - RangedSummarizedExperiment
#

o <- opal.login('administrator','password', 
                url='https://opal-demo.obiba.org')


# add a new resource (data frame)

opal.resource_create(opal = o, 
                     project = 'RSRC', 
                     name = 'prostate', 
                     url = 'http://duffel.rail.bio/recount/v2/TCGA/rse_gene_prostate.Rdata', 
                     format = 'RangedSummarizedExperiment',
                     secret = 'TyuIBgm') # optional (just to illustrating purposes)

# to test the resource assignment
opal.assign.resource(o, 'client', 'RSRC.prostate')
opal.execute(o, 'class(client)')


# logout
opal.logout(o)

# using  the resource
builder <- newDSLoginBuilder()
builder$append(server = 'study1', url = 'https://opal-demo.obiba.org', 
               user = 'dsuser', password = 'password', 
               resource = 'RSRC.prostate', driver = 'OpalDriver')
logindata <- builder$build()

# the resource is loaded into R as the object called 'res' 
conns <- datashield.login(logins = logindata, 
                          assign = TRUE, 
                          symbol = 'res')

# the resource is assigned to a data.frame called 'asthma'
datashield.assign.expr(conns, symbol = 'prostate', 
                       expr = quote(as.resource.object(res)))

ds.class('prostate')

ds.dim('prostate')

ds.colnames('prostate')  # get error, but ...

dsOmicsClient::ds.featureData('prostate')

datashield.logout(conns)


#
# Remove added resources
#

opal.resource_delete(opal=o, project='RSRC', resource='asthma')
opal.resource_delete(opal=o, project='RSRC', resource='pheno_TCGA')
opal.resource_delete(opal=o, project='RSRC', resource='prostate')


#
# PLINK
#


#
# Combining three different types of resources 
# 


#
# Shiny app
#
