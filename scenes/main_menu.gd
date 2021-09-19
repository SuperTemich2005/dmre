extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var bg_movement_speed = 30
var mainmenu_path_slide_stage = 0
var tosettings_path_slide_stage = 0
var save_file
var slot_choose_mode = false
onready var params = $"/root/Params"
# Called when the node enters the scene tree for the first time.
func _ready():
	seed(OS.get_unix_time())
	for i in range(1,4):
		get_node("Logotype/PathThatSlidesMenu/PathFollow2D/MainMenuItself/VBoxContainer2/Slot"+str(i)).text = (tr("MM_SLOT")+" "+str(i))
	TranslationServer.set_locale("ru")
	save_file = ConfigFile.new()
	if save_file.load("C:/Games/AZIE Games/DMRER/savefile.save") == OK:
		print("Last saved locale is ",save_file.get_value("Basic","Language"))
		TranslationServer.set_locale(save_file.get_value("Basic","Language","ru"))
	else:
		Directory.new().make_dir("C:/Games/AZIE Games")
		Directory.new().make_dir("C:/Games/AZIE Games/DMRER")
		save_file.save("C:/Games/AZIE Games/DMRER/savefile.save")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tick_timeout():
	$FadeIn.color = $FadeIn.color + Color(0.1,0.1,0.1)
	if $FadeIn.color.r >= 1.0:
		print("Stopping ticks")
		$FadeIn/Tick.stop()
		$Path2D/PathFollow2D/BackgroundTileMap.show()
		$BGM.play()
		$Logotype/LogoShow.start()


func _process(delta):
	$Path2D/PathFollow2D.set_offset(($Path2D/PathFollow2D.get_offset()+bg_movement_speed*delta))


func _on_LogoShow_timeout():
	$Logotype.show()


func _on_Start_pressed():
	$Logotype/PathThatSlidesMenu/PathFollow2D/PressToStart/Boing.play()
	$Logotype/PathThatSlidesMenu/PathFollow2D/PressToStart.hide()
	$Logotype/PathThatSlidesMenu/PathFollow2D/Tick.start()




func _on_MainMenuTick_timeout():
	mainmenu_path_slide_stage+=0.05
	$Logotype/PathThatSlidesMenu/PathFollow2D.set_unit_offset(mainmenu_path_slide_stage)
	if mainmenu_path_slide_stage > 0.5:
		$Logotype/PathThatSlidesMenu/PathFollow2D/Tick.stop()


func _on_Settings_pressed():
	$Logotype/PathThatSlidesMenu/PathFollow2D/PressToStart/Boing.play()
	$Logotype/PathThatSlidesMenu/PathFollow2D/PressToStart.hide()
	$Logotype/PathThatSlidesMenu/PathFollow2D/MainMenuItself/VBoxContainer/Settings/Tick.start()


func _on_ToSettingsTick_timeout():
	tosettings_path_slide_stage+=0.05
	$Logotype/PathThatSlidesMenu/PathFollow2D.set_unit_offset(0.5+tosettings_path_slide_stage)
	if tosettings_path_slide_stage > 0.5:
		$Logotype/PathThatSlidesMenu/PathFollow2D/MainMenuItself/VBoxContainer/Settings/Tick.stop()


func _on_Back_pressed():
	$Logotype/PathThatSlidesMenu/PathFollow2D.set_unit_offset(0.5)
	tosettings_path_slide_stage = 0


func _on_ChangeLang_pressed():
	if TranslationServer.get_locale() == "ru":
		TranslationServer.set_locale("uk")
	elif TranslationServer.get_locale() == "uk":
		TranslationServer.set_locale("en")
	elif TranslationServer.get_locale() == "en":
		TranslationServer.set_locale("ru")
	elif TranslationServer.get_locale() == "ja":
		TranslationServer.set_locale("ru")


func _on_NewGame_pressed():
	$Logotype/PathThatSlidesMenu/PathFollow2D/MainMenuItself/VBoxContainer.hide()
	$Logotype/PathThatSlidesMenu/PathFollow2D/MainMenuItself/VBoxContainer2.show()
	$Logotype/PathThatSlidesMenu/PathFollow2D/MainMenuItself/VBoxContainer2/SelectSavefileLabel.text = tr("MM_SELECT_SLOT_NEWGAME")
	slot_choose_mode = false


func _on_BackFromSlotChooser_pressed():
	$Logotype/PathThatSlidesMenu/PathFollow2D/MainMenuItself/VBoxContainer.show()
	$Logotype/PathThatSlidesMenu/PathFollow2D/MainMenuItself/VBoxContainer2.hide()


func new_save(id):
	save_file.set_value("Basic","Language",TranslationServer.get_locale())
	params.current_savefile = id
	print("Saving ",TranslationServer.get_locale()," in global savefile")
	save_file.save("C:/Games/AZIE Games/DMRER/savefile.save")
	get_tree().change_scene("res://scenes/dialogues/prologue/prologue.tscn")


func load_save(id):
	pass


func _on_Slot1_pressed():
	if slot_choose_mode: # load game
		load_save(1)
	else: # create game
		new_save(1)


func _on_Slot2_pressed():
	if slot_choose_mode: # load game
		load_save(2)
	else: # create game
		new_save(2)


func _on_Slot3_pressed():
	if slot_choose_mode: # load game
		load_save(3)
	else: # create game
		new_save(3)
