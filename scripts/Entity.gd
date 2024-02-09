class_name Entity extends Sprite2D

@export var max_hp := 10
@export var hp := 10

@onready var hp_bar: ProgressBar = $"HPBar"

var defence := 0;

signal hp_changed(current, max_hp);
signal defence_changed(value);


func _ready() -> void:
	on_hp_change(hp, max_hp);
	hp_changed.connect(on_hp_change);


func change_hp(amount):
	hp += amount;
	hp = clampi(hp, 0, max_hp);
	hp_changed.emit(hp, max_hp)


func change_defence(amount):
	defence += amount;
	defence = clampi(defence, 0, 1000);
	defence_changed.emit(defence);


func reset_defence():
	defence = 0;
	defence_changed.emit(defence);


func damage(amount):
	if defence >= amount:
		change_defence(-amount);
	else:
		change_defence(-defence);
		var hp_damage = abs(defence - amount);
		change_hp(-amount);


func on_hp_change(value, max_value):
	hp_bar.value = value;
	hp_bar.max_value = max_hp;
