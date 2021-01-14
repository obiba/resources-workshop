## ----setup, include=FALSE-------------------------------------------------------------------------
library(knitr)
BiocStyle::markdown()
options(width=100)
knitr::opts_chunk$set(comment="", warning=FALSE, message=FALSE, cache=TRUE)


## ----eval=FALSE-----------------------------------------------------------------------------------
install.packages("DSOpal")
devtools::install_github("datashield/dsBaseClient")
devtools::install_github("isglobal-brge/dsOmicsClient") 


## ----load_packages--------------------------------------------------------------------------------
library(DSOpal) 
library(dsBaseClient)
library(dsOmicsClient)


## ----projects, echo=FALSE, fig.cap='Opal demo site available projects', fig.align='center'--------
knitr::include_graphics("fig/opal_projects.png")


## ----resources, echo=FALSE, fig.cap='Resources available at Opal demo site of RSRC project',  fig.align='center'----
knitr::include_graphics("fig/resources_rsrc.png")


## -------------------------------------------------------------------------------------------------
o <- opal.login(username = 'administrator',
                password = 'password', 
                url = 'https://opal-demo.obiba.org')


## -------------------------------------------------------------------------------------------------
opal.resource_create(opal = o, 
                     project = 'RSRC', 
                     name = 'pheno_TCGA', 
                     url = 'http://duffel.rail.bio/recount/TCGA/TCGA.tsv', 
                     format = 'tsv',
                     secret = 'GRGdder')


## -------------------------------------------------------------------------------------------------
opal.resources(o, project='RSRC')


## -------------------------------------------------------------------------------------------------
opal.assign.resource(o, 'client', 'RSRC.pheno_TCGA')
opal.execute(o, 'class(client)')


## -------------------------------------------------------------------------------------------------
opal.logout(o)


## -------------------------------------------------------------------------------------------------
builder <- newDSLoginBuilder()
builder$append(server = 'study1', url = 'https://opal-demo.obiba.org', 
               user = 'dsuser', password = 'password', 
               resource = 'RSRC.pheno_TCGA', driver = 'OpalDriver')
logindata <- builder$build()


## -------------------------------------------------------------------------------------------------
conns <- datashield.login(logins = logindata, 
                          assign = TRUE, 
                          symbol = 'res')


## -------------------------------------------------------------------------------------------------
datashield.assign.expr(conns, symbol = 'pheno', 
                       expr = quote(as.resource.data.frame(res)))


## -------------------------------------------------------------------------------------------------
ds.class('pheno')
ds.dim('pheno')


## -------------------------------------------------------------------------------------------------
datashield.logout(conns)


## -------------------------------------------------------------------------------------------------

o <- opal.login('administrator','password', 
                url='https://opal-demo.obiba.org')

opal.resource_create(opal = o, 
                     project = 'RSRC', 
                     name = 'asthma', 
                     url = 'https://github.com/isglobal-brge/brgedata/raw/master/data/asthma.rda', 
                     format = 'data.frame')
     
opal.assign.resource(o, 'client', 'RSRC.asthma')
opal.execute(o, 'class(client)')

opal.logout(o)


## -------------------------------------------------------------------------------------------------
builder <- newDSLoginBuilder()
builder$append(server = 'study1', url = 'https://opal-demo.obiba.org', 
               user = 'dsuser', password = 'password', 
               resource = 'RSRC.asthma', driver = 'OpalDriver')
logindata <- builder$build()

conns <- datashield.login(logins = logindata, 
                          assign = TRUE, 
                          symbol = 'res')

datashield.assign.expr(conns, symbol = 'asthma', 
                       expr = quote(as.resource.object(res)))


## -------------------------------------------------------------------------------------------------
ds.class('asthma')

ds.colnames('asthma')

ds.glm(casecontrol ~ rs1422993 + smoke + bmi, data='asthma', family='binomial')


## -------------------------------------------------------------------------------------------------
datashield.logout(conns)


## ----eSet, echo=FALSE, fig.cap='ExpressionSet infrastructure', fig.align='center'-----------------
knitr::include_graphics("fig/eSet_vs_dataframe.png")


## -------------------------------------------------------------------------------------------------
o <- opal.login('administrator','password', 
                url='https://opal-demo.obiba.org')

opal.resource_create(opal = o, 
                     project = 'RSRC', 
                     name = 'genexpr', 
                     url = 'https://github.com/isglobal-brge/brgedata/raw/master/data/brge_gexp.rda', 
                     format = 'ExpressionSet')

opal.assign.resource(o, 'client', 'RSRC.genexpr')
opal.execute(o, 'class(client)')


## -------------------------------------------------------------------------------------------------
builder <- newDSLoginBuilder()
builder$append(server = 'study1', url = 'https://opal-demo.obiba.org', 
               user = 'dsuser', password = 'password', 
               resource = 'RSRC.genexpr', driver = 'OpalDriver')
logindata <- builder$build()

conns <- datashield.login(logins = logindata, 
                          assign = TRUE, 
                          symbol = 'res')

datashield.assign.expr(conns, symbol = 'eSet', 
                       expr = quote(as.resource.object(res)))


## -------------------------------------------------------------------------------------------------
ds.class('eSet')
ds.dim('eSet')


## ----error=TRUE-----------------------------------------------------------------------------------
ds.colnames('eSet')


## -------------------------------------------------------------------------------------------------
dsOmicsClient::ds.featureData('eSet')


## -------------------------------------------------------------------------------------------------
datashield.logout(conns)


## ----insert_table_variables, echo=FALSE-----------------------------------------------------------
vars <- readr::read_delim("fig/table_variables_cnsim.txt", delim=",")
kable(vars)


## -------------------------------------------------------------------------------------------------
opal.resource_delete(opal=o, project='RSRC', resource='pheno_TCGA')
opal.resource_delete(opal=o, project='RSRC', resource='asthma')
opal.resource_delete(opal=o, project='RSRC', resource='genexpr')


## -------------------------------------------------------------------------------------------------
sessionInfo()

