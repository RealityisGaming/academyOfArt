require "Karl"
function moveTwiceAndPick()
  for i=1,2
  do
    move();
  end
  pickbeeper();
end

function turnaround()
  for i=1,2
  do
    turnleft();
  end
end

function makeUTurn()
  for i=1,2
  do
    move();
    turnleft();
  end
  move();
end

function makeRightHandUTurn()
  for i=1, 2
  do
    move();
    turnright();
  end
  move();
end

function turnright()
  for i=1, 3
  do
    turnleft();
  end
end

function stepPickReturn()
  move();
  pickbeeper();
  turnaround(); -- no function
  move();
  turnaround(); -- unneeded code but works in this case
end

function pickCornerBeeper()
  move();
  pickbeeper();
  turnright();
  move();
end

function moveThreeTimesAndPick()
  for i=1,3
  do
  move();
  end
  pickbeeper();
  end



function main()
  moveTwiceAndPick();
  makeUTurn();
  pickbeeper();
  pickCornerBeeper();
  pickCornerBeeper();
  moveThreeTimesAndPick();
  turnright();
  pickCornerBeeper(); -- <<Because of line 73 one space too close to the wall, add a right turn just before.
  move();
  stepPickReturn();
  turnleft();
  moveThreeTimesAndPick();
  makeRightHandUTurn();
  turnleft();
  move();
  pickbeeper(); -- no beeper available add move() before
  turnleft();
  moveThreeTimesAndPick();
  turnleft();
  moveThreeTimesAndPick();
  turnleft();
  move();
  turnleft();
  stepPickReturn();
  turnright();
  moveThreeTimesAndPick();
  turnright();
  pickCornerBeeper();
  moveThreeTimesAndPick();
  turnleft();
  moveTwiceAndPick();

  turnoff();
end