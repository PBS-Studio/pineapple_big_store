extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_focus_entered():
	$Heart.visible = true


func _on_focus_exited():
	$Heart.visible = false


func _on_pressed():
	release_focus()
	%AttackBar.init_attack_bar()
