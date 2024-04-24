GRID_SIZE = 40
SMALL_OFFSET = GRID_SIZE / 3
LARGE_OFFSET = GRID_SIZE / 2

world = {}

beepers = {
    at1_1 = 1,
    at1_2 = 1,
    at1_3 = 1,
    at1_5 = 1,
    at2_3 = 1,
    at3_1 = 1,
    at3_4 = 1,
    at3_5 = 1,
    at3_6 = 1,
    at4_1 = 1,
    at4_3 = 1,
    at5_2 = 1,
    at5_4 = 1,
    at5_5 = 1,
}

walls = {
	northOf2_1 = 1,
	northOf2_2 = 1,
	northOf2_3 = 1,
	northOf2_4 = 1,
	northOf4_1 = 1,
	northOf4_2 = 1,
	northOf4_3 = 1,
	northOf4_4 = 1,
	northOf3_6 = 1,

	eastOf1_2 = 1,
	eastOf1_4 = 1,
	eastOf2_2 = 1,
	eastOf2_4 = 1,
	eastOf3_2 = 1,
	eastOf3_4 = 1,
	eastOf4_2 = 1,
	eastOf4_4 = 1,
 	

}

robot = {
    on=true,
    x=3,
    y=3,
    rot='n',
    beepers=0
}

instructionInterval = 0.2