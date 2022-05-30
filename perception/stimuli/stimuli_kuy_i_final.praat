#This script synthesizes sound files for a perceptual experiment.
#It creates stimuli with variable pitch, voice qualities and vowel qualities.
# VOT also varies:  one negative value (-50) and a number of possible positive values with 10 ms increments (starting at +10)
# The stimuli correspond to the syllable tu in the two registers.  
# The script also spits out a texgrid designed for measuring vowels in Praatsauce.

# Written by Marc Brunelle in Ho Chi Minh City, 24-04-2019
# Modified by Raksit T. Lau in Bangkok, 30.07.2019

# This version modulates voice quality by varying the open phase and the breathiness.  

# We need to change the /u/ formants to /i/
# We also need to not have voicing

form duration and time info
	comment Output directory
	sentence outputdir C:\Users\raksi\OneDrive\Desktop\synthesis\tests_new\asp_tests\tii_\
	comment Vowel duration (sec) # based on average (371.75 for modal, 372.57 for breathy)
	positive vdur 0.4
	comment Depth of the f0 and VQ contrast into the vowel (sec)
	positive regdepth 0.2
	comment Depth of the vowel contrast into the vowel (sec)
	positive vowdepth 0.2
	comment How many f0 steps do you want?
	positive f0steps 5
	comment How many formant steps do you want?
	positive forsteps 1
	comment How many voice quality steps do you want?
	positive vqsteps 5

	# THIS PART NEEDS TO BE CHANGED SINCE WE DONT WANT TRUE VOICING
	comment How many positive VOT steps do you want? (True voicing will also be generated)
	positive aspsteps 1

	# THESE NEED TO BE CHANGED TO MATCH KUY
	comment Power 1? (1 yields the spectral slope values closest to Kuy natural speech for i)
	positive p1 1
	comment Power 2? (3 yields the spectral slope values closest to Kuy natural speech for i)
	positive p2 3
endform

## Create 50 ms of silence
silence = Create Sound from formula... silence 1 0 0.07 44100 0

####
## WE DONT NEED THIS PART SINCE NO VOICING
####

##Create voice bar (stolen from Jessamyn Schertz: klatt_synthesize_vot_f0_series.praat)
#Create KlattGrid... negVOT 0 0.07 2 0 0 1 0 0 0
#Add oral formant frequency point... 1 0 100
#Add oral formant bandwidth point... 1 0 150
#Add pitch point... 0 95
#Add voicing amplitude point... 0 50
# Only useful with flat and monotonous f0 as they can produce hisses
# Add flutter point... 0 0.2
#To Sound
#Scale intensity... 50

####
####

## Create burst (based on Ulrich Reubold)
Create KlattGrid... burst 0 0.002 2 0 0 2 0 0 0
Add voicing amplitude point... 0 0
Add pitch point... 0 0
Add frication amplitude point... 0 0
Add frication amplitude point... 0.001 25
Add frication amplitude point... 0.002 0
Add frication bypass point... 0 0
Add frication bypass point... 0.001 25
Add frication bypass point... 0.002 0
# Jassem (1962): Dentals have two bursts at 1-2.5 kH and 4-5kHz, latter is strong.
Add frication formant frequency point... 1 0.001 1750
Add frication formant amplitude point... 1 0.001 35
Add frication formant bandwidth point... 1 0.001 100
Add frication formant frequency point... 2 0.001 4500
Add frication formant amplitude point... 2 0.001 35
Add frication formant bandwidth point... 2 0.001 100
To Sound
Scale intensity... 40

rel = 0

#loop for positive VOT (VOT steps of 10 ms)
for asp from 1 to aspsteps

	vOT = asp * 0.015
	vbeg = rel + vOT

	vend = vbeg + vdur
	tpoint = vbeg + regdepth
	vtpoint = vbeg + vowdepth
	sounddur = vend + 0.05

	##Generate a template Klattgrid that will then be modified to create open vowel stimuli
	Create KlattGrid...  Template 0 sounddur 10 1 1 10 1 1 1

	#This changes the overall spectral slope of the sound
	Add power1 point... 0 p1
	Add power2 point... 0 p2

	#add aspiration noise
	Add aspiration amplitude point... rel 40
	Add aspiration amplitude point... vbeg-0.000001 40
	Add aspiration amplitude point... vbeg 0

	#add phonation. For some reason, a rising amplitude at the beginning of vowel sounds more dental.
	Add voicing amplitude point... vbeg-0.000001 0
	Add voicing amplitude point... vbeg 60
	Add voicing amplitude point... vbeg+0.02 80
	# Added gradually dropping amplitude points to make it sound less like there is coda t
	Add voicing amplitude point... vend-0.04 80
	Add voicing amplitude point... vend-0.02 70
	Add voicing amplitude point... vend 50
	Add voicing amplitude point... 	vend+0.05 0
	Add collision phase point... 0.5 0.3
	# Only useful with flat and monotonous f0 as they can produce hisses
	# Add flutter point... 0.5 0.2

	#First three formants are transition loci
	# Modal = 413.71, Breathy = 323.92
	#Add formant point... "Normal formant" 1 vbeg 350

	# Take F2 value between modal and breathy averages for first timepoint
	# Modal = 1987.22, Breathy = 2123.01
	Add formant point... "Normal formant" 2 vbeg 2050

	# F3 value between
	# Modal = 2858.89, Breathy = 2830.45
	Add formant point... "Normal formant" 3 vbeg 2850

	#F3 after locus
	# Modal = 3292.43, Breathy = 3321.07
	#Add formant point... "Normal formant" 3 vbeg+0.02 3300

	#Other formants do not change
	Add formant point... "Normal formant" 4 0.5 3800
	Add formant point... "Normal formant" 5 0.5 4200
	Add formant point... "Normal formant" 6 0.5 5200
	Add formant point... "Normal formant" 7 0.5 6200
	Add formant point... "Normal formant" 8 0.5 7200
	Add formant point... "Normal formant" 9 0.5 8200
	Add formant point... "Normal formant" 10 0.5 9200
	Add bandwidth point... "Normal formant" 1 0.5 90
	Add bandwidth point... "Normal formant" 2 0.5 110 
	Add bandwidth point... "Normal formant" 3 0.5 170 
	Add bandwidth point... "Normal formant" 4 0.5 250
	Add bandwidth point... "Normal formant" 5 0.5 300
	Add bandwidth point... "Normal formant" 6 0.5 350
	Add bandwidth point... "Normal formant" 7 0.5 400
	Add bandwidth point... "Normal formant" 8 0.5 450
	Add bandwidth point... "Normal formant" 9 0.5 500
	Add bandwidth point... "Normal formant" 10 0.5 550

	#Fixed values at specific points for f0, breathiness and formants
	Add pitch point... tpoint 125

	### PITCH DROP
	Add pitch point... vend 100

	#Final glottal stop
#	Add pitch point... vend-0.15 140
#	Add pitch point... vend-0.05 160
#	Add pitch point... vend-0.02 60
	# The oP value at tpoint must correspond to the minimum open phase (i.e. the value for modal voice).
	Add open phase point... vbeg-0.000001 0.4
	Add open phase point... tpoint 0.4
	Add open phase point... vend 0.5
	Add breathiness amplitude point... vbeg-0.000001 0
	Add breathiness amplitude point... vend 0
#	Add formant point... "Normal formant" 1 vtpoint 400
#	Add formant point... "Normal formant" 1 vend 400

	# Changed here
	Add formant point... "Normal formant" 2 vbeg 2050
	Add formant point... "Normal formant" 2 vdur*0.25 2350
	Add formant point... "Normal formant" 2 vdur*0.75 2350
	#Add formant point... "Normal formant" 2 vend 2050

	Add formant point... "Normal formant" 3 vdur*0.25 3200
	Add formant point... "Normal formant" 3 vdur*0.5 3300
	Add formant point... "Normal formant" 3 vdur*0.75 3200
	#Add formant point... "Normal formant" 3 vend 2800

	#Increments for f0, formants and VQ (The ranges are dependent on the values used in each loop below)
	f1step = 100 / (forsteps - 1)
	f2step = 200 / (forsteps - 1)
	f0step = 30 / (f0steps - 1)
	oPstep = 0.4 / (vqsteps - 1)
	brstep = 60 / (vqsteps - 1)


	# F2 does not covary with F1 as it does in natural speech in register languages, uncomment the F2 lines at the end of loop to enable this
	# Average from timepoints 5 to 15
	# Modal = 2447.44, Breathy = 2348.97
	f2 = 2050

	#####
	### ADJUST THIS PART TO KUY VALUES
	#####
	
	#For each vowel, create a F1 continuum around 450
	# Male: 300 to 400, Female: 450 - 550
	#for f1 from 350 to 350
	f1 = 350	
		
	Add formant point... "Normal formant" 1 vbeg f1+25
	#Add formant point... "Normal formant" 2 vbeg+0.02 f2

	Add formant point... "Normal formant" 1 vtpoint f1-25

	Add formant point... "Normal formant" 1 vend f1+75

	#For each vowel, create a pitch continuum around 145Hz
	# Male: 120 - 150, Female: 200 - 230
	for f0 from 110 to 140

		Add pitch point... vbeg f0
		# Add pitch point... vdur*0.75 f0

		#For each vowel, create a voice quality continuum
		# H1-H2 values obtained from open phase range are similar to natural tokens
		# No need to play with the spectral tilt parameters (we cannot make it negative)
		# The distance in dB between H1-A1 and H1-A3 is similar to natural tokens,
		# but their absolute values are 5-10dB higher than those of average speakers
		# This is caused by the dramatic default spectral slope in Klatt.  No solution so far.
		# Besides spectral slope, breathiness amplitude is added to the tokens to make them more natural sounding.
				
		br = 0
	
		for oP from 0.3 to 0.71
			Add open phase point... vbeg oP
			Add breathiness amplitude point... vbeg br
			# Breathiness amplitude does not slowly slope down as such a slope is inaudible
			Add breathiness amplitude point... tpoint br
			
			f1$ = fixed$(f1,0)
			f0$ = fixed$(f0,0)
			oP2 = oP*100
			oP$ = fixed$(oP2, 0)
			vOT2 = vOT*1000
			vOT$ = fixed$(vOT2,0)
			p1$ = fixed$(p1,0)
			p2$ = fixed$(p2,0)

			To Sound
			select Sound Template
			plus Sound silence
			plus Sound burst
			Concatenate
			Rename... tii_'f1$'_'f0$'_'oP$'_'vOT$'
			Write to WAV file... 'outputdir$'tii_'f1$'_'f0$'_'oP$'_'vOT$'_'p1$'_'p2$'.wav
			To TextGrid: "VOWEL LAR", "LAR"
			Insert boundary... 1 vbeg+0.072
			Insert boundary... 1 vend+0.072
			Set interval text... 1 2 v
			Insert point... 2 vbeg+0.072 ov
			Write to text file... 'outputdir$'tii_'f1$'_'f0$'_'oP$'_'vOT$'_'p1$'_'p2$'.TextGrid

			select Sound tii_'f1$'_'f0$'_'oP$'_'vOT$'
			plus TextGrid tii_'f1$'_'f0$'_'oP$'_'vOT$'
			plus Sound Template
			Remove

			select KlattGrid Template
			Remove open phase points between... vbeg tpoint-0.001
			Remove breathiness amplitude points between... vbeg tpoint

			# Increments: forloop adds 1 automatically
			oP = oP + oPstep - 1
			# br is not in a loop so no increment
			br = br + brstep
 
		endfor

	Remove pitch points between... 0 tpoint-0.01

	# Increments: forloop adds 1 automatically
	f0 = f0 + f0step - 1	

	#Remove formant points between... "Normal formant" 1 vbeg vend
	#Remove formant points between... "Normal formant" 2 vbeg+0.001 tpoint-0.001

	# Increments: forloop adds 1 automatically
	#f1 = f1 + f1step - 1
	#f2 = f2 - f2step - 1
	#f2 = f2 - 1
		
	endfor

endfor

select KlattGrid Template
Remove

clearinfo
echo All done.