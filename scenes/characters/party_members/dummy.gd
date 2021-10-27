extends Node2D

var health = 30
var maxhealth = 200
var evasion = 0.2
var base_damage = 3
var power_damage = 2
var charge = 0
var recharge_rate = 0.005
var insp = 5
var insp_max = 5
var entity_name = "Dummy Friend"
var resonance = "C"
onready var sprite = $Sprite
var skills = [
	"Skillcast simple",
	"Skillcast simple2",
	"Skillcast simple3",
	"Skillcast simple4",
]


func skill(id):
	match id:
		1:
			print("Skillcast")
		2:
			print("Skillcast2")
		3:
			print("Skillcast3")
		4:
			print("Skillcast4")
