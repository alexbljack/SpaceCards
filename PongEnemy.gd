class_name PongEnemy extends RigidBody2D


@export var speed := 200;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(speed * Vector2.LEFT * delta);
