extends AnimationPlayer


@export var boundary_size: Vector2: 
	get: 
		return _boundary.size
	set(value): 
		if is_node_ready(): 
			_boundary.size = value

@export var boundary_position: Vector2: 
	get: 
		return _boundary.position		
	set(value): 
		if is_node_ready(): 
			_boundary.position = value

@export var player_visible: bool: 
	get: 
		return _player.visible
	set(value): 
		if is_node_ready(): 
			_player.visible = value

@export var player_position: Vector2: 
	get: 
		return _player.position
	set(value): 
		if is_node_ready(): 
			_player.position = value


@export var boss_gray_out: bool: 
	get: 
		return _boss.modulate.a != 1
	set(value): 
		if is_node_ready(): 
			if value: 
				_boss.modulate.a = 0.5
			else: 
				_boss.modulate.a = 1

@onready var _boundary = %Boundary
@onready var _player = %Player
@onready var _boss = %Boss


#region fight player function
func spawn(scene: PackedScene, args: Dictionary): 
	var node = scene.instantiate()
	node.init(args)
	add_child(node)


func queue_free_all(): 
	for node in get_children(): 
		node.queue_free()


#endregion


func _on_animation_finished(anim_name): 
	queue_free_all()
	player_visible = false
	boss_gray_out = false
