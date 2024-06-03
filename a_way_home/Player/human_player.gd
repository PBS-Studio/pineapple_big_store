extends CharacterBody2D

var movement_speed=200.0
var hp=80
@onready var anim=get_node("AnimatedSprite2D")

#Attacks
var pineapple_bomb=preload("res://a_way_home/Player/Attack/pineapple_bomb.tscn")

#AttackNodes
@onready var pineapple_bomb_Timer=get_node("%Pineapple_bomb_Timer")
@onready var pineapple_attack_Timer=get_node("%Pineapple_attack_Timer")
@onready var sword_hit_timer=$AnimatedSprite2D/SwordHit/Sword_hit_timer
@onready var animationPlayer=$AnimationPlayer

#Pineapple_bomb
var pineapple_bomb_ammo=0
var pineapple_bomb_baseammo=1
@export var pineapple_bomb_attackspeed=1.5 #設定攻擊間隔
var pineapple_bome_level=1

#Sword Hit
var sword_hit_damage=5
@export var sword_hit_attackspeed=5 #second
var sword_hit_level=1
var sword_hitting=0


#Enemy Related
var enemy_close =[] #store enemy that is closing

func _ready():
	anim.play("run")
	attack()
	#連接Sword_hit_timer 
	sword_hit_timer.connect("timeout",Callable(self,"trigger_sword_hit"))
	

func _physics_process(delta):
	movement()

var mov =Vector2.ZERO
var lastMovement
func movement():
	var x_mov =Input.get_axis("ui_left", "ui_right")
	if x_mov==1:
		get_node("AnimatedSprite2D").flip_h=false
	elif x_mov==-1:
		get_node("AnimatedSprite2D").flip_h=true
	var y_mov =Input.get_axis("ui_up", "ui_down")
	mov=Vector2(x_mov,y_mov)
	velocity = mov.normalized()*movement_speed
	move_and_slide()
	
	#print(mov)
	#print("sword hitting: ",sword_hitting)
	# 播放相應的動畫
	if(sword_hitting==0):
		if mov.x > 0 and mov.y==0:
			#anim.flip_h=false
			lastMovement="right"
			anim.play("run")
		elif mov.x < 0 and mov.y==0:
			#anim.flip_h=true
			lastMovement="left"
			anim.play("run")
		elif mov.y > 0:
			lastMovement="down"
			anim.play("down")
		elif mov.y < 0:
			lastMovement="up"
			anim.play("up")
		
	#elif(sword_hitting==1):
		#animationPlayer.play("slash_down")
		
	#else:
		## 如果沒有移動，停止動畫播放器中的動畫
		#anim.play("down")

func attack():
	if pineapple_bome_level>0:
		pineapple_bomb_Timer.wait_time=pineapple_bomb_attackspeed
		if pineapple_bomb_Timer.is_stopped():
			pineapple_bomb_Timer.start()
	#Sword hit
	if sword_hit_level>0:
		sword_hit_timer.wait_time=sword_hit_attackspeed
		if sword_hit_timer.is_stopped():
			sword_hit_timer.start()
			print("sword_hit_start")

func _on_hurt_box_hurt(damage, _angle, _knockback): # 參數加上 "_" 告訴自己目前沒用到這個參數
	hp-=damage
	print(hp)


func _on_pineapple_bomb_timer_timeout():
	pineapple_bomb_ammo+=pineapple_bomb_baseammo
	pineapple_attack_Timer.start()


func _on_pineapple_attack_timer_timeout():
	if pineapple_bomb_ammo>0:
		var pineapple_attack=pineapple_bomb.instantiate()
		pineapple_attack.position=position
		pineapple_attack.target=get_random_target()
		pineapple_attack.level=pineapple_bome_level
		add_child(pineapple_attack)
		pineapple_bomb_ammo-=1
		if pineapple_bomb_ammo>0:
			pineapple_attack_Timer.start()
		else:
			pineapple_attack_Timer.stop()

	
		
func get_random_target():
	if enemy_close.size()>0: #enemy appear
		return enemy_close.pick_random().global_position # 回傳位置
	else:
		return Vector2.UP
		
		
		


func _on_enemy_detection_area_body_entered(body): #偵測到敵人
	if not enemy_close.has(body): #list中若無此敵人
		enemy_close.append(body) #把此敵人放進list 

func _on_enemy_detection_area_body_exited(body): #敵人離開偵測區域
	if enemy_close.has(body):
		enemy_close.erase(body)
	


#func _on_sword_hit_area_entered(body):
	#if area.is_in_group("attack"): # 確認進入區域的物件是敵人

func trigger_sword_hit():
	if sword_hit_timer.timeout:
		sword_hit_timer.start()
		#print("sword_hit_start")
		sword_hitting=1
		if lastMovement=="right": 
			animationPlayer.play("slash_right")
		elif lastMovement=="left":
			animationPlayer.play("slash_left")
		elif lastMovement=="up": #up
			animationPlayer.play("slash_up")
		elif lastMovement=="down":
			animationPlayer.play("slash_down")
		await animationPlayer.animation_finished
		sword_hitting=0
		
		
		

#func _on_sword_hit_timer_timeout():
	#sword_hit_timer.start()


