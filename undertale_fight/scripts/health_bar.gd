@tool
extends Node2D

signal zero_health
signal maxout_health
signal health_change

@export var type: Type
@export var full_health: int
@export var remain_health: int

enum Type {
	Player,
	Boss,	
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$RemainHealth.scale.x = remain_health / full_health
		
	match type :
		Type.Player:
			$RemainHealth.texture = $RemainHealth.player_health_bar
		Type.Boss:
			$RemainHealth.texture = $RemainHealth.boss_health_bar

func take_damage(damage: int):
	if damage <= 0:
		return
	
	remain_health = max(remain_health - damage, 0)
	if remain_health == 0:
		zero_health.emit()	
	_update_health_bar()
	

func gain_health(health: int):
	if health <= 0:
		return
	
	remain_health = max(remain_health + health, full_health)
	if remain_health == full_health:
		maxout_health.emit()
	_update_health_bar()

func _update_health_bar():
	$RemainHealth.scale.x = remain_health / full_health
	health_change.emit()
