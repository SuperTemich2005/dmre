extends Node2D
var current_savefile
var passed_enemies
var passed_party

func _ready():
	passed_enemies = [
		"dummy|Dummy|20",
		"dummy|Dummy|10",
		"dummy|Dummy|30",
	]
	passed_party = [
		"temich|Temich|20",
		"temich|Temich|10",
	]
