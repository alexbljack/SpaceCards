class_name BattleController extends Node2D

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

enum Turn {PLAYER, ENEMY}

var turn: Turn;

var acting = false;

func _ready() -> void:
	clear_action_text();
	atk_btn.button_down.connect(func(): roll_dice(player.attack_dice));
	def_btn.button_down.connect(func(): roll_dice(player.defense_dice));
	end_turn_btn.button_down.connect(start_enemy_turn);
	action_timer.timeout.connect(on_action_timer);
	start_player_turn();


func _process(delta):
	atk_btn.disabled = ap < player.attack_dice.ap_cost || acting;
	def_btn.disabled = ap < player.defense_dice.ap_cost || acting;


func start_player_turn():
	turn = Turn.PLAYER;
	show_ui();
	change_ap(max_ap);


func start_enemy_turn():
	turn = Turn.ENEMY;
	hide_ui();
	roll_dice(enemy.choose_dice());


func roll_dice(dice: Dice):
	var face = dice.roll();
	if turn == Turn.PLAYER:
		change_ap(-dice.ap_cost);
	start_action(face);


func start_action(action):
	acting = true;
	set_action_text(action.on_apply)
	action_timer.start();


func on_action_timer():
	acting = false;
	clear_action_text();
	if turn == Turn.ENEMY:
		start_player_turn();


func change_ap(amount):
	ap += amount
	ap = clampi(ap, 0, max_ap)
	update_ap_ui();


func show_ui():
	end_turn_btn.visible = true;
	atk_btn.visible = true;
	def_btn.visible = true;


func hide_ui():
	end_turn_btn.visible = false;
	atk_btn.visible = false;
	def_btn.visible = false;


func update_ap_ui():
	ap_counter.text = "AP {count}".format({'count': ap})


func clear_action_text():
	set_action_text('');


func set_action_text(text):
	action_text.text = text;

