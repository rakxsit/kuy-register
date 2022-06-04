* NOTE: I have included all the output files but if the reader wishes to reproduce this, they may delete all the output files below and rerun the scripts. Note that the scripts must be run in order as each will create a dataset in 0_data to be read into the following script.

Contents: 

- 0_data : Contains dataframes
	. output.txt : raw output from VoiceSauce
	. kuy-production-dem.csv : relevant demographic data for participants (factors put into the PCA are not included for anonymity reasons)
	. kuy-production-stimuli.csv : stimuli from production study

- 1_cleanup : Run this jupyter notebook first to clean up the data

	============
	OUTPUT FILES
	============

	- 0_data/kuy-production-clean.csv	: cleaned output data
	- 1_cleanup/vot.png : graph of VOT by consonant + voice quality

- 2_lmer-analysis : Run this R markdown script to carry out the linear mixed effects regression model

	============
	OUTPUT FILES
	============

	- UPDATES 0_data/kuy-production-dem.csv with PCA results for voice quality
	- kuy-production-lmer-analysis.html : knit HTML file with code and results
	- kuy-production-lmer-analysis_cache : cache to save results in .Rmd file
	- kuy-production-lmer-analysis_files : files from .Rmd file
	- .tiff, .eps, .pdf files: 

- 3_sumstats : Run this jupyter notebook to carry out summary statistics for the dataset

	============
	OUTPUT FILES
	============

	- vdur.png : vowel duration by vowel quality
	- vowelf0.png : f0 trajectories by vowel quality
	- vowelF1.png : F1 trajectories by vowel quality
	- vowelH1H2c.png : H1*-H2* trajectories by vowel quality

- 4_lda-analysis : Run this jupyter notebook to carry out the Linear Discriminant Analysis

	============
	OUTPUT FILES
	============

	- 0_data/kuy-production-lda.csv : LDA results
	- [measure]-TLE.png and [measure]-away.png files for each measure : shows correlation between each measure and TLE/away
	- corr-f0-[measure]-TLE.png and -away.png files for each measure : shows correlation between each measure and another, with color indicating TLE or away
	- age-tle-f.png : shows correlation between Age and f0 LDA accuracy, with color indicating TLE