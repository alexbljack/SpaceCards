class_name AIPaddle extends CharacterBody2D

@export_range(0, 1000, 10, 'suffix:px/s')
var speed: float

@export_range(0, 640, 8, 'suffix:px')
var min_distance_to_ball: int

@export_range(0, 1, 0.01)
var detection_threshhold: float

@export
var ball: Ball

@onready
var timer: Timer = $Timer

var target_distance := 0.0


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	timer.start()


func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO;
	if target_distance < -detection_threshhold:
		direction = Vector2.DOWN;
	elif target_distance > detection_threshhold:
		direction = Vector2.UP;
		
	move_and_collide(direction * speed * delta);


func _on_timer_timeout() -> void:
	var distance = global_position.distance_to(ball.global_position)
	if distance <= min_distance_to_ball:
		return
		
	var diff = to_global(Vector2.UP) - global_position
	var direction_to_ball = global_position.direction_to(ball.global_position)
	target_distance = diff.dot(direction_to_ball)

