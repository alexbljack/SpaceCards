class_name Spawner extends Node2D

@onready var timer := $Timer;
@export var enemy: PackedScene;


func _ready():
	timer.timeout.connect(on_timeout);
	
	
func on_timeout():
	pass

