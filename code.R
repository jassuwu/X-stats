require("httr")
require("jsonlite")


library(plotly) # for plotting
library(dotenv) # for reading .env file




# Launch section

# launch_data1 <- GET("https://api.spacexdata.com/v4/launches/past")



# launch_data3 <- fromJSON(content(launch_data1, "text"), flatten = TRUE)

# launch_data4 <- as.data.frame(launch_data3)

# launch_dates <- format(as.POSIXct(launch_data4$date_utc), format = "%Y")

# ds <- as.data.frame(table(launch_dates))

# fig <- plot_ly(
#     x = ds$launch_dates,
#     y = ds$Freq,
#     name = "launch_dates",
#     type = "bar"
# )


# py <- plot_ly(username = "jassuwu", key = Sys.getenv("PLOTLY_API_KEY"))
# # api_create(fig, filename = "SpaceX-DataVisualization_Launches")






# Starlink section

starlink_data1 <- GET("https://api.spacexdata.com/v4/starlink")



starlink_data3 <- fromJSON(content(starlink_data1, "text"), flatten = TRUE)

starlink_data4 <- as.data.frame(starlink_data3)

# View(starlink_data4$spaceTrack.LAUNCH_DATE)
starlink_launch_dates <- format(as.POSIXct(starlink_data4$spaceTrack.LAUNCH_DATE), format = "%Y-%m")
View(starlink_launch_dates)
ds <- as.data.frame(table(starlink_launch_dates))
View(ds)



# Core section

# core_data1 <- GET("https://api.spacexdata.com/v4/cores")



# core_data3 <- fromJSON(content(core_data1, "text"), flatten = TRUE)

# core_data4 <- as.data.frame(core_data3)

# # View(core_data4[c("serial", "reuse_count")])

# core_ds <- as.data.frame(core_data4[c("serial", "reuse_count")])

# fig <- plot_ly(
#     x = core_ds$serial,
#     y = core_ds$reuse_count,
#     name = "core_reuse_count",
#     type = "bar"
# )

# print(fig)






# Landing section

# landing_data1 <- GET("https://api.spacexdata.com/v4/landpads")



# landing_data3 <- fromJSON(content(landing_data1, "text"), flatten = TRUE)

# landing_data4 <- as.data.frame(landing_data3)

# landing_ds <- landing_data4[c("name", "landing_successes")]

# fig <- plot_ly(
#     x = landing_ds$name,
#     y = landing_ds$landing_success,
#     name = "landingSucess_count_per_launchpad",
#     type = "bar"
# )

# print(fig)
