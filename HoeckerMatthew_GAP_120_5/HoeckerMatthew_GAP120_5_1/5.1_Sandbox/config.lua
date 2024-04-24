GRID_SIZE = 40
SMALL_OFFSET = GRID_SIZE / 3
LARGE_OFFSET = GRID_SIZE / 2

world = {}

beepers = {
  at1_2 = 1,
  at3_2 = 1,
  at5_2 = 1,
  at8_2 = 1,
  at2_3 = 1,
  at3_3 = 1,
  at4_3 = 1,
  at5_4 = 1,
  at7_4 = 1,
  at4_5 = 1,
  at8_5 = 1,
  at1_6 = 1,
  at2_6 = 1,
  at4_6 = 1,
  at8_6 = 1,
  at8_8 = 1,
  
}

walls = {
  eastOf0_2 =1,
  eastOf0_3 =1,
  eastOf0_4 =1,
  eastOf0_5 =1,
  eastOf0_6 =1,
  eastOf1_3 =1,
  eastOf1_4 =1,
  eastOf1_5 =1,
  eastOf2_3 =1,
  eastOf2_5 =1,
  eastOf3_2 =1,
  eastOf3_3 =1,
  eastOf3_5 =1,
  eastOf3_6 =1,
  eastOf4_2 =1,
  eastOf6_4 =1,
  eastOf7_3 =1,
  eastOf7_4 =1,
  eastOf8_2 =1,
  eastOf8_3 =1,
  eastOf8_4 =1,
  eastOf8_5 =1,
  eastOf8_6 =1,

  northOf1_1 =1,
  northOf2_1 =1,
  northOf3_1 =1,
  northOf5_1 =1,
  northOf6_1 =1,
  northOf7_1 =1,
  northOf8_1 =1,
  northOf2_2 =1,
  northOf6_2 =1,
  northOf7_2 =1,
  northOf5_3 =1,
  northOf7_3 =1,
  northOf3_4 =1,
  northOf4_4 =1,
  northOf6_4 =1,
  northOf5_5 =1,
  northOf7_5 =1,
  northOf8_5 =1,
  northOf1_6 =1,
  northOf2_6 =1,
  northOf3_6 =1,
  northOf4_6 =1,
  northOf5_6 =1,
  northOf6_6 =1,
  northOf7_6 =1,
}

robot = {
    on=true,
    x=4,
    y=1,
    rot='n',
    beepers=0
}

instructionInterval = 1

interactiveMode = false;

function init()

end