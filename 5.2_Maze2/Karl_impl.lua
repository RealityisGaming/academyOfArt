require "config"

-- You are not expected to use or modify anything in this file!

delta = {x=0, y=0}

destination = {
    x=robot.x,
    y=robot.y
}

instructions = {}

doRun = true
nextInstruction = -1
nextTurn = -1;

loggedMessages = {}

mainCoroutine = nil

function love.load(arg)
    if arg[#arg] == "-debug" then require("mobdebug").start() end

    world.width = love.graphics.getWidth() / GRID_SIZE
    world.height = love.graphics.getHeight() / GRID_SIZE

    if(init ~= nil)
    then
        init();
    end

    if(not interactiveMode)
    then
        mainCoroutine = coroutine.create(main)
    end
end

function invertY(y)
    return (world.height - y)
end

function love.draw()

    -- vertical grid lines
    for i=0, world.width do
        local pos = i * GRID_SIZE
        love.graphics.line(pos, 0, pos, love.graphics.getHeight())
    end

    -- horizontal grid lines
    for i=0, world.height do
        local pos = i * GRID_SIZE
        love.graphics.line(0, pos, love.graphics.getWidth(), pos)
    end

    -- beepers
    for y=0, world.height do
        for x=0, world.width do
            local key = "at" .. x .. '_' .. y
            if beepers[key] ~= nil and beepers[key] > 0 then
                local pos = { x = x * GRID_SIZE, y = invertY(y) * GRID_SIZE }
                love.graphics.circle("fill", pos.x, pos.y, 5)
            end
        end
    end

    -- wall color
    love.graphics.setColor(0, 0, 1, 1)

    -- vertical walls
    for y=0, world.height do
        for x=0, world.width do
            local key = "eastOf" .. x .. '_' .. y
            if walls[key] == 1 then
                local pos = { x = (x + 0.5) * GRID_SIZE, y = invertY(y + 0.5) * GRID_SIZE }
                --love.graphics.line(pos.x, pos.y - (GRID_SIZE * 0.5), pos.x, pos.y + (GRID_SIZE * 0.5))
                love.graphics.rectangle("fill", pos.x - 1, pos.y, 3, GRID_SIZE)
            end
        end
    end

    -- horizontal walls
    for y=1, world.height do
        for x=1, world.width do
            local key = "northOf" .. x .. '_' .. y
            if walls[key] == 1 then
                local pos = { x = (x - 0.5) * GRID_SIZE, y = invertY(y + 0.5) * GRID_SIZE }
                --love.graphics.line(pos.x, pos.y - (GRID_SIZE * 0.5), pos.x, pos.y + (GRID_SIZE * 0.5))
                love.graphics.rectangle("fill", pos.x - 1, pos.y, GRID_SIZE, 3)
            end
        end
    end

    -- reset color
    love.graphics.setColor(1, 1, 1, 1)

    local robotPos = {
        x= robot.x * GRID_SIZE,
        y= invertY(robot.y) * GRID_SIZE
    }
    local vertices = {}

    if robot.rot == 'n' then
        vertices = {
            robotPos.x - SMALL_OFFSET, robotPos.y + SMALL_OFFSET,
            robotPos.x + SMALL_OFFSET, robotPos.y + SMALL_OFFSET,
            robotPos.x, robotPos.y - LARGE_OFFSET
        }
    elseif robot.rot == 's' then
        vertices = {
            robotPos.x - SMALL_OFFSET, robotPos.y - SMALL_OFFSET,
            robotPos.x + SMALL_OFFSET, robotPos.y - SMALL_OFFSET,
            robotPos.x, robotPos.y + LARGE_OFFSET
        }
    elseif robot.rot == 'w' then
        vertices = {
            robotPos.x + SMALL_OFFSET, robotPos.y - SMALL_OFFSET, 
            robotPos.x + SMALL_OFFSET, robotPos.y + SMALL_OFFSET, 
            robotPos.x - LARGE_OFFSET, robotPos.y
        }
    elseif robot.rot == 'e' then
        vertices = {
            robotPos.x - SMALL_OFFSET, robotPos.y - SMALL_OFFSET, 
            robotPos.x - SMALL_OFFSET, robotPos.y + SMALL_OFFSET, 
            robotPos.x + LARGE_OFFSET, robotPos.y
        }
    end

    love.graphics.polygon("fill", vertices);

    while #loggedMessages > 20 do
        table.remove(loggedMessages, 1)
    end

    for i=1, #loggedMessages do
        love.graphics.print(loggedMessages[i], 0, i*20)
    end
end

function love.update(deltaTime)

    if not doRun then
        return
    end

    if(interactiveMode)
    then
        main();
    elseif love.timer.getTime() > nextInstruction then
        nextInstruction = love.timer.getTime() + instructionInterval
        coroutine.resume(mainCoroutine)
    end

    if (robot.x ~= destination.x) or (robot.y ~= destination.y)
	then
        robot.x = robot.x + delta.x / instructionInterval * deltaTime
        robot.y = robot.y + delta.y / instructionInterval * deltaTime
        
        if math.abs(robot.x - destination.x) < 0.1 then
            robot.x = destination.x
        end
        
        if math.abs(robot.y - destination.y) < 0.1 then
            robot.y = destination.y
        end
    end
end

function doMove()

    if (robot.x ~= destination.x) or (robot.y ~= destination.y)
    then
        return;
    end

    delta.x = 0
    delta.y = 0

    if robot.rot == 'n' then
        delta.y = 1
    elseif robot.rot == 's' then
        delta.y = -1
    elseif robot.rot == 'w' then
        delta.x = -1
    elseif robot.rot == 'e' then
        delta.x = 1
    else
        love.errorhandler("invalid rotation")
    end

    destination = { x=robot.x + delta.x, y=robot.y + delta.y }

    local wallString = nil

    if isWall(robot.x, robot.y, robot.rot) then
        log("ERROR SHUTOFF: Attempting to walk into a wall.")
        doRun = false
    end
end

function doTurnLeft()
    --if(love.timer.getTime() > nextInstruction)
    --then
        robot.rot = rotateLeft(robot.rot);
        nextInstruction = love.timer.getTime() + 0.1;
    --end
end

function doTurnRight()
    if(love.timer.getTime() > nextInstruction)
    then
        robot.rot = rotateRight(robot.rot);
        nextInstruction = love.timer.getTime() + 0.1;
    end
end

function doTurnOff()
    robot.on = false
end

function doPickBeeper()
    --if(love.timer.getTime() > nextInstruction)
    --then
        if isBeeperAt(robot.x, robot.y) then
            robot.beepers = robot.beepers + 1
            local key = "at" .. robot.x .. '_' .. robot.y
            beepers[key] = beepers[key] - 1
            log("beepers " .. key .. " is now " .. beepers[key])
        else
            log("ERROR SHUTOFF: pickbeeper called with no beeper on ground")
            doRun = false
        end
        nextInstruction = love.timer.getTime() + 0.1;
    --end
end

function doPutBeeper()
    --if(love.timer.getTime() > nextInstruction)
    --then
        if robot.beepers <= 0 then
            log("ERROR SHUTOFF: putbeeper called with no beeper in bag")
            doRun = false
            return
        end

        robot.beepers = robot.beepers - 1

        local key = "at" .. robot.x .. '_' .. robot.y
        if beepers[key] == nil then
            beepers[key] = 1
        else
            beepers[key] = beepers[key] + 1
        end

        log("beepers " .. key .. " is now " .. beepers[key])
        nextInstruction = love.timer.getTime() + 0.1;
    --end
end

function isWall(x, y, dir)
    if dir == 'n' then
        wallString = "northOf" .. x .. '_' .. y
    elseif dir == 's' then
        wallString = "northOf" .. x .. '_' .. (y - 1)
    elseif dir == 'w' then
        wallString = "eastOf" .. (x - 1) .. '_' .. y
    else
        wallString = "eastOf" .. x .. '_' .. y
    end

    return walls[wallString] == 1
end

function rotateLeft(dir)
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

function rotateRight(dir)
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

function isBeeperAt(x, y)
    local key = "at" .. x .. '_' .. y
    return beepers[key] ~= nil and beepers[key] > 0
end