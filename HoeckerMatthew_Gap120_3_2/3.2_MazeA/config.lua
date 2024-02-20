KarlTheRobot = {};

-- The appearance of the output
KarlTheRobot.GRID_SIZE = 40;
KarlTheRobot.SMALL_OFFSET = KarlTheRobot.GRID_SIZE / 3;
KarlTheRobot.LARGE_OFFSET = KarlTheRobot.GRID_SIZE / 2;

-- Simulation speed (lower is faster)
KarlTheRobot.instructionInterval = 0.2;

-- Set true to control Karl in real time.
-- This should only be set in assignments where it's expected.
KarlTheRobot.interactiveMode = false;

-- The robot's initial state
KarlTheRobot.beepers = {
	at1_4 = 1
}

KarlTheRobot.walls = {
	eastOf0_2 = 1,
	eastOf0_3 = 1,
	
	northOf1_1 = 1,
	eastOf1_3 = 1,
	
	northOf2_1 = 1,
	eastOf2_2 = 1,
	northOf2_3 = 1,
	
	northOf3_2 = 1,
	northOf3_3 = 1,
	
	northOf4_1 = 1,
	eastOf4_1 = 1,
	eastOf4_2 = 1,
	eastOf4_3 = 1,
	northOf4_3 = 1
}

KarlTheRobot.robot = {
    x=3,
    y=1,
    rot='n',
    beepers=0
}

function KarlTheRobot.init()

end