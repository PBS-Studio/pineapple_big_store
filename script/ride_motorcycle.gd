extends Node2D


@export_range( - PI, PI) var rotation_3d: float = 0:
	set(value):
		rotation_3d = value
		if is_node_ready():
			motorcycle.rotation_3d = value

@onready var motorcycle = $Motorcycle
@onready var static_body = $StaticBody2D
@onready var collision = $StaticBody2D/MotorcycleCollision
@onready var area = $InteractArea

func exit_motorcycle():
	motorcycle.mihon_visible = false
	area.active = true
	global_position = get_parent().global_position
	get_parent().get_node("MotorcycleCollision").reparent(static_body)
	reparent(get_parent().get_parent())


func _on_interact_area_interact():
	var player = area.get_overlapping_bodies().front()
	if player == null:
		return
	
	motorcycle.mihon_visible = true
	area.active = false
	player.global_position = global_position
	collision.reparent(player)
	reparent(player)
	player.ride_motorcycle()

