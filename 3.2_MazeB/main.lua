require "Karl"

function rightTurn()
	turnleft();
	turnleft();
	turnleft();
end

function turnAround()
	turnleft();
	turnleft();
end

function checkWalls()
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
				move();
			end

end



function main()
	for i = 1, 9
	do
		checkWalls()
		if next_to_a_beeper()
		then
			pickbeeper();
		end
	end
	turnoff();
end
