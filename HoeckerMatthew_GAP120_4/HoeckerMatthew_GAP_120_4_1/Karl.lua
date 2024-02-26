require "Karl_impl"

function log(message)
    KarlTheRobot.doLog(message);
end


function move()
    KarlTheRobot.doMove()
    coroutine.yield()
end


function turnleft()
    KarlTheRobot.doTurnLeft()
    coroutine.yield()
end


function turnoff()
    KarlTheRobot.doTurnOff()
    coroutine.yield()
end


function pickbeeper()
    KarlTheRobot.doPickBeeper()
    coroutine.yield()
end


function putbeeper()
    KarlTheRobot.doPutBeeper()
    coroutine.yield()
end


function front_is_clear()
    return not KarlTheRobot.isWall(KarlTheRobot.robot.x,
		KarlTheRobot.robot.y, KarlTheRobot.robot.rot)
end


function front_is_blocked()
    return not front_is_clear()
end


function left_is_clear()
    return not KarlTheRobot.isWall(KarlTheRobot.robot.x, KarlTheRobot.robot.y,
		KarlTheRobot.rotateLeft(KarlTheRobot.robot.rot))
end


function left_is_blocked()
    return not left_is_clear()
end


function right_is_clear()
    return not KarlTheRobot.isWall(KarlTheRobot.robot.x, KarlTheRobot.robot.y,
		KarlTheRobot.rotateRight(KarlTheRobot.robot.rot))
end


function right_is_blocked()
    return not right_is_clear()
end


function next_to_a_beeper()
    return KarlTheRobot.isBeeperAt(KarlTheRobot.robot.x, KarlTheRobot.robot.y)
end

function not_next_to_a_beeper()
    return not next_to_a_beeper()
end

function any_beepers_in_beeper_bag()
    return KarlTheRobot.robot.beepers > 0
end

function no_beepers_in_beeper_bag()
    return not any_beepers_in_beeper_bag()
end

function facing_north()
    return KarlTheRobot.robot.rot == 'n'
end

function not_facing_north()
    return not facing_north()
end

function facing_west()
    return KarlTheRobot.robot.rot == 'w'
end

function not_facing_west()
    return not facing_west()
end

function facing_south()
    return KarlTheRobot.robot.rot == 's'
end

function not_facing_south()
    return not facing_south()
end

function facing_east()
    return KarlTheRobot.robot.rot == 'e'
end

function not_facing_east()
    return not facing_east()
end