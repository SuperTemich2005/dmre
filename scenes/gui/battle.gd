extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


const PATH_TO_NOTIFICATION = "CameraRail/CameraRailFollow/Control/UpperHalf/Notification"
const PATH_TO_FRIEND_UNIT = "CameraRail/CameraRailFollow/Control/UpperHalf/FriendUnit"
const PATH_TO_ENEMY_UNIT = "CameraRail/CameraRailFollow/Control/UpperHalf/EnemyUnit"
onready var note_a = load("res://music/fx/gui/note_a.ogg")
onready var note_b = load("res://music/fx/gui/note_b.ogg")
onready var note_c = load("res://music/fx/gui/note_c.ogg")
onready var note_d = load("res://music/fx/gui/note_d.ogg")
onready var note_e = load("res://music/fx/gui/note_e.ogg")
onready var note_f = load("res://music/fx/gui/note_f.ogg")
onready var note_g = load("res://music/fx/gui/note_g.ogg")
var enemies # Массив для хранения врагов
var enemy_nodes : Array # Массив для хранения нод врагов
var party # Массив для хранения ГГ
var party_nodes : Array # И их нод
var current_char
var current_char_id
var camera_pos = 0 # Позиция камеры 0-1.0
var camera_direction = true # Направление камеры. true = вправо
var targeted_entity
var targeted_entity_id
var rng = RandomNumberGenerator.new()
var curmode = "Base"
onready var ongaku = $Ongaku
onready var noteworthy = $CameraRail/CameraRailFollow/Control/LowerHalf/OngakuCast/NoteCarrier
func _ready():
	TranslationServer.set_locale("en")
	enemies = $"/root/Params".passed_enemies
	party = $"/root/Params".passed_party
	# СОЗДАНИЕ ВРАГОВ ----------------------------------------------------------
	for i in range(0,enemies.size()):
		get_node(PATH_TO_ENEMY_UNIT+str(i+1)).show()
		enemy_nodes.append(load("res://scenes/characters/enemies/"+enemies[i].split("|")[0]+".tscn").instance())
		add_child_below_node($Enemies,enemy_nodes[i])
		print("Added node ",enemy_nodes[i]," called ",enemies[i].split("|")[0]," as enemy #",str(i))
		enemy_nodes[i].position = Vector2(1280/enemies.size()*i,0)
		get_node(PATH_TO_ENEMY_UNIT+str(i+1)+"/Pic").animation = enemies[i].split("|")[0]
		get_node(PATH_TO_ENEMY_UNIT+str(i+1)+"/Name").text = enemy_nodes[i].entity_name
		get_node(PATH_TO_ENEMY_UNIT+str(i+1)+"/HP").set_max(float(enemy_nodes[i].maxhealth))
		get_node(PATH_TO_ENEMY_UNIT+str(i+1)+"/HP").set_value(float(enemy_nodes[i].maxhealth))
		get_node(PATH_TO_ENEMY_UNIT+str(i+1)+"/HP/Label").text = str(enemy_nodes[i].maxhealth)+"/"+str(enemy_nodes[i].maxhealth)
		get_node("CameraRail/CameraRailFollow/Control/LowerHalf/EnemySelector/enemy_"+str(i+1)).text = enemy_nodes[i].entity_name
		if get_node("CameraRail/CameraRailFollow/Control/LowerHalf/EnemySelector/enemy_"+str(i+1)).text != "":
			get_node("CameraRail/CameraRailFollow/Control/LowerHalf/EnemySelector/enemy_"+str(i+1)).show()
	# СОЗДАНИЕ ГЛАВНЫХ ГЕРОЕВ --------------------------------------------------
	for i in range(0,party.size()):
		get_node(PATH_TO_FRIEND_UNIT+str(i+1)).show()
		party_nodes.append(load("res://scenes/characters/party_members/"+party[i].split("|")[0]+".tscn").instance())
		add_child_below_node($Characters,party_nodes[i])
		print("Added node ",party_nodes[i]," called ",party[i].split("|")[0]," as party member #",str(i))
		party_nodes[i].position = Vector2(1280/party.size()*i,0)
		get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/Pic").animation = party[i].split("|")[0]
		get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/Name").text = party_nodes[i].entity_name
		get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/HP").set_max(float(party_nodes[i].maxhealth))
		get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/HP").set_value(float(party_nodes[i].maxhealth))
		get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/HP/Label").text = str(party_nodes[i].maxhealth)+"/"+str(party_nodes[i].maxhealth)
		get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/IP").set_max(float(party_nodes[i].insp_max))
		get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/IP").set_value(float(party_nodes[i].insp))
		get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/IP/Label").text = str(party_nodes[i].insp)+"/"+str(party_nodes[i].insp_max)
		get_node("CameraRail/CameraRailFollow/Control/LowerHalf/FriendSelector/friend_"+str(i+1)).text = party_nodes[i].entity_name
		if get_node("CameraRail/CameraRailFollow/Control/LowerHalf/FriendSelector/friend_"+str(i+1)).text != "":
			get_node("CameraRail/CameraRailFollow/Control/LowerHalf/FriendSelector/friend_"+str(i+1)).show()
	current_char = party_nodes[0]
	current_char_id = 1
	targeted_entity = enemy_nodes[0]
	targeted_entity_id = 1
	alert("attention","Банда кукол нападает!",2)
	# СОЗДАНИЕ ЭФФЕКТОВ --------------------------------------------------------
	for k in $"/root/Params".condits.size():
		if $"/root/Params".condits[k]:
			pass
		else:
			$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions.get_child(k).hide()
	# ИНТРО ПОНТЫ --------------------------------------------------------------
	launch_diag(tr("BATTLE_INTRO"+str(rng.randi_range(0,10)))+";"+tr("GL_DIAG_NEXT"),Color(1,1,1,1),2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# УТИЛИТЫ ----------------------------------------------------------------------
func endfight(res):
	if res == "ls": # проиграно
		pass
	elif res == "wn": # выиграно
		pass
	elif res == "sp": # пощажено
		pass


func note_to_ypos(note):
	print("Passed ",note," to note_to_ypos") 
	match note:
		"C":
			return 176
		"D":
			return 170
		"E":
			return 144
		"F":
			return 128
		"G":
			return 104
		"A":
			return 88
		"B":
			return 72


func chord_to_id(chord):
	match chord:
		"A":
			return 0
		"B":
			return 1
		"C":
			return 2
		"D":
			return 3
		"E":
			return 4
		"F":
			return 5
		"G":
			return 6


func _on_entity_selector_button_pressed():
	if curmode != "Info":
		for i in range(0,$CameraRail/CameraRailFollow/Control/LowerHalf/EnemySelector.get_children().size()):
			if $CameraRail/CameraRailFollow/Control/LowerHalf/EnemySelector.get_children()[i].pressed:
				targeted_entity = enemy_nodes[i]
				targeted_entity_id = i+1
				$Chevron.position = Vector2(enemy_nodes[targeted_entity_id-1].sprite.position.x,64)
				print(enemy_nodes[targeted_entity_id-1].sprite)
				#targeted_entity.modulate = Color(1,0,0)
				print("Selecting enemy ",targeted_entity," self-named ",targeted_entity.entity_name," under ID of ",targeted_entity_id)
				break
		for i in range(0,$CameraRail/CameraRailFollow/Control/LowerHalf/FriendSelector.get_children().size()):
			if $CameraRail/CameraRailFollow/Control/LowerHalf/FriendSelector.get_children()[i].pressed:
				current_char = party_nodes[i]
				current_char_id = i+1
				#$Chevron.position = Vector2(targeted_entity.sprite.position.x,64)
				print("Selecting party member ",targeted_entity," self-named ",targeted_entity.entity_name," under ID of ",targeted_entity_id)
				break
	else:
		for i in range(0,$CameraRail/CameraRailFollow/Control/LowerHalf/EnemySelector.get_children().size()):
			if $CameraRail/CameraRailFollow/Control/LowerHalf/EnemySelector.get_children()[i].pressed:
				targeted_entity = enemy_nodes[i]
				targeted_entity_id = i+1
				launch_diag(targeted_entity.description+";"+tr("GL_DIAG_NEXT"),Color(1,1,1,1),2)
				$CameraRail/CameraRailFollow/Control/LowerHalf/EnemySelector.hide()
				$CameraRail/CameraRailFollow/Control/LowerHalf/CheckButtons.hide()
				$CameraRail/CameraRailFollow/Control/LowerHalf/Dialogue.show()
				$CameraRail/CameraRailFollow/Control/LowerHalf/Dialogue/ShowText.text = targeted_entity.description
				break


func _on_Back_pressed():
	$CameraRail/CameraRailFollow/Control/LowerHalf/AttackOptions.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/EnemySelector.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/FriendSelector.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/Dialogue.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/OngakuCast.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/FightButtons.show()
	$CameraRail/CameraRailFollow/Control/LowerHalf/ActionOptions.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/CheckButtons.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/Skills.hide()
	curmode = "Base"
	$BGM.volume_db = 0


func alert(mode,text,dur):
	pass # todo: в пизду


func launch_diag(textts,col,ops):
	curmode = "Dialogue"
	$CameraRail/CameraRailFollow/Control/LowerHalf/Dialogue.show()
	$CameraRail/CameraRailFollow/Control/LowerHalf/Dialogue/ShowText.text = textts.split(";")[0]
	for i in range(1,ops):
		print("showing ",i)
		get_node("CameraRail/CameraRailFollow/Control/LowerHalf/Dialogue/Options/option_"+str(i)).show()
		get_node("CameraRail/CameraRailFollow/Control/LowerHalf/Dialogue/Options/option_"+str(i)).text = textts.split(";")[i]


func _on_option_pressed():
	var bat_accept_mercy = tr("BAT_ACCEPT_MERCY")
	var bat_cont_fight = tr("BAT_CONT_FIGHT")
	var bat_next = tr("GL_DIAG_NEXT")
	for i in $CameraRail/CameraRailFollow/Control/LowerHalf/Dialogue/Options.get_children():
		if i.pressed:
			match i.text:
				bat_accept_mercy:
					endfight("sp")
				bat_cont_fight:
					_on_Back_pressed()
					$CameraRail/CameraRailFollow/Control/LowerHalf/ActionOptions/Beg.free()
				bat_next:
					_on_Back_pressed()


# ДЕЙСТВИЕ ---------------------------------------------------------------------
func _on_Beg_pressed():
	if rng.randi_range(0,2) == 0:
		launch_diag(tr("BAT_BEG_SUCCESS"+str(rng.randi_range(1,5)))+";"+tr("BAT_ACCEPT_MERCY"),Color(1,1,1,1),2)
	else:
		launch_diag(tr("BAT_BEG_FAILURE"+str(rng.randi_range(1,5)))+";"+tr("BAT_CONT_FIGHT"),Color(1,1,1,1),2)


func _on_Inventory_close_inv():
	curmode = "Base"
	$CameraRail/CameraRailFollow/Control/LowerHalf/Inventory.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/FriendSelector.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/FightButtons.show()


func _on_Item_pressed():
	curmode = "Inv"
	$CameraRail/CameraRailFollow/Control/LowerHalf/FightButtons.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/FriendSelector.show()
	$CameraRail/CameraRailFollow/Control/LowerHalf/Inventory.show()


func _on_Inventory_use_item():
	current_char.health += $CameraRail/CameraRailFollow/Control/LowerHalf/Inventory.selected_ent_restore_hp
	current_char.powp += $CameraRail/CameraRailFollow/Control/LowerHalf/Inventory.selected_ent_restore_pp
	current_char.insp += $CameraRail/CameraRailFollow/Control/LowerHalf/Inventory.selected_ent_restore_mp
	get_node(PATH_TO_FRIEND_UNIT+str(current_char_id)+"/HP").value = current_char.health
	get_node(PATH_TO_FRIEND_UNIT+str(current_char_id)+"/HP/Label").text = str(current_char.health)
	get_node(PATH_TO_FRIEND_UNIT+str(current_char_id)+"/IP").value = current_char.insp
	get_node(PATH_TO_FRIEND_UNIT+str(current_char_id)+"/IP/Label").text = str(current_char.insp)
	get_node(PATH_TO_FRIEND_UNIT+str(current_char_id)+"/PPBG/PPFG/PP").text = str(current_char.powp)


func _on_Info_pressed():
	$CameraRail/CameraRailFollow/Control/LowerHalf/FightButtons.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/ActionOptions.show()
	curmode = "Info"


func _on_Check_pressed():
	$CameraRail/CameraRailFollow/Control/LowerHalf/EnemySelector.show()
	#$CameraRail/CameraRailFollow/Control/LowerHalf/FriendSelector.show()
	$CameraRail/CameraRailFollow/Control/LowerHalf/CheckButtons.show()
	$CameraRail/CameraRailFollow/Control/LowerHalf/ActionOptions.hide()


func _on_Skill_pressed():
	$CameraRail/CameraRailFollow/Control/LowerHalf/ActionOptions.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/Skills.show()
	for i in range(1,current_char.skills.size()+1):
		$CameraRail/CameraRailFollow/Control/LowerHalf/Skills.get_child(i-1).show()
		$CameraRail/CameraRailFollow/Control/LowerHalf/Skills.get_child(i-1).text = current_char.skills[i-1]
		$CameraRail/CameraRailFollow/Control/LowerHalf/Skills/Back.show()


func _on_SkillButton_pressed():
	for i in range(1,$CameraRail/CameraRailFollow/Control/LowerHalf/Skills.get_child_count()):
		if $CameraRail/CameraRailFollow/Control/LowerHalf/Skills.get_child(i-1).pressed:
			current_char.skill(i)


# АТАКА ------------------------------------------------------------------------
func _on_Attack_pressed():
	$CameraRail/CameraRailFollow/Control/LowerHalf/FightButtons.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/AttackOptions.show()
	curmode = "Attack"


func _on_SelectThis_pressed():
	for i in range(1,5):
		if get_node(PATH_TO_FRIEND_UNIT+str(i)+"/SelectThis").pressed:
			current_char = party_nodes[i-1]
			current_char_id = i
			print("Selecting ",current_char," which is the ",i,"nd")


func _on_OngakuCast_pressed():
	$CameraRail/CameraRailFollow/Control/LowerHalf/AttackOptions.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/EnemySelector.show()
	$CameraRail/CameraRailFollow/Control/LowerHalf/FriendSelector.show()
	$CameraRail/CameraRailFollow/Control/LowerHalf/OngakuCast.show()
	$BGM.volume_db = -10


func _on_ChordCast_pressed():
	$CameraRail/CameraRailFollow/Control/LowerHalf/AttackOptions.hide()
	$CameraRail/CameraRailFollow/Control/LowerHalf/EnemySelector.show()
	$CameraRail/CameraRailFollow/Control/LowerHalf/FriendSelector.show()
	$CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector.show()


func _on_PowerCast_toggled(button_pressed):
	if button_pressed:
		for i in range(get_node("CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector/Chords").get_children().size()):
			get_node("CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector/Chords").get_child(i).text = get_node("CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector/Chords").get_child(i).text+"5"
	else:
		for i in range(get_node("CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector/Chords").get_children().size()):
			get_node("CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector/Chords").get_child(i).text = get_node("CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector/Chords").get_child(i).text.left(1)


func _on_chordbutton_pressed():
	var played_chord 
	if current_char.insp > 0:
		for i in range(0,$CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector/Chords.get_children().size()):
			if $CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector/Chords.get_children()[i].pressed or Input.is_action_just_pressed("number_"+str(i+1)):
				played_chord = chord_to_id($CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector/Chords.get_children()[i].text.left(1))
				print("Playing chord ",$CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector/Chords.get_children()[i].text," with ID of ",played_chord)
				print("Attacking ",targeted_entity.entity_name)
				print("Target's resonance ID: ",chord_to_id(targeted_entity.resonance))
				print("Dealt ",(current_char.base_damage+current_char.power_damage*int($CameraRail/CameraRailFollow/Control/LowerHalf/AttackOptions/PowerCast.pressed))/(1+abs(played_chord-chord_to_id(targeted_entity.resonance))))
				targeted_entity.health = clamp(targeted_entity.health-(-int($"/root/Params".condits[3])+current_char.base_damage+current_char.power_damage*int($CameraRail/CameraRailFollow/Control/LowerHalf/AttackOptions/PowerCast.pressed))/(1+abs(played_chord-chord_to_id(targeted_entity.resonance))),0,targeted_entity.maxhealth)
				print(targeted_entity.health)
				get_node(PATH_TO_ENEMY_UNIT+str(targeted_entity_id)+"/HP").set_value(targeted_entity.health)
				get_node(PATH_TO_ENEMY_UNIT+str(targeted_entity_id)+"/HP/Label").text = str(targeted_entity.health)+"/"+str(targeted_entity.maxhealth)
				current_char.insp-=1
				current_char.charge = 0
				get_node(PATH_TO_FRIEND_UNIT+str(current_char_id)+"/IP").set_value(float(current_char.insp))
				get_node(PATH_TO_FRIEND_UNIT+str(current_char_id)+"/IP/Label").text = str(current_char.insp)+"/"+str(current_char.insp_max)
				current_char.get_node("Sprite").animation = "strike_chord"
				current_char.get_node("Sprite").frame = 0
				for k in range(1,1+$Enemies.get_child_count()):
					if $Enemies.get_child(k).health <= $Enemies.get_child(k).maxhealth/4:
						print($Enemies.get_child(k).entity_name)
						alert("attention","У "+$Enemies.get_child(k).entity_name+" мало ХП!",5)


func _on_Note_pressed():
	for i in range(noteworthy.get_child_count()):
		if noteworthy.get_child(i).pressed or Input.is_action_just_pressed("number_"+str(i+1)):
			print("Current sequence is ",ongaku.current_seq)
			ongaku.current_seq = ongaku.current_seq+noteworthy.get_child(i).text[2]
			ongaku.cast(ongaku.current_seq,targeted_entity,current_char)
			current_char.insp -= ongaku.demand
			get_node(PATH_TO_FRIEND_UNIT+str(current_char_id)+"/IP").set_value(float(current_char.insp))
			get_node(PATH_TO_FRIEND_UNIT+str(current_char_id)+"/IP/Label").text = str(current_char.insp)+"/"+str(current_char.insp_max)
			get_node(PATH_TO_ENEMY_UNIT+str(targeted_entity_id)+"/HP").set_value(targeted_entity.health)
			get_node(PATH_TO_ENEMY_UNIT+str(targeted_entity_id)+"/HP/Label").text = str(targeted_entity.health)+"/"+str(targeted_entity.maxhealth)
			print(ongaku.cur_seq_len())
			$PickedString.set_stream(load("res://music/fx/gui/note_"+noteworthy.get_child(i).text[2]+".ogg"))
			$PickedString.play()
			current_char.get_node("Sprite").animation = "pick_string"
			current_char.get_node("Sprite").frame = 0
			if ongaku.cur_seq_len() != 0:
				get_node("CameraRail/CameraRailFollow/Control/LowerHalf/OngakuCast/Notes/Note"+str(ongaku.cur_seq_len())).rect_position = Vector2(344+ongaku.cur_seq_len()*40,note_to_ypos(noteworthy.get_child(i).text[2]))
			else:
				for k in range(1,13):
					get_node("CameraRail/CameraRailFollow/Control/LowerHalf/OngakuCast/Notes/Note"+str(k)).rect_position = Vector2(0,0)


# КАМЕРЫ И ВРЕМЯ ---------------------------------------------------------------
func _on_TurnCamera_pressed():
	$CameraRail/CameraRailFollow/Control/TurnCamera/CameraTurnTick.start()
	camera_direction = !camera_direction


func _on_CameraTurnTick_timeout():
	if camera_direction:
		camera_pos -= 0.01
		if camera_pos > 0:
			$CameraRail/CameraRailFollow.set_unit_offset(camera_pos)
		else:
			$CameraRail/CameraRailFollow/Control/TurnCamera/CameraTurnTick.stop()
	else:
		camera_pos += 0.01
		if camera_pos < 1:
			$CameraRail/CameraRailFollow.set_unit_offset(camera_pos)
		else:
			$CameraRail/CameraRailFollow/Control/TurnCamera/CameraTurnTick.stop()


func _on_GlobalTick_timeout():
	$GlobalTick.start()
	if curmode != "Dialogue" and curmode != "Inv":
		for i in range(enemy_nodes.size()):
			if enemy_nodes[i].health > 0:
				enemy_nodes[i].charge = clamp(enemy_nodes[i].charge+enemy_nodes[i].recharge_rate/(1+int($"/root/Params".condits[1])),0,1)
				get_node(PATH_TO_ENEMY_UNIT+str(i+1)+"/Charge").value = enemy_nodes[i].charge
				if enemy_nodes[i].charge == 1:
					enemy_nodes[i].attacks(rng.randi_range(1,5))
					enemy_nodes[i].charge = 0
			else:
				enemy_nodes[i].hide()
				enemy_nodes[i].charge = 0
		for i in range(party_nodes.size()):
			if party_nodes[i].health > 0:
				party_nodes[i].charge = clamp(party_nodes[i].charge+party_nodes[i].recharge_rate/(1+int($"/root/Params".condits[1])),0,1)
				get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/Charge").value = party_nodes[i].charge
				get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/HP").value = party_nodes[i].health
				get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/HP/Label").text = str(party_nodes[i].health)+"/"+str(party_nodes[i].maxhealth)
				if party_nodes[i].charge == 1:
					party_nodes[i].charge = 0
					party_nodes[i].insp = clamp(party_nodes[i].insp+1,0,party_nodes[i].insp_max)
					get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/IP").value = party_nodes[i].insp
					get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/IP/Label").text = str(party_nodes[i].insp)+"/"+str(party_nodes[i].insp_max)
			else:
				get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/HP").value = party_nodes[i].health
				get_node(PATH_TO_FRIEND_UNIT+str(i+1)+"/HP/Label").text = str(party_nodes[i].health)+"/"+str(party_nodes[i].maxhealth)


func _on_HideNotificationTimer_timeout():
	get_node(PATH_TO_NOTIFICATION).hide()


# ЭФФЕКТЫ ----------------------------------------------------------------------
func _input(event):
	if event is InputEventMouse:
#		if $CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Detector.get_global_rect().has_point(event.position):
#				$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Tooltip.show()
#		else:
#				$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Tooltip.hide()
		for i in range(0,$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions.get_child_count()-1):
			if $CameraRail/CameraRailFollow/Control/UpperHalf/Conditions.get_child(i).get_global_rect().has_point(event.position) and $CameraRail/CameraRailFollow/Control/UpperHalf/Conditions.get_child(i).visible:
				$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Tooltip.show()
				$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Tooltip.rect_size = Vector2($CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Tooltip.rect_size.x,48)
				match i:
					0:
						$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Tooltip.text = tr("BAT_BLIZZARDEXP")
					1:
						$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Tooltip.text = tr("BAT_HEATEXP")
					2:
						$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Tooltip.text = tr("BAT_RAINEXP")
					3:
						$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Tooltip.text = tr("BAT_TOXICEXP")
					4:
						$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Tooltip.text = tr("BAT_MERCILESSEXP")
					5:
						$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Tooltip.text = tr("BAT_TIER2EXP")
				break
			else:
				$CameraRail/CameraRailFollow/Control/UpperHalf/Conditions/Tooltip.hide()
	if event is InputEventKey:
		if $CameraRail/CameraRailFollow/Control/LowerHalf/ChordSelector.visible:
			for i in range(1,8):
				if Input.is_action_just_pressed("number_"+str(i)):
					_on_chordbutton_pressed()
		elif $CameraRail/CameraRailFollow/Control/LowerHalf/OngakuCast.visible:
			for i in range(1,8):
				if Input.is_action_just_pressed("number_"+str(i)):
					_on_Note_pressed()
