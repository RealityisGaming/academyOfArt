require "Karl_impl"

function log(message)
    table.insert(loggedMessages, message)
end

function move()
    doMove()
    coroutine.yield()
end

function turnleft()
    doTurnLeft()
    coroutine.yield()
end

function turnoff()
    doTurnOff()
    coroutine.yield()
end

function pickbeeper()
    doPickBeeper()
    coroutine.yield()
end

function putbeeper()
    doPutBeeper()
	coroutine.yield()
end

function front_is_clear()
    return not isWall(robot.x, robot.y, robot.rot)
end

function front_is_blocked()
    return not front_is_clear()
end

function left_is_clear()
    return not isWall(robot.x, robot.y, rotateLeft(robot.rot))
end

function left_is_blocked()
    return not left_is_clear()
end

function right_is_clear()
    return not isWall(robot.x, robot.y, rotateRight(robot.rot))
end

function right_is_blocked()
    return not right_is_clear()
end

function next_to_a_beeper()
    return isBeeperAt(robot.x, robot.y)
end

function not_next_to_a_beeper()
    return not next_to_a_beeper()
end

function any_beepers_in_beeper_bag()
    return robot.beepers > 0
end

function no_beepers_in_beeper_bag()
    return not any_beepers_in_beeper_bag()
end

function facing_north()
    return robot.rot == 'n'
end

function not_facing_north()
    return not facing_north()
end

function facing_west()
    return robot.rot == 'w'
end

function not_facing_west()
    return not facing_west()
end

function facing_south()
    return robot.rot == 's'
end

function not_facing_south()
    return not facing_south()
end

function facing_east()
    return robot.rot == 'e'
end

function not_facing_east()
    return not facing_east()
end