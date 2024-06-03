extends CharacterBody2D

@export var movement_speed=100.0
@export var hp=10
@export var knockback_recovery=3.5 #敵人從擊退狀態中恢復的速度
var knockback=Vector2.ZERO

@onready var player=get_tree().get_first_node_in_group("human_player")
@onready var anim=$AnimatedSprite2D
@onready var snd_hit=$snd_hit #Gram-schmidt

#Hit_once_array
signal  remove_from_array(object) 
#這個信號的作用是通知那些使用 HitOnce 模式的 hurt_box，從它們的 hit_once_array 中移除這個敵人。這樣當敵人重生或再次出現時，能夠重新計算傷害

#Player Related
var player_detection=0

#Enemy death
var death_anim=preload("res://a_way_home/Enemies/explosion.tscn")

func _ready():
	Bgm.stream_paused=true
	if player == null:
		print("Error: Player node is not found!")
	if anim == null:
		print("Error: AnimatedSprite2D node is not found!")

func _physics_process(delta):
	knockback= knockback.move_toward(Vector2.ZERO, knockback_recovery)
	#knockback 量從 knockback_recovery 遞減到 0向量
	
	var direction=global_position.direction_to(player.global_position)
	if direction.x>0:
		get_node("AnimatedSprite2D").flip_h=true
	elif direction.x<0:
		get_node("AnimatedSprite2D").flip_h=false
	if(player_detection==0):
		anim.play("idle")
	elif(player_detection==1):
		anim.play("attack")
	velocity=direction*movement_speed
	velocity+=knockback
	move_and_slide()

func death():
	emit_signal("remove_from_array",self) #發送刪除該敵人的訊號 給設定成 hit once 的hurt_box
	# anime explosion(death)
	var ghost_death=death_anim.instantiate()
	ghost_death.scale=anim.scale #設置死亡動畫的縮放比例與當前敵人的動畫縮放比例相同
	ghost_death.global_position= global_position #設置死亡動畫的位置與當前敵人的位置相同
	get_parent().call_deferred("add_child",ghost_death) 
	#使用 call_deferred 方法將死亡動畫添加到敵人的父節點中。這樣可以確保在當前所有邏輯執行完畢後再添加死亡動畫
	#---
	queue_free()
	

func _on_hurt_box_hurt(damage,angle,knockback_amount):
	hp-=damage
	knockback= angle * knockback_amount
	print("enemy :",hp)
	if hp<=0:
		death()
	else:
		print("play snd_hit")
		if hp>=5:
			snd_hit.play()
		


func _on_player_detection_area_body_entered(body):
	player_detection=1



func _on_player_detection_area_body_exited(body):
	player_detection=0
