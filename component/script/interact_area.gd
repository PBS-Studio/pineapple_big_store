extends Area2D

@export var active: bool = true:
	set(value):
		active = value
		if not active and is_node_ready():
			InteractManager.unregist_interact(self)

var indicator: bool:
	get:
		if is_node_ready():
			return $Arrow.visible
		return false
	set(value):
		if is_node_ready():
			$Arrow.visible = value

signal interact

func _ready():
	$Arrow.global_position = $Marker2D.global_position	


func _on_body_entered(_node: Node2D) -> void:
	if active:
		InteractManager.regist_interact(self)


func _on_body_exited(_node: Node2D) -> void:
	if active:
		InteractManager.unregist_interact(self)
		indicator = false
