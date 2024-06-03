@tool
extends Node2D

@export_range( - PI, PI) var rotation_3d: float = 0:
	set(value):
		rotation_3d = value
		if is_node_ready():
			for node in get_children():
				node.rotation = value

@export var mihon_visible:bool = false:
	set(value):
		mihon_visible = value
		if is_node_ready():
			$Mihon.visible = value
