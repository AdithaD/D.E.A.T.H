extends Node2D

export (int) var segment_size = 5

onready var actionbar = $ActionFull
onready var actionbarempty = $ActionEmpty

var max_action_points = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if(get_parent() and get_parent().get("actions_points_per_turn")):
		max_action_points = get_parent().actions_points_per_turn
	
	actionbarempty.rect_size.x = max_action_points * segment_size
	update()
	
func update():
	if get_parent() and (get_parent().get("action_points") != null):
		if(get_parent().action_points <= 0):
			actionbar.visible = false
			actionbarempty.visible = false
		else:
			actionbar.visible = true
			actionbarempty.visible = true
			actionbar.rect_size.x = get_parent().action_points * segment_size

func _on_Unit_update_attr():
	update()
	pass
