extends Node2D

@onready var atk_btn := $"CanvasLayer/ATKButton"
@onready var def_btn := $"CanvasLayer/DEFButton"
@onready var ap_counter := $"CanvasLayer/APLabel"
@onready var action_text := $"CanvasLayer/ActionTextLabel"
@onready var end_turn_btn := $"CanvasLayer/EndTurnButton"

@onready var action_timer := $"ActionTimer"

@onready var player: Player = $"Player"
@onready var enemy: Enemy = $"Enemy"

@export var ap := 3
@export var max_ap := 3


func _ready() -> void:
	clear_action_text();
	atk_btn.button_down.connect(func(): roll_dice(player.attack_dice));
	def_btn.button_down.connect(func(): pass);
	end_turn_btn.button_down.connect(start_enemy_turn);
	action_timer.timeout.connect(on_action_timer);


func start_player_turn():
	end_turn_btn.visible = true;
	atk_btn.disabled = true;
	def_btn.disabled = true;
	change_ap(max_ap);
	end_turn_btn.visible = true;


func start_enemy_turn():
	end_turn_btn.visible = false;
	atk_btn.disabled = true;
	def_btn.disabled = true;
	roll_dice(enemy.choose_dice());


func roll_dice(dice: Dice):
	var face = dice.roll()
	set_action_text(face.on_apply)
	atk_btn.disabled = true;
	def_btn.disabled = true;
	change_ap(-dice.ap_cost)


func on_action_timer():
	atk_btn.disabled = false;
	def_btn.disabled = false;
	clear_action_text();


func change_ap(amount):
	ap += amount
	ap = clampi(ap, 0, max_ap)
	action_timer.start();
	update_ap_ui();


func update_ap_ui():
	ap_counter.text = "AP {count}".format({'count': ap})


func clear_action_text():
	set_action_text('');


func set_action_text(text):
	action_text.text = text;

