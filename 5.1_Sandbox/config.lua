GRID_SIZE = 40
SMALL_OFFSET = GRID_SIZE / 3
LARGE_OFFSET = GRID_SIZE / 2

world = {}

beepers = {
	-- at1_1 = 1,
	-- at1_3 = 1,
	-- at1_4 = 1,

	-- at2_1 = 1,
	-- at2_4 = 1,


  -- at3_1 = 1,
  -- at3_3 =1,
	-- at3_4 = 1,


  -- at4_1 = 1,
  -- at4_2 = 1,
	-- at4_3 = 1,
	-- at4_4 = 1

}

walls = {
	-- eastOf1_1 = 1,
  -- eastOf1_2 = 1,
  -- eastOf1_3 = 1

}

robot = {
    on=true,
    x=2,
    y=2,
    rot='e',
    beepers=0
}

instructionInterval = 0.5

interactiveMode = false;

function init()

end