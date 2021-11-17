extends Node2D
var current_savefile = 1
var passed_enemies
var passed_party
var inventory
var savefile
var condits

func _ready():
	savefile = ConfigFile.new()
	print(savefile.load("C:/Games/AZIE Games/DMRER/savefile.save"))
	inventory = savefile.get_value("File"+str(current_savefile),"Inv","no inventory found wtf;").split(";")
	condits = [false,true,false,true,false,false] # bliz heat rain heat mercy boss
	passed_enemies = [
		"dummy",
		"dummy2",
		"dummy",
	]
	passed_party = [
		"dummy",
		"dummy",
	]


func reloadInventory():
	print("reloading inventory")
	inventory = savefile.get_value("File"+str(current_savefile),"Inv","no inventory found wtf;").split(";")
	#if inventory[0] != null:


func updateInventory():
	var inventory_to_write = ""
	for i in inventory:
		inventory_to_write = inventory_to_write+i+";"
	print("updating inventory. current inventory: ",inventory_to_write)
	savefile.set_value("File"+str(current_savefile),"Inv",inventory_to_write)
	savefile.save("C:/Games/AZIE Games/DMRER/savefile.save")
