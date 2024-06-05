extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var score = 0

func _ready():
	Bgm.stream_paused = true
	velocity.y = 100 
	update_score()
	
func completegame():
	Bgm.stream_paused = false
	#RpgManager.change_scene_and_tp("res://scenes/ccu_big_road.tscn","exitlittleroad")

func update_score():
	$Label.text = str(floori(score))

func _physics_process(delta):
	if score >= 100.0:
		completegame()
	if Input.is_action_just_pressed("p"):
		completegame()
	# Add the gravity.
	score += delta
	update_score()
	move_and_slide()


#func _on_burst_timeout():
	#velocity.y += 150
