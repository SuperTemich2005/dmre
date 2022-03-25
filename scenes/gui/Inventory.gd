extends Node2D
signal _on_Inventory_close_inv
onready var params = get_node("/root/Params")
var page = 0
func _ready():
	$Page1/Page.text = "1/"+str(1+ceil(params.inventory.size()/10))
	print(params.inventory)
	reload()


func reload():
	for i in $Page1/Items.get_children():
		i.hide()
	for i in range(0,clamp(params.inventory.size(),page*10,10+page*10)-page*10):
		$Page1/Items.get_child(i).text = tr(params.inventory[clamp(i+page*10,0,params.inventory.size()-1)])
		if $Page1/Items.get_child(i).text != "":
			$Page1/Items.get_child(i).show()


func _on_Close_pressed():
	emit_signal("_on_Inventory_close_inv")


func _on_NextPage_pressed():
	page = clamp(page+1,0,ceil(params.inventory.size()/10))
	$Page1/Page.text = str(page+1)+"/"+str(1+ceil(params.inventory.size()/10))
	reload()


func _on_PrevPage_pressed():
	page = clamp(page-1,0,ceil(params.inventory.size()/10))
	$Page1/Page.text = str(page+1)+"/"+str(1+ceil(params.inventory.size()/10))
	reload()


func _on_Back_pressed():
	$Page1.show()
	$Page2.hide()


func _on_ItemSlot_pressed():
	for i in range(0,$Page1/Items.get_child_count()):
		print(i)
		if $Page1/Items.get_child(i).pressed:
			print("AAAAAAAAAA")
			print(params.inventory[i+page*10]+"_WHATEVER")
			print(i," ",$Page1/Items.get_child(i).name)
			$Page2/IcoBG/Sprite.animation = params.inventory[i+page*10].to_lower()
			$Page2/ItemDescription.text = tr(params.inventory[i+page*10]+"_DESC")
			$Page2/RestoreHPbg/Param.text = tr(params.inventory[i+page*10]+"_STATS").split(":")[0]
			$Page2/RestorePPbg/Param.text = tr(params.inventory[i+page*10]+"_STATS").split(":")[1]
			$Page2/RestoreMPbg/Param.text = tr(params.inventory[i+page*10]+"_STATS").split(":")[2]
	$Page1.hide()
	$Page2.show()


func _on_Use_pressed():
	print("Use pressed")
	#get_parent().current_char.health = clamp(get_parent().current_char.health+int(tr($Page2/IcoBG/Sprite.animation.to_upper()+"_STATS").split(":")[0]),0,get_parent().current_char.maxhealth)
	#get_parent().current_char.powp = clamp(get_parent().current_char.powp+int(tr($Page2/IcoBG/Sprite.animation.to_upper()+"_STATS").split(":")[1]),0,5)
	#get_parent().current_char.insp = clamp(get_parent().current_char.insp+int(tr($Page2/IcoBG/Sprite.animation.to_upper()+"_STATS").split(":")[2]),0,get_parent().current_char.insp_max)
	if tr($Page2/IcoBG/Sprite.animation.to_upper()+"_STATS").split(":")[3] == "true":
		print("trying to deplete an item")
		print(params.inventory)
		for i in range(params.inventory.size()):
			if params.inventory[i] == $Page2/IcoBG/Sprite.animation.to_upper():
				print(params.inventory[i])
				params.inventory.remove(i)
				print(i)
				print(params.inventory)
				var save_file = ConfigFile.new()
				save_file.set_value("File"+str(params.current_savefile),"Inv",params.inventory.join(";"))
				save_file.save("C:/Games/AZIE Games/DMRER/savefile.save")
				_on_Back_pressed()
				reload()
