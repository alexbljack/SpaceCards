class_name Bullet extends Area2D

@export var speed := 100;

var direction := Vector2.ZERO;


func _ready():
	body_entered.connect(on_body_entered);


func _process(delta):
	position += direction.normalized() * speed * delta;


func init(dir: Vector2):
	direction = dir;
	
	
func on_body_entered(body):
	queue_free();
