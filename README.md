# kuy-register
Project on cue weighting of different register cues in Kuy, an Austroasiatic language of Thailand, using machine learning methods to test the hypothesis that Kuy speakers who use Thai/Lao (tonal languages, which distinguish words with the use of pitch) more will use pitch more in speaking Kuy, which is a non-tonal language.

In this project, you will find files from my project. The layout is as follows:

## production

- stimuli: this folder contains the images for each stimulus in the experiment
- instructions: this folder contains the images for the instructions for the experiment
- participants: this folder contains an example participant folder, with how the final .pdf presentation file should look, the excel file to mark the order of the stimuli, the order of the stimuli as made from the excel file, and the images resulting from the shell script
- annotation: this folder contains instructions for annotating the files
- changeorder.sh: this is the script that can be run to randomize the stimuli (usage: changeorder.sh [participant #])

## perception

- experiment: this folder contains the experiments presented to the participants--taq-first is the condition in which taq is presented first, while tii-first is the condition in which tii is presented first
- stimuli: this folder contains the files to create the stimuli and the stimuli themselves
  - The stimuli_kuy files include the Praat scripts used to synthesize the taq and tii continua
  - taq and tii contain the synthesized taq and tii tokens and the VoiceSauce analyses, as well as results of the analysis from synthesis_explore.ipynb
  - synthesis_explore.ipynb is the analysis of the acoustic measures for each synthesized token

## publications 
- lingvan_manuscript: preprint for a paper published for Linguistics Vanguard (full print version may be found at https://www.degruyter.com/document/doi/10.1515/lingvan-2021-0042/pdf)
- labphon_manuscript: my manuscript for a paper submmitted to the Journal of the Association for Laboratory Phonology, with the accompanying appendices and supplemental code
