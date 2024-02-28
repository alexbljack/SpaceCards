class_name Ball extends RigidBody2D

@export var speed := 400;

var direction = Vector2(1, 1);

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(delta * speed * direction);
	if collision:
		direction = direction.bounce(collision.get_normal())
