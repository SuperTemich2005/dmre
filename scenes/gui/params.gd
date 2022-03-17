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
