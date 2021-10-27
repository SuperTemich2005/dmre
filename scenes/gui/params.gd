extends Node2D
var current_savefile
var passed_enemies
var passed_party
var inventory
var savefile

func _ready():
	savefile = ConfigFile.new()
	print(savefile.load("C:/Games/AZIE Games/DMRER/savefile.save"))
	inventory = savefile.get_value("File"+str(current_savefile),"Inv","no inventory found wtf").split(";")
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
	inventory = savefile.get_value("File"+str(current_savefile),"Inv","no inventory found wtf").split(";")
