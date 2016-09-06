library(dplyr)
library (scales)

data <- read.csv (file="baseball_data.csv")

# This is partly inspired by jazzurro's answer in 
# http://stackoverflow.com/questions/27435453/how-to-normalise-subgroups-from-a-grouped-data-frame-in-r
data <- subset (data, avg >0 & HR > 0)

data.rescaled <- data %>% 
  mutate (avg_scaled = rescale (avg, t=c(0,100)),
          HR_scaled = rescale (HR, c(0,100)))

data.remodeled<- data.rescaled %>%
  group_by ( handedness ) %>%
  summarise_each ( funs ( mean ), avg_scaled, HR_scaled) %>%
  left_join(data.rescaled, ., by= "handedness" ) %>%
  mutate (distance = sqrt(  (avg_scaled.x - avg_scaled.y) ^ 2
                            + (HR_scaled.x - HR_scaled.y ) ^ 2 ) ) %>%
  group_by ( handedness ) %>%
  mutate ( distance_pctrank = percent_rank( distance ) * 100 ) %>%
  select ( -c ( avg_scaled.y, HR_scaled.y ) )

# data.remodeled <- data %>% 
#   group_by ( handedness ) %>%
#   mutate ( avg_pctrank = percent_rank (avg) * 100,
#            HR_pctrank = percent_rank (HR) * 100 ) %>%
#   mutate ( distance = sqrt(  (avg_pctrank - 50 ) ^ 2
#                             + (HR_pctrank - 50 ) ^ 2 ) ) %>%
#   mutate ( distance_pctrank = percent_rank( distance ) * 100 )

colnames(data.remodeled)[5] = "avg"
colnames(data.remodeled)[6] = "HR"
colnames(data.remodeled)[7] = "avg_scaled"
colnames(data.remodeled)[8] = "HR_scaled"

write.csv( data.remodeled, file = "baseball_data_remodeled.csv", row.names=F)
