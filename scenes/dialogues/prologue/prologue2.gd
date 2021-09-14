extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var dialogue_ru
func _ready():
	print("scene loaded")
	
	dialogue_ru = [
		"",
	]


func _process(delta):
	if $DialogueSystem.cur == 0:
		pass


func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_up"):
			$DialogueSystem.cur = 50
