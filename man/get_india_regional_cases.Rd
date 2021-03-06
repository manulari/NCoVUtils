% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_india_regional_cases.R
\name{get_india_regional_cases}
\alias{get_india_regional_cases}
\title{Get India daily cases}
\usage{
get_india_regional_cases(data = "cases")
}
\arguments{
\item{data}{Character string specifying whether to return case or death count}
}
\value{
A dataframe of case or death counts
}
\description{
Get Indian cases or deaths by state
}
\examples{

\dontrun{
## Mapping
# Filter to latest date
latest_cases <- dplyr::filter(india_cases, date == max(date))
# Note that basemaps are not updated to reflect Ladakh as a Union Territory, so joining separately
ladakh <- raster::getData('GADM', country='IND', level=2) \%>\%
  sf::st_as_sf() \%>\%
  dplyr::filter(NAME_2 == "Leh (Ladakh)" | NAME_2 == "Kargil") \%>\%
  dplyr::mutate(district = c("Leh", "Kargil"),
                state = "Ladakh") \%>\%
  dplyr::group_by(state) \%>\%
  dplyr::summarise()
india_map <- raster::getData('GADM', country='IND', level=1) \%>\%
  sf::st_as_sf() \%>\%
  dplyr::select(state = NAME_1) \%>\%
  # Join  maps
  rbind(ladakh) \%>\%
  # Join data
  dplyr::left_join(latest_cases, by = c("state" = "name"))
# Plot
india_map \%>\%
  ggplot2::ggplot(ggplot2::aes(fill = cases)) +
  ggplot2::geom_sf()
}


}
