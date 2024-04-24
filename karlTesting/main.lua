require "Karl"
function rightTuurn()
    turnleft();
    turnleft();
    turnleft();
end
function turnAround()
    turnleft();
    turnleft();
end
function leftJump()
    turnleft();
    move();
    move();
end
function jump()
    move();
    move();
end

function main()
    move();
    pickbeeper();
    move();
    pickbeeper();
    leftJump();
    pickbeeper();
    leftJump();
    pickbeeper();
    move();
    pickbeeper();
    move();
    pickbeeper();
    leftJump();
    pickbeeper();
    move();
    pickbeeper();
    move();
    turnleft();
    move();
    pickbeeper();
    jump();
    pickbeeper();
    move();
    pickbeeper();
    leftJump();
    rightTuurn();
    move();
    pickbeeper();
    turnAround();
    move();
    move();
    move();
    turnleft()
    move()
    pickbeeper();
    turnAround();
    jump();
    pickbeeper();






    turnoff();
end