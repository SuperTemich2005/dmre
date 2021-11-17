extends Node2D

var health = 20
var maxhealth = 20
var evasion = 0.2
var entity_name = "Dummy"
var resonance = "C"
var recharge_rate = 0.005
var charge = 0
var target
var is_enemy = true
var rng = RandomNumberGenerator.new()
var base_damage = 1
var description = """Debug hostile entity that doesn't appear in game, unless something weird happens\n
		Uses Temich's sprite because I don't want to spend time on drawing sprites nobody would ever see."""
onready var sprite = $Sprite
var givesxp = 1

var attack_names = [
	"Attack",
	"Strong attack",
	"",
	"",
]

func attacks(id):
	print(get_parent().party_nodes)
	target = get_parent().party_nodes[rng.randi_range(0,-1+get_parent().party_nodes.size())]
	var att = 0
	while target.health <= 0 and att < 10:
		target = get_parent().party_nodes[rng.randi_range(0,-1+get_parent().party_nodes.size())]
		print("whoops, dead target. retargeting, new target: ",target)
		att+=1
	match id:
		_:
			print("1. Attacking ",target)
			target.health = clamp(target.health-base_damage-rng.randi_range(1,3),0,target.maxhealth)
	target.get_node("Sprite").animation = "damage"
	if target.health <= 0:
		target.get_node("Sprite").animation = "down"
