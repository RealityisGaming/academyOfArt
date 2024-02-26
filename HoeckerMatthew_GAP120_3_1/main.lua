require "Karl"

function step()
    move();
end

function pick()
    pickbeeper()
end

function place()
    putbeeper();
end

function turnMove()
    turnleft();
    move();
end

function rightTurn()
   turnleft();
   turnleft();
   turnleft();
end

function turnAround()
    turnleft();
    turnleft();
end

function boxedIn()
    if left_is_blocked() 
    then
        if right_is_blocked
        then
            turnAround()
            move();
        end
    end
end

function whereWalls()
    if (right_is_blocked())
    then
        if left_is_clear() 
        then
            turnleft();
            move();
    elseif (left_is_blocked())
    then
        if right_is_clear() 
        then
            rightTurn();
            move();
    elseif front_is_blocked()   
    then
        turnAround();
        move();
    end
    end
    end
end


function stepCheck()
    if
        next_to_a_beeper()
    then
        pickbeeper();
        move();
    else
        move();
    end
end

function main()

    stepCheck();
    -- (3, 2, North)

    stepCheck();
    -- (3, 3, North)

    stepCheck();
    -- (3, 4, North)

    turnleft();
    stepCheck();
    -- (2, 4, West)

    stepCheck();
    turnleft();
    -- (1, 4, South)

    stepCheck();
    -- (1, 3, South)

    stepCheck();
    turnleft();
    -- (1, 2, East)

    stepCheck();
    turnleft()
    -- (2, 2, North)

    stepCheck();
    -- (2, 3, North)
    stepCheck();
    -- (2, 4, North)


    turnoff();
end