class_name Dice extends Node

@export var ap_cost := 1
@export var faces: Array[Action]


func roll() -> Action:
	return faces.pick_random()
