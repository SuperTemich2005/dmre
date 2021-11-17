extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var item_id = ""
var item_name = ""
var item_desc = ""
var restore_hp = 0
var restore_ip = 0
var restore_pp = 0
var special_event_description = ""
var special_event_name = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func set_item(pass_id):
	item_id = pass_id # defines everything
	item_name = tr("INV_ITEM_"+item_id.to_upper()) # define name
	item_desc = tr("INV_ITEM_"+item_id.to_upper()+"_DESC") # define description
	special_event_name = tr("INV_ITEM_"+item_id.to_upper()+"_SPEC") # define special event name to be used with special_event() function
	special_event_description = tr("INV_ITEM_"+item_id.to_upper()+"_SPEC_DESC") # describes special event for player
	restore_hp = int(tr("INV_ITEM_"+item_id.to_upper()+"_STATS").split(":")[1]) # bla
	restore_ip = int(tr("INV_ITEM_"+item_id.to_upper()+"_STATS").split(":")[2]) # bla
	restore_pp = int(tr("INV_ITEM_"+item_id.to_upper()+"_STATS").split(":")[3]) # bla


func special_event():
	match special_event_name:
		"test":
			get_parent().launch_diag("Bah!;GL_DIAG_NEXT")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
