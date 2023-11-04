library(opendatatoronto)
library(dplyr)
library(tidyverse)


#
setwd("/Users/benjaminzhang/Documents/Final_Project_Applied_Machine_Learning")

# get package
#package <- show_package("5d58e89e-ae55-4188-9d28-5c8a815f84df")
#package

NB_profiles <- read.csv("neighbourhood_profile_2021_census.csv")
NB_crime <- read.csv("ID_Removed_Crime_TORONTO.csv")

# Filtered Profiles 
list_of_features <- c("Neighbourhood Number", 
                     "  Gini index on adjusted household total income", "Average household size", "  Average total income of household in 2020 ($)", "  Average after-tax income of household in 2020 ($)", 
                     "Total - Visible minority for the population in private households - 25% sample data"," Total visible minority population", "  South Asian","  Chinese", "    Black","  Filipino","    Arab","    Latin American","    Southeast Asian","    West Asian","  Korean","  Japanese","  Visible minority, n.i.e.", "    Multiple visible minorities","  Not a visible minority", 
                     "Total - Population aged 15 years and over by labour force status - 25% sample data", "    Unemployed", "Unemployment rate", 
                     "Total - Highest certificate, diploma or degree for the population aged 15 years and over in private households - 25% sample data",  "  No certificate, diploma or degree",   "  No high school diploma or equivalency certificate", "  High (secondary) school diploma or equivalency certificate", "  Postsecondary certificate, diploma or degree", "    Bachelor’s degree or higher", "      Bachelor's degree", "      University certificate or diploma above bachelor level", "      Degree in medicine, dentistry, veterinary medicine or optometry", "      Master's degree", "      Earned doctorate")

Filtered_NB_prof <- NB_profiles %>% filter(Neighbourhood.Name %in% list_of_features)

#list_of_features2 <- c("Neighbourhood Number",
#                      "Gini_adj_HH_tincome", "Avg_HH_size", "Mean_t_income", "Avg_after_tax_t_income", 
#                      "Total_Visible_minority_denom","Total visible minority population_num", "South Asian","Chinese", "Black","Filipino","Arab","Latin American","Southeast Asian","West Asian","Korean","Japanese","Visible minority, n.i.e.", "Multiple visible minorities","Not a visible minority", 
#                      "Total_Employment_status", "Unemployed", "Unemployment rate", 
#                      "Total_Highest certificate","No_HS_or_Equivalent", "HS_diploma_or_Equivalent", "PS_degree", "Bachelors_or_higher", "Bachelors", "Above_bachelors_level", "Med_dentistry_or_vet_or_opt", "Master's degree", "Earned doctorate")

#Filtered_NB_prof$Short_features <-list_of_features2 

NB_crime <- NB_crime %>% 
  rename(
    Neighbourhood.Name=AREA_NAME
  )

NB_names <- c(colnames(Filtered_NB_prof),colnames(NB_crime))

NB_names[!(duplicated(NB_names)|duplicated(NB_names, fromLast=TRUE))]

NB_crime <- NB_crime %>% 
  rename(
    Neighbourhood.Name=AREA_NAME
  )

Filtered_NB_prof <- Filtered_NB_prof %>% 
  rename(
    Yonge.St.Clair = Yonge.St..Clair,
    Cabbagetown.South.St.James.Town = Cabbagetown.South.St..James.Town,
    North.St.James.Town = North.St..James.Town,
  )


Combined_NB_char <-rbind(Filtered_NB_prof,NB_crime)

write.csv(Combined_NB_char, "FilteredFeatures.csv", row.names=FALSE)


NB_cleaned <- read.csv("Neighbhourhood_Characteristics1.csv")
NB_cleaned2 <- read.csv("Neighbhourhood_Characteristics2.csv")


test <- NB_cleaned2 %>% select(Gini_i_HH_tIncome,Avg_HH_size, Avg_tIncome_HH_in_2020,Race_Total, Prop_Black, Prop_Arab, Prop_Latin_Amrican, Prop_East_SouthEast_Asian, Prop_West_Asian, Prop_multi_vis_minority,  Prop_non_vis_minority, 
                               Unemployment_rate,)

Filtered_NB_prof2 <- NB_cleaned2 %>% select(Neighbourhood.Name,Gini_i_HH_tIncome,Avg_HH_size, Avg_tIncome_HH_in_2020, Race_Total, Prop_Black, Prop_Arab, Prop_Latin_Amrican, Prop_East_SouthEast_Asian, Prop_West_Asian, Prop_multi_vis_minority,  Prop_non_vis_minority, 
                       Unemployment_rate, Prop_no_dip,  Prop_HS_or_equi,Prop_PS_non_Bach, Prop_PS_Bach, Prop_Graduate, 
                       MEAN_VIOLENT_CRIME_RATE_2014_2022, TOTAL_CRIME_RATE_2022, TOTAL_CRIME_RATE_2016,ROBBERY_2016,BREAKENTER_2016,SHOOTING_2016)

Filtered_NB_prof2 <- NB_cleaned2 %>% select(Gini_i_HH_tIncome,)

write.csv(Filtered_NB_prof2, "Cleaned_NB_Profile_Crime_data.csv", row.names=FALSE)

#NB_further_cleaned <- 

