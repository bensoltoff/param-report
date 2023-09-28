## hiv-profile-params.R
##
## Generate country profile for each country in HIV dataset

library(tidyverse)
library(rmarkdown)

# get list of iso3 codes for reports
iso3_codes <- read_csv(file = "data/hiv_rates.csv") %>%
  distinct(iso3) %>%
  pull(iso3)

# create reports folder if it doesn't exist
output_dir <- "reports"
dir.create(output_dir)

# write a function to render the report
# iso3 - three letter identification code for a country
render_report <- function(iso3) {
  render(
    # where the R Markdown file saved
    input = "hiv-profile.Rmd",
    # folder where reports should be saved
    output_dir = output_dir,
    # uniquely name each report file based on the iso3 code
    output_file = str_glue("{iso3}.html"),
    # pass the parameterized value when we render the report
    params = list(
      my_iso3 = iso3
    )
  )
}

# does this work for a single country?
render_report(iso3 = "KEN")
render_report(iso3 = "USA")
render_report(iso3 = "AFG")

# now do this for every country using a purrr::map() function
map_chr(iso3_codes, render_report)
