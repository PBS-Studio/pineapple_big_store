extends TabContainer


enum Menu{
	TextDisplay = 0, 
	FightMenu, 
	AttackBar, 
	AckMenu, 
	ItemMenu, 
	MercyMenu, 
}

@onready var audio_player = $AudioStreamPlayer
@onready var player_health = %PlayerHealthBar
@onready var last_press_bottom_button: Button = $"../Buttons/Fight"
var can_back_to_last_press_bottom_button: bool = true


# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass # Replace with function body.


func _on_visibility_changed(): 
	if not is_visible_in_tree(): 
		return

	can_back_to_last_press_bottom_button = true


# ==================================================
#region Buttons Zone
# ==================================================


func _on_fight_enter_menu(btn): 
	last_press_bottom_button = btn
	current_tab = Menu.FightMenu


func _on_act_enter_menu(btn): 
	last_press_bottom_button = btn
	current_tab = Menu.AckMenu


func _on_item_enter_menu(btn): 
	last_press_bottom_button = btn
	current_tab = Menu.ItemMenu


func _on_mercy_enter_menu(btn): 
	current_tab = Menu.MercyMenu
	last_press_bottom_button = btn


func _input(event): 
	if event.is_action_pressed("ui_cancel") and can_back_to_last_press_bottom_button and last_press_bottom_button != null: 
		last_press_bottom_button.grab_focus()
		last_press_bottom_button = null
		current_tab = Menu.TextDisplay
		audio_player.play()

#endregion


# ==================================================
#region Menu Zone
# ==================================================


# Attack fy
func _on_fy_selected(_id): 
	current_tab = Menu.AttackBar
	can_back_to_last_press_bottom_button = false

# use item
func _on_item_menu_item_select(item:UndertaleItem):
	current_tab = Menu.TextDisplay
	last_press_bottom_button.grab_focus()
	player_health.gain_health(item.restore_health)
	

#endregion


func _on_undertale_fight_player_turn(): 
	visible = true
	current_tab = Menu.TextDisplay
	last_press_bottom_button.grab_focus()
	last_press_bottom_button = null
	can_back_to_last_press_bottom_button = true

