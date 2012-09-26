# Valid Jurisdiction-Year Creator (1960-Previous Year)
### Created by Christopher Gandrud
### Updated 26 September 2012

---

The R source code file `CountriesJurisdictions.R` in this repository can be used to create an R data frame of countries and jurisdictions that:

- reported GDP per Capita (current US$) to the World Bank, 

- have been given an [IMF country code](http://www.esds.ac.uk/international/support/use- r_guides/imf/ifs.asp).

The file uses the most recently available data from the [World Bank Development Indicator's website](http://data.worldbank.org/indicator/NY.GDP.PCAP.KN). So it will automatically have the most recent list of jurisdictions from **1960 through 2011**.

> Note: this is not a list of independent countries. It includes some non-country jurisdictions (ex. American Samoa) and it excludes countries that the World Bank does not have GDP per Capita data for (ex. Afghanistan 1982-2000). 

## Purpose

I use a lot of country-year data in my analyses. Sometimes I have data sets that were created automatically by, for example, combining lists of countries and years. This can create invalid observations, like Timor-Leste/1990.

To deal with this issue I created the R file `CountriesJurisdictions.R`. This file creates a data frame that can be combined with another data frame to remove country-year observations that do not have independently reported data on one of the most complete cross-country variables--GDP per Capita--and have not been given an IMF country code.

Country-years may not have GDP per Capita data/an IMF country code because:

- they do not exist as an independent or semi-independent entity,

- some other reason.

The second reason is clearly very open ended. These reasons could include civil war or severe economic hardship that inhibited data collection and reporting.

My work focuses largely on developed and developing countries where these have not been a problem, especially in the past 20-30 years. If a country has not reported GDP per Capita data, they will likely be excluded later in the analysis due to inadequate data on another variable of interest.

Removing these country-years from at the start of the analysis helps avoid:

- unrealistically large sample sizes,

- makes imputation models more efficient, because I'm not trying to impute data for country-year that do not exist or are not missing at random. 

## Use

To use `CountriesJurisdictions.R` first make sure that you install the following packages in R:

```
install.packages("WDI",
				  "countrycode",
				  "devtools")
```

Then run the following code:

```
# Load required library
library(devtools)

# Run CountriesJurisdictions.R
source_url("https://raw.github.com/christophergandrud/JurisdictionYear/master/CountriesJurisdictions.R")
```

This will create a data frame called `Countries` with the following variables:

| Variable   | Description  |
| ---------- | ------------ |
| `country`  | Country name |
| `year`     | Year         |
| `IMFCode`  | The IMF Code |
| `Data`     | A logical variable = TRUE |

### Merge and Subset

Now merge `Countries` with your data frame and subset it to remove all country-years that do not have GDP per Capita data/an IMF code.


