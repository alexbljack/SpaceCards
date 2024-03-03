class_name Ball extends RigidBody2D

@export var speed := 400;
@export var bullet: PackedScene;
@export var damage := 1;

var velocity = Vector2.ZERO;

signal bounced_from_paddle(paddle);


func stop():
	velocity = Vector2.ZERO;


func launch(launch_speed: float):
	var x = [-1, 1].pick_random();
	var y = [-1, 1].pick_random();
	speed = launch_speed;
	velocity = Vector2(x, y).normalized() * speed;


func accelerate(amount) -> void:
	speed += amount;


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta);
	var collider = collision.get_collider() if collision else null;

	if collider is Paddle:
		var paddle_pos = collider.global_position;
		var to_ball = paddle_pos.direction_to(global_position);
		var current_dir := velocity.normalized();
		var updated = (to_ball - current_dir).normalized();
		velocity = updated * speed;
		bounced_from_paddle.emit(collider);
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
