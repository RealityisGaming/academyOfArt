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
    at3_2 = 1
};

KarlTheRobot.walls = {

};

KarlTheRobot.robot = {
    x=3,
    y=1,
    rot='n',
    beepers = 0
};

function KarlTheRobot.init()
    math.randomseed(os.time())
    for y=2, 4 do
        for x=1, 3 do
            local random = math.random(2)
            if random == 1 then
                local key = "at" .. x .. '_' .. y
                KarlTheRobot.beepers[key] = 1
            end
        end
    end
end