require("httr")
require("jsonlite")


library(plotly) # for plotting
library(dotenv) # for reading .env file



#####################################################################################
# Launch section

launch_data1 <- GET("https://api.spacexdata.com/v4/launches/past")

launch_data3 <- fromJSON(content(launch_data1, "text"), flatten = TRUE)
launch_data4 <- as.data.frame(launch_data3)
launch_dates <- format(as.POSIXct(launch_data4$date_utc), format = "%Y")
launch_ds <- as.data.frame(table(launch_dates))

launch_fig <- plot_ly(
    x = launch_ds$launch_dates,
    y = launch_ds$Freq,
    name = "launch_dates",
    type = "bar"
)

#  print(launch_fig)

#####################################################################################
# Landing section

landing_data1 <- GET("https://api.spacexdata.com/v4/landpads")

landing_data3 <- fromJSON(content(landing_data1, "text"), flatten = TRUE)
landing_data4 <- as.data.frame(landing_data3)
landing_ds <- landing_data4[c("name", "landing_successes")]

landing_fig <- plot_ly(
    x = landing_ds$name,
    y = landing_ds$landing_success,
    name = "landingSucess_count_per_launchpad",
    type = "bar"
)

# print(landing_fig)

#####################################################################################
# Starlink section

starlink_data1 <- GET("https://api.spacexdata.com/v4/starlink")

starlink_data3 <- fromJSON(content(starlink_data1, "text"), flatten = TRUE)
starlink_data4 <- as.data.frame(starlink_data3)
starlink_launch_dates <- format(as.POSIXct(starlink_data4$spaceTrack.LAUNCH_DATE), format = "%Y-%m")
starlink_ds <- as.data.frame(table(starlink_launch_dates))

starlink_fig <- plot_ly(
    x = starlink_ds$starlink_launch_dates,
    y = starlink_ds$Freq,
    name = "starlink_launch_dates",
    type = "scatter",
    mode = "lines+markers"
)

# print(starlink_fig)

#####################################################################################
# Core section

core_data1 <- GET("https://api.spacexdata.com/v4/cores")


core_data3 <- fromJSON(content(core_data1, "text"), flatten = TRUE)
core_data4 <- as.data.frame(core_data3)
core_ds <- as.data.frame(core_data4[c("serial", "reuse_count")])

core_fig <- plot_ly(
    x = core_ds$serial,
    y = core_ds$reuse_count,
    name = "core_reuse_count",
    type = "bar"
)

# print(core_fig)

#####################################################################################
# Payload nationalities

pLoad_data1 <- GET("https://api.spacexdata.com/v4/payloads")

pLoad_data3 <- fromJSON(content(pLoad_data1, "text"), flatten = TRUE)
pLoad_data4 <- as.data.frame(pLoad_data3)

nationalities <- c()
# Making a nationalities table
for (p in pLoad_data4$nationalities) {
    if (length(p) != 0) {
        nationalities <- append(nationalities, p)
    }
}
pLoad_nat_ds <- as.data.frame(table(nationalities))
pLoad_nat_labels <- pLoad_nat_ds$nationalities
pLoad_nat_values <- pLoad_nat_ds$Freq

pLoad_nat_fig <- plot_ly(
    type = "pie", labels = pLoad_nat_labels, values = pLoad_nat_values,
    textinfo = "label+percent",
    insidetextorientation = "radial"
)

# print(pLoad_nat_fig)

######################################################################################
# Chart-Studio

py <- ggplotly(username = "jassuwu", key = Sys.getenv("PLOTLY_API_KEY"))
api_create(launch_fig, filename = "x_stats_launch")
api_create(landing_fig, filename = "x_stats_landing")
api_create(starlink_fig, filename = "x_stats_starlink")
api_create(core_fig, filename = "x_stats_core")
api_create(pLoad_nat_fig, filename = "x_stats_pLoad_nat")

######################################################################################
