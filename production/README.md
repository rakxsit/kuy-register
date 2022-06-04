Steps to randomize:
1) Go to participant excel sheet (example_participant > ex.xlsx)
	a. Create column (randomized numbers in the example file) and use random()
	b. Sort by the randomized orders to get different orders for practice round and real rounds
	c. Numbers
		- Practice round should go from 5-62
		- Real1 should go from 64-121
		- Real2 should go from 122-179
		- Real3 should go from 180-237
		- Real4 should go from 239-296
		- Real5 should go from 297-354
	d. Create new columns and combine number with file names (=CELL&""&CELL)
2) Copy the Practice and Real# columns into different text files with orders based on IMAGE name for each round 
3) Put into folder called example_participant > orders
4) Run changeorder.sh with participant number as argument

	Example usage: bash changeorder.sh 1

	(will yield an "images" folder with )

	a. It will put the pictures in the designated order
	b. Then will add instruction pages
	c. These images can be used for the experiment