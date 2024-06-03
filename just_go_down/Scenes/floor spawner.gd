extends Timer

var floor_scene = preload("res://just_go_down/Object/floor.tscn")
var trapfloor_scene = preload("res://just_go_down/Object/trapfloor.tscn")
var tempfloor_scene = preload("res://just_go_down/Object/tempfloor.tscn")
var rng = RandomNumberGenerator.new()
var rngflr = RandomNumberGenerator.new()
var y = 375
var addition = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawn_floor():
	var idx = rng.randi_range(1,10)
	var floor_node 
	if idx > 3:
		floor_node = floor_scene.instantiate()
	elif idx == 1:
		floor_node = trapfloor_scene.instantiate()
	else:
		floor_node = tempfloor_scene.instantiate()
	floor_node.position.x = rng.randi_range(-340,340)
	floor_node.position.y = y
	get_tree().current_scene.add_child(floor_node)
	
func _on_timeout():
	y += 125
	spawn_floor()

