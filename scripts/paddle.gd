class_name Paddle extends CharacterBody2D

@export var speed := 500;

@export var hp := 10;
@export var max_hp := 10;

signal hp_changed(hp, max_hp);

func change_hp(amount):
	hp += amount;
	hp = clamp(hp, 0, max_hp);
	hp_changed.emit(hp, max_hp);
