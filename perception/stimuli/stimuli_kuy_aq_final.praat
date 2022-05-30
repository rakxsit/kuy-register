#This script synthesizes sound files for a perceptual experiment.
#It creates stimuli with variable pitch, voice qualities and vowel qualities.
# VOT also varies:  one negative value (-50) and a number of possible positive values with 10 ms increments (starting at +10)
# The stimuli correspond to the syllable tu in the two registers.  
# The script also spits out a texgrid designed for measuring vowels in Praatsauce.

# Written by Marc Brunelle in Ho Chi Minh City, 24-04-2019
# Modified by Raksit T. Lau in Bangkok, 08-08-2019

# This version motulates voice quality by varying the open phase and the breathiness.  

form duration and time info
	comment Output directory
	sentence outputdir C:\Users\raksi\OneDrive\Desktop\synthesis\tests_new\taq_measure\
	comment Vowel duration (sec)
	positive vdur 0.2
	comment Depth of the f0 and VQ contrast into the vowel (sec)
	positive regdepth 0.1
	comment Depth of the vowel contrast into the vowel (sec)
	positive vowdepth 0.1
	comment How many f0 steps do you want?
	positive f0steps 5
	comment How many formant steps do you want?
	positive forsteps 1
	comment How many voice quality steps do you want?
	positive vqsteps 5
	comment How many positive VOT steps do you want? (True voicing will also be generated)
	positive aspsteps 1
	comment Power 1? (1 yields the spectral slope values closest to Kuy natural speech for a)
	positive p1 1
	comment Power 2? (10 yields the spectral slope values closest to Kuy natural speech for a)
	positive p2 10
endform

## Create 50 ms of silence
silence = Create Sound from formula... silence 1 0 0.05 44100 0

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

#loop for positive VOT (VOT steps of 25 ms)
for asp from 1 to aspsteps

	vOT = asp * 0.01
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
	Add voicing amplitude point... vend 80
	Add voicing amplitude point... vend+0.05 0
	Add collision phase point... 0.5 0.3
	# Only useful with flat and monotonous f0 as they can produce hisses
	# Add flutter point... 0.5 0.2

	#First three formants are transition loci
	Add formant point... "Normal formant" 1 vbeg 800
	Add formant point... "Normal formant" 1 vtpoint 875
	Add formant point... "Normal formant" 1 vend 900

	Add formant point... "Normal formant" 2 vbeg 1800
	Add formant point... "Normal formant" 3 vbeg 2725

	#F3 after locus
	Add formant point... "Normal formant" 3 vbeg+0.02 2650

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
	Add pitch point... tpoint 135
	
	# 2
	Add pitch point... vend-0.085 140
	Add pitch point... vend-0.029 145
	Add pitch point... vend-0.011 60	

	# 2.5
	#Add pitch point... vend-0.11 140
	#Add pitch point... vend-0.036 145
	#Add pitch point... vend-0.014 60	

	# 3
	#Add pitch point... vend-0.13 140
	#Add pitch point... vend-0.04 145
	#Add pitch point... vend-0.017 60

	# 3.5
	#Add pitch point... vend-0.15 140
	#Add pitch point... vend-0.05 145
	#Add pitch point... vend-0.02 60

	# The oP value here must correspond to the minimum open phase (i.e. the value for modal voice).
	Add open phase point... vbeg-0.000001 0.4
	Add open phase point... tpoint 0.4
	Add breathiness amplitude point... vbeg-0.000001 0
	Add breathiness amplitude point... vend 0

	Add formant point... "Normal formant" 2 vbeg+0.02 1500
	Add formant point... "Normal formant" 2 vend 1500

	#Increments for f0, formants and VQ (The ranges are dependent on the values used in each loop below)
	f1step = 0 / (forsteps - 1)
	f2step = 200 / (forsteps - 1)
	f0step = 30 / (f0steps - 1)
	oPstep = 0.4 / (vqsteps - 1)
	brstep = 60 / (vqsteps - 1)


	# F2 does not covary with F1 as it does in natural speech in register languages, uncomment the F2 lines at the end of loop to enable this
	#f2 = 1500

	#For each vowel, create a F1 continuum around 700

	f1 = 900

	#for f1 from 850 to 950

		#For each vowel, create a pitch continuum around 145Hz
		for f0 from 110 to 140

			Add pitch point... vbeg f0

			#Final glottal stop
			#Add pitch point... vend-0.085 f0
			#Add pitch point... vend-0.03 f0+5
			#Add pitch point... vend-0.001 60

			#Add pitch point... vend-0.15 f0
			#Add pitch point... vend-0.05 f0+5
			#Add pitch point... vend-0.02 60

			#For each vowel, create a voice quality continuum
			# H1-H2 values obstained from open phase range are similar to natural tokens
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
				Rename... taq_'f1$'_'f0$'_'oP$'_'vOT$'
				Write to WAV file... 'outputdir$'taq_'f1$'_'f0$'_'oP$'_'vOT$'_'p1$'_'p2$'.wav
				To TextGrid: "VOWEL LAR", "LAR"
				Insert boundary... 1 vbeg+0.052
				Insert boundary... 1 vend+0.052
				Set interval text... 1 2 v
				Insert point... 2 vbeg+0.052 ov
				Write to text file... 'outputdir$'taq_'f1$'_'f0$'_'oP$'_'vOT$'_'p1$'_'p2$'.TextGrid

				select Sound taq_'f1$'_'f0$'_'oP$'_'vOT$'
				plus TextGrid taq_'f1$'_'f0$'_'oP$'_'vOT$'
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

		Remove pitch points between... vbeg tpoint-0.01

		# Increments: forloop adds 1 automatically
		f0 = f0 + f0step - 1

		endfor
	

	#Remove formant points between... "Normal formant" 1 vbeg vend
	#Remove formant points between... "Normal formant" 2 vbeg tpoint-0.001

	# Increments: forloop adds 1 automatically
	#f1 = f1 + f1step - 1
	#f2 = f2 - f2step - 1
	#f2 = f2 - 1
		
	#endfor

endfor

select KlattGrid Template
Remove

clearinfo
echo All done.