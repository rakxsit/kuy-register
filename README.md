# kuy-register
Project on cue weighting of different register cues in Kuy, an Austroasiatic language of Thailand. One published paper that came out of this project may be found at: https://www.degruyter.com/document/doi/10.1515/lingvan-2021-0042/pdf . A manuscript of another paper that is under revision may be found in the production > labphon_manuscript .

In this project, you will find files from my project. The layout is as follows

## production

### experiment

This folder contains the files for the experiment

#### stimuli

This folder contains the images for each stimulus in the experiment

#### instructions

This folder contains the images for the instructions for the experiment

#### participants

This folder contains an example participant folder, with how the final .pdf presentation file should look, the excel file to mark the order of the stimuli, the order of the stimuli as made from the excel file, and the images resulting from the shell script

#### changeorder.sh

This is the script that can be run to randomize the stimuli

### labphon_manuscript

This is my manuscript for a paper submmitted to the Journal of the Association for Laboratory Phonology, with the accompanying appendices

### supplementary_code

This folder contains the supplementary code, which includes the output of the VoiceSauce analysis of the production results, and the analyses carried out on it

### annnotation

This folder contains the workflows for organizing and annotating the files for each participant

## perception

### experiment

This folder contains the experiments presented to the participants--taq-first is the condition in which taq is presented first, while tii-first is the condition in which tii is presented first

### stimuli

- The stimuli_kuy files include the Praat scripts used to synthesize the taq and tii continua
- taq and tii contain the synthesized taq and tii tokens and the VoiceSauce analyses, as well as results of the analysis from synthesis_explore.ipynb
- synthesis_explore.ipynb is the analysis of the acoustic measures for each synthesized token
