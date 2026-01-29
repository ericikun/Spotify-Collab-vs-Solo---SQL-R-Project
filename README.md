# Spotify Collab vs Solo - SQL + R Analysis

## Overview
This project analyzes whether **collaboration (multi-artist) songs** differ from **solo songs** in popularity using a Spotify songs dataset.

Popularity is measured in two ways:
1) **Average log(Streams)** (continuous outcome)  
2) **Probability of charting** (binary outcome: charted vs not charted)

SQL was used for quick data checks (row counts and summary queries), and R was used for cleaning, statistical tests, and visualization.

---

## Research Questions
**Task 1 (Means):** Do collaboration songs have higher **mean log(Streams)** than solo songs?  
**Task 2 (Proportions):** Are collaboration songs **more likely to chart** than solo songs?  
**Task 3 (Power):** If the true charting-rate difference were **10%**, how many songs per group are needed to detect it with **80% chance** at alpha = 0.05?

---

## Dataset
- Unit of analysis: **1 row = 1 song**
- Final sample after cleaning: **952 songs**
- Group sizes:
  - **Collab:** 366
  - **Solo:** 586

### Key columns used
- `artist_count` (given)  
- `streams` (given, originally text)  
- `in_spotify_charts` (given)  

### Variables created in R
- `streams_num`: numeric version of `streams`
- `group`: `"solo"` if artist_count == 1, else `"collab"`
- `log_streams`: log(streams_num)
- `charted`: 1 if in_spotify_charts > 0, else 0


---

## Methods (What I Did)
### Cleaning / Preparation (R)
- Copied the raw dataframe into a working copy (`df2`)
- Converted `streams` from character to numeric
- Removed rows where conversion produced NA (1 row removed)
- Created `group`, `log_streams`, and `charted`

### Statistical Tests (R)
- **Task 1:** Welch two-sample t-test on `log_streams` (one-sided test: collab > solo)
- **Task 2:** Two-sample proportion test on `charted` (one-sided test: collab > solo)
- **Task 3:** Power analysis using `power.prop.test()` assuming a 10% true difference

### Visualization (R)
- Boxplot of `log_streams` by `group`

---

## Results Summary
### Task 1 (log-streams)
- Mean log-streams:
  - collab: **19.2939**
  - solo: **19.6395**
- Welch t-test (alternative: collab > solo):
  - **p-value = 1**
- Conclusion: **No evidence** that collab songs have higher mean log-streams (result went opposite direction: solo higher).

### Task 2 (charted probability)
From the 2x2 table (charted by group):
- Collab: 218/366 = **0.5956**
- Solo: 330/586 = **0.5631**
- Proportion test (alternative: collab > solo):
  - **p-value = 0.179**
- Conclusion: **Fail to reject H0**. No statistically significant evidence that collab songs are more likely to chart.

### Task 3 (power / sample size)
Assume a true difference of 10% in charting rate (p1 = 0.60, p2 = 0.50):
- Required sample size: **n ≈ 388 per group** for 80% detection chance at alpha = 0.05
- Dataset comparison:
  - solo = 586 (enough)
  - collab = 366 (slightly below)

---

## Repository Structure
- `r/` - R scripts for cleaning, inference, and plots  
- `sql/` - SQL scripts (optional)  
- `figures/` - exported plots (PNG)  
- `slides/` - presentation PDF    
- `data/` - dataset location

---

## How to Run (R)
1) Put the CSV in the `data/` folder 
2) Open R/RStudio  
3) Run the analysis script:
- `source("r/analysis.R")`

Outputs:
- statistical test results in console
- plots saved in `figures/` (if script exports them)

---

## Notes / Limitations
- This is an observational dataset: results are **not causal**
- Dataset focuses on popular songs, so results may not generalize to all Spotify tracks
- Slightly underpowered (collab group < 388) for detecting a 10% chart-rate difference

---

## Author
Eric Xing
