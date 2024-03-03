class_name OutArea extends Area2D

@export var paddle: Paddle;


func _ready():
	body_entered.connect(on_ball_entered);


func on_ball_entered(body):
	print(body);
