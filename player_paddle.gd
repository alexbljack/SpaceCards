class_name PlayerPaddle extends CharacterBody2D

@export var speed := 200

func _physics_process(delta: float) -> void:
	var axis = Input.get_axis("ui_down", "ui_up");
	var movement = Vector2(0, -axis);
	move_and_collide(movement * speed * delta);
