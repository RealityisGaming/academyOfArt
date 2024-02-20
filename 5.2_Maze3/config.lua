GRID_SIZE = 40
SMALL_OFFSET = GRID_SIZE / 3
LARGE_OFFSET = GRID_SIZE / 2

world = {}

beepers = {
    at5_11 = 1
}

walls = {
    eastOf0_1 = 1,
	eastOf0_2 = 1,
	eastOf0_3 = 1,
	eastOf0_4 = 1,
	eastOf0_5 = 1,
	eastOf0_6 = 1,
	eastOf0_7 = 1,
	eastOf0_8 = 1,
	eastOf0_9 = 1,
	eastOf0_10 = 1,
	eastOf0_11 = 1,
	eastOf1_1 = 1,
	eastOf1_3 = 1,
	eastOf1_9 = 1,
	eastOf2_3 = 1,
	eastOf2_5 = 1,
	eastOf2_8 = 1,
	eastOf2_10 = 1,
	eastOf3_4 = 1,
	eastOf3_7 = 1,
	eastOf4_5 = 1,
	eastOf5_2 = 1,
	eastOf5_3 = 1,
	eastOf5_4 = 1,
	eastOf5_5 = 1,
	eastOf5_6 = 1,
	eastOf5_7 = 1,
	eastOf5_8 = 1,
	eastOf5_9 = 1,
	eastOf5_10 = 1,
	
	northOf1_4 = 1,
	northOf1_8 = 1,
	northOf1_10 = 1,
	northOf1_11 = 1,
	northOf2_1 = 1,
	northOf2_5 = 1,
	northOf2_7 = 1,
	northOf2_11 = 1,
	northOf3_1 = 1,
	northOf3_10 = 1,
	northOf3_11 = 1,
	northOf4_1 = 1,
	northOf4_2 = 1,
	northOf4_3 = 1,
	northOf4_5 = 1,
	northOf4_6 = 1,
	northOf4_7 = 1,
	northOf4_8 = 1,
	northOf4_9 = 1,
	northOf4_11 = 1,
	northOf5_1 = 1,
	northOf5_10 = 1
}

robot = {
    on=true,
    x=1,
    y=1,
    rot='n',
    beepers=0
}

instructionInterval = 0.5