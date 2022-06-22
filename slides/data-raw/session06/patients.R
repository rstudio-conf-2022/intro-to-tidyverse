# Create patients dataset for recode session

# Load packages
library(tidyverse)

# Parameters
file_dem <- "https://wwwn.cdc.gov/Nchs/Nhanes/2007-2008/DEMO_E.XPT"
file_body <- "https://wwwn.cdc.gov/Nchs/Nhanes/2007-2008/BMX_E.XPT"
file_bp <- "https://wwwn.cdc.gov/Nchs/Nhanes/2007-2008/BPX_E.XPT"
file_fasting <- "https://wwwn.cdc.gov/Nchs/Nhanes/2007-2008/GLU_E.XPT"
file_out <- here::here("slides/data/session06/patients.csv")
  
# Load data
dem <- 
  haven::read_xpt(file_dem) %>%
  haven::zap_label() %>%
  transmute(
    seq_no = SEQN,
    age = RIDAGEYR,
    sex = if_else(RIAGENDR == 1, "male", "female"),
  ) 

body <- 
  haven::read_xpt(file_body) %>%
  haven::zap_label() %>%
  transmute(
    seq_no = SEQN,
    bmi = BMXBMI
  ) 

bp <- 
  haven::read_xpt(file_bp) %>%
  haven::zap_label() %>%
  transmute(
    seq_no = SEQN,
    sys_bp = BPXSY2,
    dias_bp = BPXDI2
  )

fasting <- 
  haven::read_xpt(file_fasting) %>%
  haven::zap_label() %>%
  transmute(
    seq_no = SEQN,
    glucose = LBXGLU
  )

# Join to create patients dataset
set.seed(123)

patients <- 
  inner_join(dem, body, by = "seq_no") %>%
  inner_join(bp) %>%
  inner_join(fasting) %>%
  # inner_join(nhanes_glucose) %>%
  tidyr::drop_na() %>%
  slice_sample(n = 30) %>%
  mutate(
    seq_no = row_number()
  ) %>%
  rename(id = seq_no) %>%
  relocate(
    glucose, .after = "bmi"
  )

# Write to CSV
patients %>% 
  write_csv(file_out)