extends Timer

var floor_scene = preload("res://just_go_down/Object/floor.tscn")
var rng = RandomNumberGenerator.new()
var y = 375

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawn_floor():
	var floor_node = floor_scene.instantiate()
	floor_node.position.x = rng.randi_range(-175,175)
	floor_node.position.y = y
	get_tree().current_scene.add_child(floor_node)
	




func _on_timeout():
	y += 125
	spawn_floor()

