class_name Ball extends RigidBody2D

@export var speed := 400;
@export var bullet: PackedScene;


@onready var shoot_timer := $ShootTimer


var velocity = Vector2.ZERO;

func _ready():
	velocity = Vector2(1, 1).normalized() * speed;
	shoot_timer.timeout.connect(on_shoot_cooldown);
	shoot_timer.start()


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


func on_shoot_cooldown():
	var obj = bullet.instantiate() as Bullet;
	obj.global_position = global_position;
	owner.add_child(obj);
	obj.init(get_bullet_direction());


func get_bullet_direction():
	var enemies = get_tree().get_nodes_in_group("Enemy");
	if (enemies.size() > 0):
		var result_node = enemies[0];
		for node in enemies:
			var current_dist = (result_node.global_position - global_position).length();
			var dist = (node.global_position - global_position).length();
			if dist < current_dist:
				result_node = node;
		return (result_node.global_position - global_position).normalized();
