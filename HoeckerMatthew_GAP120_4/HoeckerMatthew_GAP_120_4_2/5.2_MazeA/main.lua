require "Karl"
function rightTurn()
  for i = 1, 3
  do
    turnleft();
  end
end

function turnAround()
  for i = 1, 2
  do
    turnleft();
  end
end

function leftWall()
  if front_is_clear()
  then
    if left_is_clear()
    then
      if right_is_clear() then
        turnleft();
      end
    end
  end
end

function checkWalls()
  leftWall();
  if front_is_clear()
  then
    move();
  elseif left_is_clear()
    then
      turnleft();
      move();
  elseif right_is_clear()
      then
        rightTurn();
        move()
      else
        turnAround();
  end
end


function main()
  while no_beepers_in_beeper_bag()
  do
    checkWalls();
    if next_to_a_beeper()
    then
      pickbeeper();
      turnoff();
    end
  end

end