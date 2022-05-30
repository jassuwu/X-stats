require("httr")
require("jsonlite")


library(plotly)
library(dotenv)

data1 <- GET("https://api.spacexdata.com/v4/launches/past")



data3 <- fromJSON(content(data1, "text"), flatten = TRUE)

data4 <- as.data.frame(data3)

launch_dates <- format(as.POSIXct(data4$date_utc), format = "%Y")

ds <- as.data.frame(table(launch_dates))

fig <- plot_ly(
    x = ds$launch_dates,
    y = ds$Freq,
    name = "launch_dates",
    type = "bar"
)


py <- plot_ly(username = "jassuwu", key = Sys.getenv("PLOTLY_API_KEY"))
# api_create(fig, filename = "SpaceX-DataVisualization_Launches")
