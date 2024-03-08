function basket()
    if basket_is_full()
    then
        pickBasket();
        takeToLaundryRoom();
        if washing_machine_empty()
        then
            openWashingMachine();
            dumpBasket();
        elseif washing_machine_full()
        then
            moveLaundryOver();
        end
    end
end

function washingMachine()
    powerOn();
    chooseLoad();
    pressStart();
end

function dryer()
    if dryer_is_full()
    then
        empty_machine();
    elseif dryer_is_empty()
    then
        moveLaundryOver();
    end
end


function laundry()
    basket();
    washingMachine();
    dryer();

    
    turnoff();
end