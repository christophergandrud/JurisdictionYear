############ 
# Jurisdiction-Year Indicator
# Christopher Gandrud
# Updated 28 September 2012
############

## This file creates a data frame of countries & jurisdictions that report GDP per capita (current US$) data set
## to the World Bank & have an IMF Country Code for each year from 1960 to the present.

# Install & load required packages
## Based on https://gist.github.com/3710171
## See also http://bit.ly/PbabKd
doInstall <- FALSE  # Change to FALSE if you don't want packages installed.
toInstall <- c("WDI", "countrycode", "devtools")
if(doInstall){install.packages(toInstall, repos = "http://cran.us.r-project.org")}
lapply(toInstall, library, character.only = TRUE)

# Download data GDP per capita (current US$) data
# Indicator ID: NY.GDP.PCAP.CD
Countries <- WDI(indicator = "NY.GDP.PCAP.CD", start = "1960", end = "2011")

# Keep only countries with IMFCodes
Countries$IMFCode <- countrycode(Countries$country, origin = "country.name", destination = "imf")

Countries <- Countries[!is.na(Countries$IMFCode), ]

# Remove EU
Countries <- Countries[Countries$IMFCode != 696, ]

# Remove country-years with no GDP per capita data
Countries <- Countries[!is.na(Countries$NY.GDP.PCAP.CD), ]

# Create logical existance variable 
Countries$Data <- TRUE

# Keep country, year, IMFcode, Data variables
Countries <- Countries[, c("country", "year", "IMFCode", "Data")]