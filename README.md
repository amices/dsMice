<!-- README.md is generated from README.Rmd. Please edit that file -->

dsMice
======

Multivariate Imputation by Chained Equations for DataSHIELD - Server
--------------------------------------------------------------------

The [`mice`](https://github.com/stefvanbuuren/mice) package creates multiple imputations (replacement values) for multivariate missing data.

The [`DataSHIELD`](https://github.com/datashield) framework is a platform for federated data analysis that brings the algorithm to the data.

The [`dsMiceClient`](https://github.com/stefvanbuuren/dsMiceClient) package is an add-on to `mice` that makes multiple imputation available for federated data systems. This is the package that the `DataSHIELD` end user installs locally.

The [`dsMice`](https://github.com/stefvanbuuren/dsMice) package is part of the `DataSHIELD` infrastructure. This is the package that the `DataSHIELD` node owner installs on the server.

Installation
------------

The following code installs the `dsMice` package on the node server:

Install the `opaladmin` dependence using the R console.

```R
install.packages('opaladmin', repos=c('http://cran.rstudio.com/', 'http://cran.obiba.org'), dependencies=TRUE)
```
Call the `opal` and `opaladmin` library.
```R
library(opal)
library(opaladmin)
```
Connect to data nodes.
```R
o <- opal.login(username = 'user', password = 'pass', url = "https://node-address-1")
o2 <- opal.login(username = 'user', password = 'pass', url = "https://node-address-2")
o3 <- opal.login(username = 'user', password = 'pass', url = 'https://node-address-3')
```

Remove old version of the package (if you have installed it before).
```R
if ("dsMice" %in% rownames(installed.packages())) dsadmin.remove_package(o, 'dsMice')
if ("dsMice" %in% rownames(installed.packages())) dsadmin.remove_package(o2, 'dsMice')
if ("dsMice" %in% rownames(installed.packages())) dsadmin.remove_package(o3, 'dsMice')
```

Install the package **devtools** into data node (only for the first run).
```R
oadmin.install_devtools(o)
oadmin.install_devtools(o2)
oadmin.install_devtools(o3)
```

Download the package from Git repository to data nodes.
```R
cmd <- paste('devtools::install_github("stefvanbuuren/dsMice")')
opal.execute(o, cmd)
opal.execute(o2, cmd)
opal.execute(o3, cmd)
```

Install the package into data nodes
```R
dsadmin.install_package(o, 'dsMice')
dsadmin.install_package(o2, 'dsMice')
dsadmin.install_package(o3, 'dsMice')
```

Publish the package's DataSHIELD methods
```R
dsadmin.set_package_methods(o, 'dsMice')
dsadmin.set_package_methods(o2, 'dsMice')
dsadmin.set_package_methods(o3, 'dsMice')
```

Logout from Opal
```R
opal.logout(o)
opal.logout(o2)
opal.logout(o3)
```

In order to work well, the end user should that the [`dsMiceClient`](https://github.com/stefvanbuuren/dsMiceClient) package installed locally.

Note
----

Warning: This is an experimental feature. These function do not yet actually work. If you have ideas about the integration of `mice` and `DataSHIELD` feel free to join in.

Related initiative
------------------

Related work appears in [`gflcampos/dsMice`](https://github.com/gflcampos/dsMice) and [`gflcampos/dsMiceClient`](https://github.com/gflcampos/dsMiceClient).

Minimal example
---------------

Include minimal example here using public DataSHIELD nodes.
