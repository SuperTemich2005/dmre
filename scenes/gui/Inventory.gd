extends Node2D
signal close_inv
signal use_item


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var selected_ent
var selected_ent_restore_hp = 0
var selected_ent_restore_pp = 0
var selected_ent_restore_mp = 0
var selected_ent_spec_event
var page
# Called when the node enters the scene tree for the first time.
func _ready():
	page = 0
	for i in range(0,clamp(10,0,$"/root/Params".inventory.size())):
		get_node("Page1/Items/ItemSlot"+str(i+1)).text = $"/root/Params".inventory[i].split("|")[0]
		if get_node("Page1/Items/ItemSlot"+str(i+1)).text != "":
			get_node("Page1/Items/ItemSlot"+str(i+1)).show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ItemSlot_pressed():
	for i in range(0,$Page1/Items.get_child_count()):
		if $Page1/Items.get_child(i).pressed:
			selected_ent = i+page*10
			$Page2.show()
			$Page2/SelItemName.text = $"/root/Params".inventory[selected_ent].split("|")[0]
			$IcoBG/Sprite.animation = $"/root/Params".inventory[selected_ent].split("|")[2]
			$Page2/ItemDescription.text = $"/root/Params".inventory[selected_ent].split("|")[1]
			$Page2/RestoreHPbg/Param.text = $"/root/Params".inventory[selected_ent].split("|")[3]
			$Page2/RestoreMPbg/Param.text = $"/root/Params".inventory[selected_ent].split("|")[4]
			$Page2/RestorePPbg/Param.text = $"/root/Params".inventory[selected_ent].split("|")[5]
			selected_ent_restore_hp = int($"/root/Params".inventory[selected_ent].split("|")[3])
			selected_ent_restore_mp = int($"/root/Params".inventory[selected_ent].split("|")[4])
			selected_ent_restore_pp = int($"/root/Params".inventory[selected_ent].split("|")[5])
			$Page1.hide()


func _on_NextPage_pressed():
	page = clamp(page+1,0,4)
	$Page1/Page.text = str(page+1)+"/5"
	for i in range(0,$Page1/Items.get_child_count()):
		$Page1/Items.get_child(i).hide()
	for i in range(page*10,clamp(10+page*10,0,$"/root/Params".inventory.size())):
		get_node("Page1/Items/ItemSlot"+str(i+1-page*10)).text = $"/root/Params".inventory[i].split("|")[0]
		if get_node("Page1/Items/ItemSlot"+str(i+1-page*10)).text != "":
			get_node("Page1/Items/ItemSlot"+str(i+1-page*10)).show()


func _on_PrevPage_pressed():
	page = clamp(page-1,0,4)
	$Page1/Page.text = str(page+1)+"/5"
	for i in range(0,$Page1/Items.get_child_count()):
		$Page1/Items.get_child(i).hide()
	for i in range(page*10,clamp(10+page*10,0,$"/root/Params".inventory.size())):
		get_node("Page1/Items/ItemSlot"+str(i+1-page*10)).text = $"/root/Params".inventory[i].split("|")[0]
		if get_node("Page1/Items/ItemSlot"+str(i+1-page*10)).text != "":
			get_node("Page1/Items/ItemSlot"+str(i+1-page*10)).show()


func _on_Use_pressed():
	emit_signal("use_item")
	if $"/root/Params".inventory[selected_ent].split("|")[7] == "true":
		$"/root/Params".inventory.remove(selected_ent)
		print("Disposing of ",selected_ent)
		$Page1/Page.text = str(page+1)+"/5"
		for i in range(0,$Page1/Items.get_child_count()):
			$Page1/Items.get_child(i).hide()
		for i in range(page*10,clamp(10+page*10,0,$"/root/Params".inventory.size())):
			get_node("Page1/Items/ItemSlot"+str(i+1-page*10)).text = $"/root/Params".inventory[i].split("|")[0]
			if get_node("Page1/Items/ItemSlot"+str(i+1-page*10)).text != "":
				get_node("Page1/Items/ItemSlot"+str(i+1-page*10)).show()
	else:
		pass


func _on_Back_pressed():
	$Page1.show()
	$Page2.hide()


func _on_Close_pressed():
	emit_signal("close_inv")
