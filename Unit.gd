class_name Unit extends Sprite2D

@export var move_speed := 50;

var target: Vector2;


func _ready() -> void:
	target = position;


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		target = get_local_mouse_position();
		print(target)
		print(target.normalized())


func _process(delta: float) -> void:
	if (position - target).length() > 0.1:
		position += target.normalized() * delta * move_speed;
