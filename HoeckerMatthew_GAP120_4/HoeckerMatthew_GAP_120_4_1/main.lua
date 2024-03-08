require "Karl"
function rightTurn()
  for i=1,3 do
    turnleft();
  end
end

function fiveStep()
  for i = 1, 5
  do
    move();
  end
end

function berryPicker()
  for i = 1, 3
  do
    move();
    if next_to_a_beeper()
    then
      pickbeeper();
    end
  end
end

function breadCrumbs()
  for i = 1, 3 
  do
    move();
    if any_beepers_in_beeper_bag()
    then
      putbeeper();
    end
  end

end
function finalStretch()
  for i = 1, 2
  -- Moves from 4,1 to 3,1
  -- picks beeper if possible
  -- Moves from 3,1 to 2,1
  -- Pick beeper if possible
  do
      move();
      if next_to_a_beeper()
      then
        pickbeeper();
        elseif any_beepers_in_beeper_bag()
        then
          putbeeper();
      end
  end
  
end

function main()
  for i = 1, 3
  -- Moves from 1,1 to 1,4 and picks beepers if possible
  -- Faces East
  -- Moves from 1,4 to 4,4 Picking beepers if possible
  -- Faces South
  -- Moves from 4,4 to 2,1 Picking beepers if possible
  -- Faces West
  do
    berryPicker();
    rightTurn();
    if facing_west()
    then
      -- Moves from 4,1 to 3,1
      -- picks beeper if possible
      -- Moves from 3,1 to 2,1
      -- Pick beeper if possible
      finalStretch();

    end
    if front_is_blocked()
    then
      rightTurn(); -- Faces North
      fiveStep(); -- Moves from 2,1 to 2,6 
    end
  end

  turnleft(); -- Faces West
  move(); -- Moves to 6,1
  rightTurn(); -- Faces North

    for i = 1, 3
      -- Moves from 1,6 to 1,9 and places beepers if possible at (1,7), (1,8), (1,9)
      -- Faces East
      -- Moves from 1,9 to 4,9 Picking beepers if possible at (2,9), (3,9), (4,9)
      -- Faces South
      -- Moves from 4,9 to 4,6 Picking beepers if possible at (4,8), (4,7), (4,6)
      -- Faces West
    do
      breadCrumbs();
      rightTurn();
    end
    if facing_west()
    then
      --Moves to 3,6 and places beeper if possible
      --Moves to 2,6 and places beeper if possible
      finalStretch();
    end
    turnoff();
end