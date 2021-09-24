extends Node2D

var health = 20
var maxhealth = 20
var evasion = 0.2
var entity_name = "Dummy"
var resonance = "C"
var recharge_rate = 0.005
var charge = 0
var target
var rng = RandomNumberGenerator.new()
var base_damage = 1
var description = """Debug hostile entity that doesn't appear in game, unless something weird happens\n
		Uses Temich's sprite because I don't want to spend time on drawing sprites nobody would ever see."""
onready var sprite = $Sprite

var attack_names = [
	"Attack",
	"Strong attack",
	"",
	"",
]

func attacks(id):
	print(get_parent().party_nodes)
	target = get_parent().party_nodes[rng.randi_range(0,-1+get_parent().party_nodes.size())]
	match id:
		_:
			print("1. Attacking ",target)
			target.health -= base_damage + rng.randi_range(1,3)