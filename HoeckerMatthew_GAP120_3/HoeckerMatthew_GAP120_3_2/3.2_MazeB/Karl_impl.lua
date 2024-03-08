require "config"

-- You are not expected to use or modify anything in this file!

KarlTheRobot.dimensions = {
    width=0,
    height=0
};

-- Where Karl wants to be after the current move
KarlTheRobot.destination = {
    x=KarlTheRobot.robot.x,
    y=KarlTheRobot.robot.y
};

-- The simulation has begun
KarlTheRobot.hasStarted = true;

-- The robot is turned on
KarlTheRobot.doRun = true;

-- Reference to any instruction currently being carried out
KarlTheRobot.currentInstruction = nil;

-- The time when another instruction can run
KarlTheRobot.nextInstructionTime = -1;

-- Message queue
KarlTheRobot.loggedMessages = {};

-- Reference to main when it's run as a coroutine
-- in non-interactive mode
KarlTheRobot.mainCoroutine = nil;

---------------------------------------------
-- Entry point for the LOVE engine.
--  arg: receives any commandline arguments
---------------------------------------------
function love.load(arg)
    if arg[#arg] == "-debug"
    then
      require("mobdebug").start();
      require("mobdebug").coro();
    end

    KarlTheRobot.dimensions.width = love.graphics.getWidth() / KarlTheRobot.GRID_SIZE;
    KarlTheRobot.dimensions.height = love.graphics.getHeight() / KarlTheRobot.GRID_SIZE;

    if(KarlTheRobot.init ~= nil)
    then
        KarlTheRobot.init();
    end

    if(not KarlTheRobot.interactiveMode)
    then
        KarlTheRobot.hasStarted = false;
        KarlTheRobot.mainCoroutine = coroutine.create(main);
    end
end

---------------------------------------------
-- Inverts y from top-down to bottom-up for
-- the purposes of rendering.
---------------------------------------------
function invertY(y)
    return (KarlTheRobot.dimensions.height - y);
end

---------------------------------------------
-- Renders the world.
---------------------------------------------
function love.draw()

    -- vertical grid lines
    for i=0, KarlTheRobot.dimensions.width
    do
        local pos = i * KarlTheRobot.GRID_SIZE;
        love.graphics.line(pos, 0, pos, love.graphics.getHeight());
    end

    -- horizontal grid lines
    for i=0, KarlTheRobot.dimensions.height
    do
        local pos = i * KarlTheRobot.GRID_SIZE;
        love.graphics.line(0, pos, love.graphics.getWidth(), pos);
    end

    -- beepers
    for y=0, KarlTheRobot.dimensions.height
    do
        for x=0, KarlTheRobot.dimensions.width
        do
            local key = "at" .. x .. '_' .. y;
            if(KarlTheRobot.beepers[key] ~= nil and KarlTheRobot.beepers[key] > 0)
            then
                local pos = {
                  x = x * KarlTheRobot.GRID_SIZE,
                  y = invertY(y) * KarlTheRobot.GRID_SIZE
                };
                
                love.graphics.circle("fill", pos.x, pos.y, 5);
            end
        end
    end

    -- wall color
    love.graphics.setColor(0, 1, 1, 1);

    -- vertical KarlTheRobot.walls
    for y=0, KarlTheRobot.dimensions.height
    do
        for x=0, KarlTheRobot.dimensions.width
        do
            local key = "eastOf" .. x .. '_' .. y;
            if(KarlTheRobot.walls[key] == 1)
            then
                local pos = {
                  x = (x + 0.5) * KarlTheRobot.GRID_SIZE,
                  y = invertY(y + 0.5) * KarlTheRobot.GRID_SIZE
                };
                
                love.graphics.rectangle("fill", pos.x - 1, pos.y, 3, KarlTheRobot.GRID_SIZE);
            end
        end
    end

    -- horizontal KarlTheRobot.walls
    for y=1, KarlTheRobot.dimensions.height
    do
        for x=1, KarlTheRobot.dimensions.width
        do
            local key = "northOf" .. x .. '_' .. y;
            if(KarlTheRobot.walls[key] == 1)
            then
                local pos = {
                  x = (x - 0.5) * KarlTheRobot.GRID_SIZE,
                  y = invertY(y + 0.5) * KarlTheRobot.GRID_SIZE
                };
                
                love.graphics.rectangle("fill", pos.x - 1, pos.y, KarlTheRobot.GRID_SIZE, 3);
            end
        end
    end

    -- reset color
    love.graphics.setColor(1, 1, 1, 1);

    -- robot's rendered position
    local robotPos = {
        x= KarlTheRobot.robot.x * KarlTheRobot.GRID_SIZE,
        y= invertY(KarlTheRobot.robot.y) * KarlTheRobot.GRID_SIZE
    };
    
    -- vertices of the robot sprite
    -- expected in the format x,y,x,y,etc
    local vertices = {};

    -- orient Karl based on rotation
    if(KarlTheRobot.robot.rot == 'n')
    then
        vertices = {
            robotPos.x - KarlTheRobot.SMALL_OFFSET, robotPos.y + KarlTheRobot.SMALL_OFFSET,
            robotPos.x + KarlTheRobot.SMALL_OFFSET, robotPos.y + KarlTheRobot.SMALL_OFFSET,
            robotPos.x, robotPos.y - KarlTheRobot.LARGE_OFFSET
        };
    elseif(KarlTheRobot.robot.rot == 's')
    then
        vertices = {
            robotPos.x - KarlTheRobot.SMALL_OFFSET, robotPos.y - KarlTheRobot.SMALL_OFFSET,
            robotPos.x + KarlTheRobot.SMALL_OFFSET, robotPos.y - KarlTheRobot.SMALL_OFFSET,
            robotPos.x, robotPos.y + KarlTheRobot.LARGE_OFFSET
        };
    elseif(KarlTheRobot.robot.rot == 'w')
    then
        vertices = {
            robotPos.x + KarlTheRobot.SMALL_OFFSET, robotPos.y - KarlTheRobot.SMALL_OFFSET, 
            robotPos.x + KarlTheRobot.SMALL_OFFSET, robotPos.y + KarlTheRobot.SMALL_OFFSET, 
            robotPos.x - KarlTheRobot.LARGE_OFFSET, robotPos.y
        };
    elseif(KarlTheRobot.robot.rot == 'e')
    then
        vertices = {
            robotPos.x - KarlTheRobot.SMALL_OFFSET, robotPos.y - KarlTheRobot.SMALL_OFFSET, 
            robotPos.x - KarlTheRobot.SMALL_OFFSET, robotPos.y + KarlTheRobot.SMALL_OFFSET, 
            robotPos.x + KarlTheRobot.LARGE_OFFSET,robotPos.y
        };
    end

    -- draws Karl
    love.graphics.polygon("fill", vertices);

    -- logging
    while(#KarlTheRobot.loggedMessages > 20)
    do
        table.remove(KarlTheRobot.loggedMessages, 1);
    end

    for i=1, #KarlTheRobot.loggedMessages
    do
        love.graphics.print(KarlTheRobot.loggedMessages[i], 0, i*20);
    end
    
    -- startup message
    if(KarlTheRobot.hasStarted == false)
    then
      love.graphics.print("Press any key to begin simulation", 10, 10, 0, 2, 2);
    end
    
end

---------------------------------------------
-- Called when any key is pressed.
---------------------------------------------
function love.keypressed(key, scanCode, isRepeat)
  KarlTheRobot.hasStarted = true;
end

---------------------------------------------
-- Called once per frame.
--  deltaTime: #seconds since last frame.
---------------------------------------------
function love.update(deltaTime)

  if(not KarlTheRobot.doRun)
  then
    return;
  end

  if(KarlTheRobot.interactiveMode)
  then
      interactiveUpdate();
  else
      nonInteractiveUpdate();
  end  
end

---------------------------------------------
-- Update loop for interactive mode.
---------------------------------------------
function interactiveUpdate()
  main();
  
  local delta = {
      x = KarlTheRobot.destination.x - KarlTheRobot.robot.x,
      y = KarlTheRobot.destination.y - KarlTheRobot.robot.y
    };
  
  if((delta.x ~= 0) or (delta.y ~= 0))
  then    
    
    KarlTheRobot.robot.x = KarlTheRobot.robot.x + delta.x * 0.1;
    KarlTheRobot.robot.y = KarlTheRobot.robot.y + delta.y * 0.1;
    
    if(math.abs(delta.x) < 0.1)
    then
        KarlTheRobot.robot.x = KarlTheRobot.destination.x;
    end
    
    if(math.abs(delta.y) < 0.1)
    then
        KarlTheRobot.robot.y = KarlTheRobot.destination.y;
    end
    
    KarlTheRobot.nextInstructionTime = love.timer.getTime() + 0.1;
    
  end
end

---------------------------------------------
-- Update loop for non-interactive mode.
---------------------------------------------
function nonInteractiveUpdate()
  
  if(not KarlTheRobot.doRun or not KarlTheRobot.hasStarted)
  then
      return;
  end
  
  local delta = {
      x = KarlTheRobot.destination.x - KarlTheRobot.robot.x,
      y = KarlTheRobot.destination.y - KarlTheRobot.robot.y
    };
    
  if((delta.x ~= 0) or (delta.y ~= 0))
	then    
    
    KarlTheRobot.robot.x = KarlTheRobot.robot.x + delta.x * 0.1;
    KarlTheRobot.robot.y = KarlTheRobot.robot.y + delta.y * 0.1;
    
    if(math.abs(delta.x) < 0.1)
    then
        KarlTheRobot.robot.x = KarlTheRobot.destination.x;
    end
    
    if(math.abs(delta.y) < 0.1)
    then
        KarlTheRobot.robot.y = KarlTheRobot.destination.y;
    end
    
  elseif(love.timer.getTime() > KarlTheRobot.nextInstructionTime)
  then
    KarlTheRobot.nextInstructionTime = love.timer.getTime() + KarlTheRobot.instructionInterval;
    coroutine.resume(KarlTheRobot.mainCoroutine);
  end
  
end

function KarlTheRobot.doMove()

  if(KarlTheRobot.interactiveMode == true)
  then
    if(love.timer.getTime() < KarlTheRobot.nextInstructionTime)
    then
      return;
    end
  end

  local delta = { x=0, y=0 }

  if KarlTheRobot.robot.rot == 'n' then
      delta.y = 1
  elseif KarlTheRobot.robot.rot == 's' then
      delta.y = -1
  elseif KarlTheRobot.robot.rot == 'w' then
      delta.x = -1
  elseif KarlTheRobot.robot.rot == 'e' then
      delta.x = 1
  else
      love.errorhandler("invalid rotation")
  end

  KarlTheRobot.destination = { x=KarlTheRobot.robot.x + delta.x, y=KarlTheRobot.robot.y + delta.y };
  --KarlTheRobot.nextInstructionTime = love.timer.getTime() + KarlTheRobot.instructionInterval;

  if KarlTheRobot.isWall(KarlTheRobot.robot.x, KarlTheRobot.robot.y, KarlTheRobot.robot.rot) then
      log("ERROR SHUTOFF: Attempting to walk into a wall.")
      KarlTheRobot.doTurnOff();
  end
end

KarlTheRobot.lastLeft = 0;
KarlTheRobot.leftsThisFrame = 0;

function KarlTheRobot.doTurnLeft()
  
  local now = love.timer.getTime();
  local timeDiff = now - KarlTheRobot.lastLeft;
  
  if(KarlTheRobot.interactiveMode == true)
  then
    local sameFrame = (timeDiff < 0.001);
    if(not(   (sameFrame and KarlTheRobot.leftsThisFrame < 3) 
          or  (now >= KarlTheRobot.nextInstructionTime)       )  )
    then
      return;
    end
  end
  
  if(now >= KarlTheRobot.nextInstructionTime)
  then
      KarlTheRobot.leftsThisFrame = 0;
  end
  
  KarlTheRobot.robot.rot = KarlTheRobot.rotateLeft(KarlTheRobot.robot.rot);
  --KarlTheRobot.nextInstructionTime = love.timer.getTime();
  KarlTheRobot.lastLeft = now;
  KarlTheRobot.leftsThisFrame = KarlTheRobot.leftsThisFrame + 1;
  
end

-- unused
--[[function KarlTheRobot.doTurnRight()
  
    --KarlTheRobot.currentInstruction = turnright;  -- doesn't exist
  
    if(love.timer.getTime() > KarlTheRobot.nextInstructionTime)
    then
        KarlTheRobot.robot.rot = KarlTheRobot.rotateRight(KarlTheRobot.robot.rot);
        KarlTheRobot.nextInstructionTime = love.timer.getTime() + 0.1;
    end
end]]

function KarlTheRobot.doTurnOff()
      KarlTheRobot.doRun = false;
end

function KarlTheRobot.doPickBeeper()
  
  if(KarlTheRobot.interactiveMode == true)
  then
    if(love.timer.getTime() < KarlTheRobot.nextInstructionTime)
    then
      return;
    end
  end
  
  if KarlTheRobot.isBeeperAt(KarlTheRobot.robot.x, KarlTheRobot.robot.y) then
      KarlTheRobot.robot.beepers = KarlTheRobot.robot.beepers + 1
      local key = "at" .. KarlTheRobot.robot.x .. '_' .. KarlTheRobot.robot.y
      KarlTheRobot.beepers[key] = KarlTheRobot.beepers[key] - 1
      log("beepers " .. key .. " is now " .. KarlTheRobot.beepers[key])
  else
      log("ERROR SHUTOFF: pickbeeper called with no beeper on ground")
      KarlTheRobot.doTurnOff();
  end
  
  KarlTheRobot.nextInstructionTime = love.timer.getTime() + 0.1;
  
end

function KarlTheRobot.doPutBeeper()
  
  if(KarlTheRobot.interactiveMode == true)
  then
    if(love.timer.getTime() < KarlTheRobot.nextInstructionTime)
    then
      return;
    end
  end
    
  if KarlTheRobot.robot.beepers <= 0 then
      log("ERROR SHUTOFF: putbeeper called with no beeper in bag")
      KarlTheRobot.doTurnOff();
      return
  end

  KarlTheRobot.robot.beepers = KarlTheRobot.robot.beepers - 1

  local key = "at" .. KarlTheRobot.robot.x .. '_' .. KarlTheRobot.robot.y
  if KarlTheRobot.beepers[key] == nil then
      KarlTheRobot.beepers[key] = 1
  else
      KarlTheRobot.beepers[key] = KarlTheRobot.beepers[key] + 1
  end

  log("beepers " .. key .. " is now " .. KarlTheRobot.beepers[key])
  
  KarlTheRobot.nextInstructionTime = love.timer.getTime() + 0.1;
end

function KarlTheRobot.doToggleWallNorthOf(x, y)
  
  local wallString = "northOf" .. x .. '_' .. y;
  if(KarlTheRobot.walls[wallString] == nil)
  then
    KarlTheRobot.walls[wallString] = 1;
  else
    KarlTheRobot.walls[wallString] = nil;
  end
  
end

function KarlTheRobot.doToggleWallEastOf(x, y)
  
  local wallString = "eastOf" .. x .. '_' .. y;
  if(KarlTheRobot.walls[wallString] == nil)
  then
    KarlTheRobot.walls[wallString] = 1;
  else
    KarlTheRobot.walls[wallString] = nil;
  end
  
end

function KarlTheRobot.isWall(x, y, dir)
    if dir == 'n' then
        wallString = "northOf" .. x .. '_' .. y
    elseif dir == 's' then
        wallString = "northOf" .. x .. '_' .. (y - 1)
    elseif dir == 'w' then
        wallString = "eastOf" .. (x - 1) .. '_' .. y
    else
        wallString = "eastOf" .. x .. '_' .. y
    end

    return KarlTheRobot.walls[wallString] == 1
end

function KarlTheRobot.rotateLeft(dir)
    if dir == 'n' then
        return 'w'
    elseif dir == 'w' then
        return 's'
    elseif dir == 's' then
        return 'e'
    elseif dir == 'e' then
        return 'n'
    end
end

function KarlTheRobot.rotateRight(dir)
    if dir == 'n' then
        return 'e'
    elseif dir == 'w' then
        return 'n'
    elseif dir == 's' then
        return 'w'
    elseif dir == 'e' then
        return 's'
    end
end

function KarlTheRobot.isBeeperAt(x, y)
    local key = "at" .. x .. '_' .. y
    return KarlTheRobot.beepers[key] ~= nil and KarlTheRobot.beepers[key] > 0
end

function KarlTheRobot.doLog(message)
    table.insert(KarlTheRobot.loggedMessages, message);
end

function KarlTheRobot.getRobotPosition()
  return { KarlTheRobot.robot.x, KarlTheRobot.robot.y };
end