class_name Ball extends RigidBody2D

@export var speed := 400;
@export var start_impulse := 800;

var direction = Vector2(1, 1);

func _ready():
	apply_central_impulse(Vector2(1, 1) * start_impulse);

func _physics_process(delta: float) -> void:
	pass
	#var collision = move_and_collide(delta * speed * direction);
	#if collision:
		#direction = direction.bounce(collision.get_normal())
