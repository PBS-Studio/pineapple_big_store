extends Area2D
class_name InteractArea

@export var active: bool = true
signal interact


func _on_area_entered(_node: Node2D) -> void:
	if active:
		InteractManager.regist_interact(self)


func _on_area_exited(_node: Node2D) -> void:
	if active:
		InteractManager.unregist_interact(self)
