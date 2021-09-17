extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var enemies
var enemy_nodes : Array
var party
var party_nodes : Array
func _ready():
	enemies = $"/root/Params".passed_enemies
	party = $"/root/Params".passed_party
	for i in range(0,enemies.size()):
		get_node("CameraRail/CameraRailFollow/Control/UpperHalf/EnemyUnit"+str(i+1)).show()
		enemy_nodes.append(load("res://scenes/characters/enemies/"+enemies[i].split("|")[0]+".tscn").instance())
		add_child_below_node($Enemies,enemy_nodes[i])
		print("Added node ",enemy_nodes[i]," called ",enemies[i].split("|")[0]," as enemy #",str(i))
		enemy_nodes[i].position = Vector2(1024/2*i,0)
		get_node("CameraRail/CameraRailFollow/Control/UpperHalf/EnemyUnit"+str(i+1)+"/Pic").animation = enemies[i].split("|")[0]
		get_node("CameraRail/CameraRailFollow/Control/UpperHalf/EnemyUnit"+str(i+1)+"/Name").text = enemies[i].split("|")[1]
		get_node("CameraRail/CameraRailFollow/Control/UpperHalf/EnemyUnit"+str(i+1)+"/HP").set_max(float(enemies[i].split("|")[2]))
		get_node("CameraRail/CameraRailFollow/Control/UpperHalf/EnemyUnit"+str(i+1)+"/HP").set_value(float(enemies[i].split("|")[2]))
		get_node("CameraRail/CameraRailFollow/Control/UpperHalf/EnemyUnit"+str(i+1)+"/HP/Label").text = enemies[i].split("|")[2]+"/"+enemies[i].split("|")[2]
	for i in range(0,party.size()):
		get_node("CameraRail/CameraRailFollow/Control/UpperHalf/FriendUnit"+str(i+1)).show()
		party_nodes.append(load("res://scenes/characters/party_members/"+party[i].split("|")[0]+".tscn").instance())
		add_child_below_node($Characters,party_nodes[i])
		print("Added node ",party_nodes[i]," called ",party[i].split("|")[0]," as party member #",str(i))
		party_nodes[i].position = Vector2(1024/4*i,0)
		get_node("CameraRail/CameraRailFollow/Control/UpperHalf/FriendUnit"+str(i+1)+"/Pic").animation = party[i].split("|")[0]
		get_node("CameraRail/CameraRailFollow/Control/UpperHalf/FriendUnit"+str(i+1)+"/Name").text = party[i].split("|")[1]
		get_node("CameraRail/CameraRailFollow/Control/UpperHalf/FriendUnit"+str(i+1)+"/HP").set_max(float(party[i].split("|")[2]))
		get_node("CameraRail/CameraRailFollow/Control/UpperHalf/FriendUnit"+str(i+1)+"/HP").set_value(float(party[i].split("|")[2]))
		get_node("CameraRail/CameraRailFollow/Control/UpperHalf/FriendUnit"+str(i+1)+"/HP/Label").text = party[i].split("|")[2]+"/"+party[i].split("|")[2]		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
