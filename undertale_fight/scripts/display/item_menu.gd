extends MarginContainer

signal item_select(item: UndertaleItem)

var list_item = preload("res://undertale_fight/scenes/list_item.tscn")

@onready var selection = $Selection


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visibility_changed():
	if not is_visible_in_tree():
		return

	for node in selection.get_children():
		node.free()

	var items = InventoryManager.inventory.filter(func(item): return item is UndertaleItem)
	for item in items:
		var list_item_node = list_item.instantiate()
		list_item_node.text = item.name
		list_item_node.id = item as UndertaleItem
		list_item_node.selected.connect(_selected)
		selection.add_child(list_item_node)

	var first = selection.get_child(0)
	if first != null:
		first.grab_focus()



func _selected(item: UndertaleItem):
	item_select.emit(item)
	InventoryManager.remove_item(item)
