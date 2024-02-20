GRID_SIZE = 40
SMALL_OFFSET = GRID_SIZE / 3
LARGE_OFFSET = GRID_SIZE / 2

world = {}

beepers = {
    at3_5 = 1
}

walls = {
    eastOf0_1 = 1,
	eastOf0_2 = 1,
	eastOf0_3 = 1,
	eastOf0_4 = 1,
	eastOf0_5 = 1,
	eastOf1_1 = 1,
	eastOf2_4 = 1,
	eastOf3_2 = 1,
	eastOf3_3 = 1,
	eastOf3_4 = 1,
	
	northOf1_2 = 1,
	northOf1_4 = 1,
	northOf1_5 = 1,
	northOf2_1 = 1,
	northOf2_2 = 1,
	northOf2_3 = 1,
	northOf2_5 = 1,
	northOf3_1 = 1
}

robot = {
    on=true,
    x=1,
    y=1,
    rot='n',
    beepers=0
}

instructionInterval = 0.2