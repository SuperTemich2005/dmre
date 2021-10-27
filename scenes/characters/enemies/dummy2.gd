extends Node2D

var health = 20
var maxhealth = 20
var evasion = 0.2
var entity_name = "Dummy 2"
var resonance = "C"
var description = """Second debug entity that strikes faster, than first dummy"""
var recharge_rate = 0.01
var can_attack = true
var charge = 0
var target
var is_enemy = true
var rng = RandomNumberGenerator.new()
var base_damage = 3
onready var sprite = $Sprite

var attack_names = [
	"Attack",
	"Strong attack",
	"",
	"",
]

func attacks(id):
	target = get_parent().party_nodes[rng.randi_range(0,-1+get_parent().party_nodes.size())]
	var att = 0
	while target.health <= 0 and att < 10:
		target = get_parent().party_nodes[rng.randi_range(0,-1+get_parent().party_nodes.size())]
		print("whoops, dead target. retargeting, new target: ",target)
		att+=1
	print("Dummy 2 uses shared move")
	match id:
		1:
			print("1. Attacking ",target)
			target.health = clamp(target.health-base_damage-rng.randi_range(1,3),0,target.maxhealth)
		2:
			print("1. Attacking ",target)
		3:
			print("1. Attacking ",target)
		4:
			print("1. Attacking ",target)
