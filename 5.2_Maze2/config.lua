GRID_SIZE = 40
SMALL_OFFSET = GRID_SIZE / 3
LARGE_OFFSET = GRID_SIZE / 2

world = {}

beepers = {
    at4_8 = 1
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
	eastOf1_1 = 1,
	eastOf1_2 = 1,
	eastOf2_4 = 1,
	eastOf2_6 = 1,
	eastOf2_8 = 1,
	eastOf3_4 = 1,
	eastOf3_5 = 1,
	eastOf3_7 = 1,
	eastOf4_2 = 1,
	eastOf4_3 = 1,
	eastOf4_4 = 1,
	eastOf4_5 = 1,
	eastOf4_6 = 1,
	eastOf4_7 = 1,
	
	northOf1_3 = 1,
	northOf1_6 = 1,
	northOf1_8 = 1,
	northOf2_1 = 1,
	northOf2_4 = 1,
	northOf2_5 = 1,
	northOf2_7 = 1,
	northOf2_8 = 1,
	northOf3_1 = 1,
	northOf3_2 = 1,
	northOf3_6 = 1,
	northOf3_8 = 1,
	northOf4_1 = 1,
	northOf4_7 = 1
}

robot = {
    on=true,
    x=1,
    y=1,
    rot='n',
    beepers=0
}

instructionInterval = 0.2