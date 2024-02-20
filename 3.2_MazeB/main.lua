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

function checkAhead()
	if front_is_clear()
	then
		move();
	end
end

function checkLeft()
	if left_is_clear()
	then
		turnleft();
		move();
	end

end

function checkRight()

	if right_is_clear()
	then
		rightTurn();
		move();
	end

end


function deadEnd()
	if right_is_blocked()
	then
		if front_is_blocked()
		then
			if left_is_blocked()
			then
				turnAround();
				move();
			end
		end
	end
end

function mazeRunner()
	for i = 1, 6, -1
	do
		checkAhead();
		checkLeft();
		checkRight();
		deadEnd();
	end
end

function main()
	move();
	if not_next_to_a_beeper()
	then
		mazeRunner();
		if next_to_a_beeper()
			then
				pickbeeper();
		end
	end
	turnoff();
end
