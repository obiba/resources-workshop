## ----load_packages--------------------------------------------------------------------------------
library(DSOpal) 
library(dsBaseClient)
library(dsOmicsClient)






## -------------------------------------------------------------------------------------------------
o <- opal.login(username = 'administrator',
                password = 'password', 
                url = 'https://opal-demo.obiba.org')


## -------------------------------------------------------------------------------------------------
opal.resource_create(opal = o, 
                     project = 'RSRC', 
                     name = 'pheno_TCGA', 
                     url = 'http://duffel.rail.bio/recount/TCGA/TCGA.tsv', 
                     format = 'tsv')


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


## -------------------------------------------------------------------------------------------------
dsOmicsClient::ds.nFeatures('eSet')
dsOmicsClient::ds.nSamples('eSet')


## -------------------------------------------------------------------------------------------------
datashield.logout(conns)


## ----insert_table_variables, echo=FALSE-----------------------------------------------------------
vars <- readr::read_delim("fig/table_variables_cnsim.txt", delim=",")
kable(vars)


## ----cnsim_multiple-------------------------------------------------------------------------------
builder <- DSI::newDSLoginBuilder()
builder$append(server = "study1", url = "https://opal-demo.obiba.org", 
               user = "dsuser", password = "password", 
               resource = "RSRC.CNSIM1", driver = "OpalDriver")
builder$append(server = "study2", url = "https://opal-demo.obiba.org", 
               user = "dsuser", password = "password", 
               resource = "RSRC.CNSIM2", driver = "OpalDriver")
builder$append(server = "study3", url = "https://opal-demo.obiba.org", 
               user = "dsuser", password = "password", 
               resource = "RSRC.CNSIM3", driver = "OpalDriver")
logindata <- builder$build()


## -------------------------------------------------------------------------------------------------
conns <- datashield.login(logins = logindata, assign = TRUE, symbol = "res")


## -------------------------------------------------------------------------------------------------
ds.class("res")


## -------------------------------------------------------------------------------------------------
datashield.assign.expr(conns, symbol = "D", 
                       expr = quote(as.resource.data.frame(res, strict = TRUE)))
ds.class("D")


## -------------------------------------------------------------------------------------------------
ds.summary('D$LAB_HDL')


## -------------------------------------------------------------------------------------------------
ds.class('D$GENDER')
ds.asFactor('D$GENDER', 'GENDER')
ds.summary('GENDER')


## -------------------------------------------------------------------------------------------------
mod <- ds.glm("DIS_DIAB ~ LAB_TRIG + GENDER", data = "D" , family="binomial")
mod$coeff


## -------------------------------------------------------------------------------------------------
datashield.logout(conns)




## -------------------------------------------------------------------------------------------------
library(resourcer)
ssh.res <- newResource(
  url = "ssh://plink-demo.obiba.org:2222/home/master/brge?exec=ls,plink1,plink",
  identity = "master",
  secret = "master"
)


## -------------------------------------------------------------------------------------------------
ssh.client <- newResourceClient(ssh.res)
class(ssh.client)


## -------------------------------------------------------------------------------------------------
ssh.client$getAllowedCommands()


## -------------------------------------------------------------------------------------------------
ssh.client$exec("ls")


## -------------------------------------------------------------------------------------------------
ans <- ssh.client$exec('plink1', c('--bfile', 'brge', '--assoc', '--pheno', 'brge.phe', '--pheno-name', 'obese', '--noweb'))
ans


## ----eval=FALSE-----------------------------------------------------------------------------------
## ssh.client$downloadFile()


## ----GWAS_shell_1---------------------------------------------------------------------------------
  builder <- newDSLoginBuilder()
  builder$append(server = "study1", url = "https://opal-demo.obiba.org",
                 user = "dsuser", password = "password",
                 resource = "RSRC.brge_plink", driver = "OpalDriver")
  logindata <- builder$build()


## ----GWAS_shell_3---------------------------------------------------------------------------------
  conns <- datashield.login(logins = logindata, assign = TRUE,
                            symbol = "client")
  ds.class("client")


## -------------------------------------------------------------------------------------------------
plink.arguments <- "--bfile brge --assoc --pheno brge.phe --pheno-name obese"


## -------------------------------------------------------------------------------------------------
library(dsOmicsClient)
ans.plink <- ds.PLINK("client", plink.arguments)


## ----GWAS_shell_result1---------------------------------------------------------------------------
lapply(ans.plink, names)
  
head(ans.plink$study1$results)
  
ans.plink$study$plink.out


## -------------------------------------------------------------------------------------------------
opal.resource_delete(opal=o, project='RSRC', resource='pheno_TCGA')
opal.resource_delete(opal=o, project='RSRC', resource='asthma')
opal.resource_delete(opal=o, project='RSRC', resource='genexpr')




## -------------------------------------------------------------------------------------------------
sessionInfo()

