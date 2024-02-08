class_name Enemy extends Sprite2D

@export var dices: Array[Dice]


func choose_dice():
	return dices.pick_random();
