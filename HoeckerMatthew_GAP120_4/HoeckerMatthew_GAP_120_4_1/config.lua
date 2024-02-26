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
	at1_2 = 1,
	at1_3 = 1,
	at1_4 = 1,
  
	at2_1 = 1,
	at2_4 = 1,
  
  at3_1 = 1,
	at3_4 = 1,
  
  at4_1 = 1,
  at4_2 = 1,
	at4_3 = 1,
	at4_4 = 1
}

KarlTheRobot.walls = {
	eastOf1_1 = 1,
  eastOf1_2 = 1,
  eastOf1_3 = 1
}

KarlTheRobot.robot = {
    x=1,
    y=1,
    rot='n',
    beepers=0
}

function KarlTheRobot.init()

end