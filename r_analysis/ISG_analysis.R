library(dplyr)
library(ggplot2)
library(readr)
library(jsonlite)
source("r_analysis/functions/preprocess.R")
source("r_analysis/functions/report_functions.R")

data <- read_csv("r_analysis/input/normalized counts latest EXP-25-EE2611.csv")
panel_info <- readxl::read_excel(
    path = "r_analysis/input/meta data/New ISG extended panel - for Nanostring.xlsx", sheet = 2
) %>%
    filter(type == "Endogenous")
sample_info_all <- left_join(
    readxl::read_excel("r_analysis/input/meta data/sample and physician info.xlsx", sheet = 1),
    readxl::read_excel("r_analysis/input/meta data/sample and physician info.xlsx", sheet = 2),
    by = "Referring physician"
) %>%
    mutate(
        `Sample ID` = as.numeric(`Sample ID`),
        `Referring physician` = if_else(is.na(`Referring physician`), "unknown", `Referring physician`)
    ) %>%
    left_join(readxl::read_excel("r_analysis/input/meta data/ISG IDs.xlsx", sheet = 1) %>% select(`Patient ID`, `Personal_number`), by = "Patient ID")

# load panel info
ISG_panel <- na.omit(panel_info$`ISG score`)
NFkb_panel <- na.omit(panel_info$`NF-kB score`)
IFNg_panel <- na.omit(panel_info$`IFN-g Score`)

# calculate scores
ISG <- geomean_score(data, ISG_panel) %>%
    add_column(zscore = (zscore_score(data, ISG_panel))$zscore)
data_filtered <- data %>% filter(!batch %in% c(
    "EXP-21-DN5206", "EXP-21-DN5207", "EXP-21-DN5208", "EXP-21-DN5209",
    "EXP-21-DN5210", "EXP-21-DN5211", "EXP-21-DN5212", "EXP-21-DN5214"
)) # for those batches the panel doesn't have NFkB or IFNg genes
NFkb <- geomean_score(data_filtered, NFkb_panel) %>%
    add_column(zscore = (zscore_score(data_filtered, NFkb_panel))$zscore)
IFNg <- geomean_score(data_filtered, IFNg_panel) %>%
    add_column(zscore = (zscore_score(data_filtered, IFNg_panel))$zscore)

# fig 1

table_preprocess <- function(data) {
    data %>%
        filter(
            Group %in% c("AGS", "CANDLE", "Healthy control", "IFN stimulation positive control") |
                (`Subject ID` == "ISG-6" & Group == "Patients")
        ) %>%
        mutate(label = if_else(`Subject ID` == "ISG-6",
            paste(`Subject ID`, Visit, sep = "_"),
            NA
        )) %>%
        mutate(
            Group = if_else(Group == "IFN stimulation positive control", "IFN-stim\npositive control", Group),
            Group = if_else(Group == "Healthy control", "Healthy\ncontrol", Group)
        ) %>%
        return()
}

# ISG score
ISG %>%
    table_preprocess() %>%
    score_scatter_plot()
ggsave("r_analysis/output/ISG_scatter.png", width = 6, height = 6)

healthy_range <- (ISG %>% filter(Group == "Healthy control"))$geomean %>% quantile(c(0.01, 0.99))
ISG %>%
    prepare_timeline_table(cur_sample_sets = c("ISG-6"), sample_info = sample_info_all %>% filter(`Patient ID` == "ISG-6")) %>%
    score_timeline_plot(healthy_range = healthy_range)
ggsave("r_analysis/output/ISG_timeline.png", width = 9, height = 4)

# NFkb score
NFkb %>%
    table_preprocess() %>%
    score_scatter_plot()
ggsave("r_analysis/output/NFkb_scatter.png", width = 6, height = 6)

healthy_range <- (NFkb %>% filter(Group == "Healthy control"))$geomean %>% quantile(c(0.01, 0.99))
NFkb %>%
    prepare_timeline_table(cur_sample_sets = c("ISG-6"), sample_info = sample_info_all %>% filter(`Patient ID` == "ISG-6")) %>%
    score_timeline_plot(healthy_range = healthy_range)
ggsave("r_analysis/output/NFkb_timeline.png", width = 9, height = 4)


# IFNg score
IFNg %>%
    table_preprocess() %>%
    score_scatter_plot()
ggsave("r_analysis/output/IFNg_scatter.png", width = 6, height = 6)

healthy_range <- (IFNg %>% filter(Group == "Healthy control"))$geomean %>% quantile(c(0.01, 0.99))
IFNg %>%
    prepare_timeline_table(cur_sample_sets = c("ISG-6"), sample_info = sample_info_all %>% filter(`Patient ID` == "ISG-6")) %>%
    score_timeline_plot(healthy_range = healthy_range)
ggsave("r_analysis/output/IFNg_timeline.png", width = 9, height = 4)


# export tables to a json file

patient_info <- sample_info_all %>%
    filter(`Patient ID` == "ISG-6") %>%
    arrange(desc(`Date of sampling`))

export_data <- list(
    patient_info = list(
        Patient_ID = "ISG-6",
        personal_number = patient_info$Personal_number[1],
        Contact = patient_info$Contact[1]
    ),
    sample_info = list(
        Patient_ID = "ISG-6",
        latest_Sample_ID = as.character(patient_info$`Sample ID`[1]),
        latest_visit = patient_info$Visit[1],
        referring_physician = patient_info$`Referring physician`[1],
        Sample_collection_location = patient_info$`Sample collection location`[1],
        date_of_sampling = patient_info$`Date of sampling`[1]
    ),
    ISG_score = prepare_score_table(
        ISG %>% filter(`Subject ID` == "ISG-6", Group == "Patients"), ISG_panel
    ),
    NFkb_score = prepare_score_table(
        NFkb %>% filter(`Subject ID` == "ISG-6", Group == "Patients"), NFkb_panel
    ),
    IFNg_score = prepare_score_table(
        IFNg %>% filter(`Subject ID` == "ISG-6", Group == "Patients"), IFNg_panel
    )
)

export_json <- toJSON(export_data, pretty = TRUE, auto_unbox = TRUE)
write(export_json, "r_analysis/output/ISG_analysis_report.json")
