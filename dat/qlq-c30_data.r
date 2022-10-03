pacman::p_load(tidyverse, rio)
pacman::p_load(labelled)

d1 <- import("dat/ww eortc qlq-c30.csv") %>% 
   mutate(USUBJID  = factor(USUBJID),
          ARM      = factor(ARM)) %>% 
   mutate(AVISIT_N = readr::parse_number(AVISIT),
          AVISIT_F = factor(AVISIT_N))

var_label(d1) <- list( QL = 'health and quality of life scale ', 
                       PF = 'Physical Functioning', 
                       RF = 'Role Functioning', 
                       EF = 'Emotional Functioning', 
                       CF = 'Cognitive Functioning', 
                       SF = 'Social Functioning ', 
                       FA = 'Fatigue', 
                       NV = 'Nausea and Vomiting', 
                       PA = 'Pain', 
                       DY = 'Dyspnea', 
                       SL = 'Insomnia', 
                       AP = 'Appetite loss', 
                       CO = 'Constipation', 
                       DI = 'Diarrhea', 
                       FI = 'Financial Difficulty')

# export
d1 %>% 
   export("dat/qlq-c30_data_w.csv")

d1 %>% 
   export("dat/qlq-c30_data_w.rds")

# make Long
d_l <- d1 %>% 
   pivot_longer(cols = c(QL:FI),
                names_to = 'variable_name') %>% 
   mutate(variable_label = case_when(
      variable_name == 'QL' ~ 'health and quality of life scale', 
      variable_name == 'PF' ~ 'Physical Functioning', 
      variable_name == 'RF' ~ 'Role Functioning', 
      variable_name == 'EF' ~ 'Emotional Functioning', 
      variable_name == 'CF' ~ 'Cognitive Functioning', 
      variable_name == 'SF' ~ 'Social Functioning ', 
      variable_name == 'FA' ~ 'Fatigue', 
      variable_name == 'NV' ~ 'Nausea and Vomiting', 
      variable_name == 'PA' ~ 'Pain', 
      variable_name == 'DY' ~ 'Dyspnea', 
      variable_name == 'SL' ~ 'Insomnia', 
      variable_name == 'AP' ~ 'Appetite loss', 
      variable_name == 'CO' ~ 'Constipation', 
      variable_name == 'DI' ~ 'Diarrhea', 
      variable_name == 'FI' ~ 'Financial Difficulty') %>% 
         as.character() ,
   .after = variable_name)

# export
d_l %>% 
   export("dat/qlq-c30_data_l.csv")

d_l %>% 
   export("dat/qlq-c30_data_l.rds")

