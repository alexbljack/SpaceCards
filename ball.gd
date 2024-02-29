class_name Ball extends RigidBody2D

@export var speed := 400;
@export var start_impulse := 800;

var velocity = Vector2.ZERO;

func _ready():
	velocity = Vector2(1, 1).normalized() * speed;


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta);
	var collider = collision.get_collider() if collision else null;

	if collider is PlayerPaddle or collider is AIPaddle:
		var paddle_pos = collider.global_position;
		var to_ball = paddle_pos.direction_to(global_position);
		var current_dir := velocity.normalized();
		var updated = (to_ball - current_dir).normalized();
		velocity = updated * speed;
	elif collider:
		velocity = velocity.bounce(collision.get_normal());
