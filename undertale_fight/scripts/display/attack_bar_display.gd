extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_visibility_changed():
	if not is_visible_in_tree():
		return
	
	$AttackBar.init_attack_bar()
