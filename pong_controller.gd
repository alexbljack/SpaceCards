class_name PongController extends Node2D

@export var ball_speed := 400;
@export var ball_speed_increase := 25;
@export var ball_damage_increase := 2;

@onready var ball: Ball = $Ball;
@onready var player: Paddle = $PlayerPaddle;
@onready var ai: Paddle = $AIPaddle;

@onready var ball_position := $BallPosition;
@onready var ball_timer := $BallTimer;

@onready var out_player := $OutAreaPlayer;
@onready var out_ai := $OutAreaAI;

@onready var hp_player := $CanvasLayer/HPBarPlayer;
@onready var hp_ai := $CanvasLayer/HPBarAI;
@onready var stats := $CanvasLayer/BallStats;


func _ready():
	out_player.body_entered.connect(on_lose_player);
	out_ai.body_entered.connect(on_lose_ai);
	
	ball_timer.timeout.connect(on_ball_timeout);
	ball.bounced_from_paddle.connect(on_ball_bounced);
	
	player.hp_changed.connect(on_player_hp_changed);
	ai.hp_changed.connect(on_ai_hp_changed);
	
	on_player_hp_changed(player.hp, player.max_hp);
	on_ai_hp_changed(ai.hp, ai.max_hp);
	
	reset_ball();


func _process(delta):
	stats.text = "DMG: %s\nSPD: %s" % [ball.damage, ball.speed];


func on_lose_player(body):
	player.change_hp(-ball.damage);
	reset_ball();
	
	
func on_lose_ai(body):
	ai.change_hp(-ball.damage);
	reset_ball();


func on_ball_timeout():
	ball.launch(ball_speed);


func reset_ball():
	ball.stop()
	ball.damage = 1;
	ball.global_position = ball_position.global_position;
	ball_timer.start()


func on_ball_bounced(paddle: Paddle):
	ball.accelerate(ball_speed_increase);
	ball.damage += ball_damage_increase;


func on_player_hp_changed(value, max_value):
	hp_player.value = value;
	hp_player.max_value = max_value;


func on_ai_hp_changed(value, max_value):
	hp_ai.value = value;
	hp_ai.max_value = max_value;

