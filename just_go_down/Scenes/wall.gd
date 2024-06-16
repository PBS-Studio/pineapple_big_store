extends CharacterBody2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var score = 0
var iscomplte = false
func _ready():
	Bgm.stream_paused = true
	$justgodownbgm.stream_paused = false
	velocity.y = 100 
	update_score()
	
func completegame():
	iscomplte = true
	Bgm.stream_paused = false
	RpgManager.change_scene_and_tp("big_road","ExitCollegeRoad")

func update_score():
	$Label.text = str(floori(score))

func _physics_process(delta):
	if score >= 100.0 and !iscomplte:
		completegame()
	if Input.is_action_just_pressed("p"):
		completegame()
	# Add the gravity.
	score += delta
	update_score()
	move_and_slide()


#func _on_burst_timeout():
	#velocity.y += 150
