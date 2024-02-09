class_name Action extends Resource

enum ActionTypes { ATTACK, DEFEND, NOTHING }
enum Targets { PLAYER, ENEMY }

@export var title: String
@export var on_apply: String
@export var type: ActionTypes
@export var target: Targets
@export var amount := 1;


func act(player: Entity, enemy: Entity):
	if type == ActionTypes.NOTHING:
		return;
	
	if type == ActionTypes.ATTACK:
		if target == Targets.ENEMY:
			enemy.damage(amount);
		if target == Targets.PLAYER:
			player.damage(amount);
	
	if type == ActionTypes.DEFEND:
		if target == Targets.ENEMY:
			enemy.change_defence(amount);
		if target == Targets.PLAYER:
			player.change_defence(amount);
