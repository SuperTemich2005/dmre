extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var cur = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	match TranslationServer.get_locale():
		"en":
			get_parent().dialogue = get_parent().dialogue_en 
			print("Switching dialogue language to english")
		"ru":
			get_parent().dialogue = get_parent().dialogue_ru
			print("Switching dialogue language to russian")
		"uk":
			get_parent().dialogue = get_parent().dialogue_uk
			print("Switching dialogue language to ukrainian")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func parser():
	$DialogueBox/ShowText.text = get_parent().dialogue[cur].split("|")[0]
	if get_parent().dialogue[cur].split("|").size() > 1:
		if get_parent().dialogue[cur].split("|")[1] == "B":
			$DialogueBox.color = Color(0.5,0.5,1)
		elif get_parent().dialogue[cur].split("|")[1] == "Y":
			$DialogueBox.color = Color(0.6,0.6,0.4)
		elif get_parent().dialogue[cur].split("|")[1] == "G":
			$DialogueBox.color = Color(0.4,0.6,0.4)
		elif get_parent().dialogue[cur].split("|")[1] == "W":
			$DialogueBox.color = Color(0,0,0)
		if get_parent().dialogue[cur].split("|").size() > 2:
			if get_parent().dialogue[cur].split("|")[2] != "-":
				get_parent().get_node("Characters/"+get_parent().dialogue[cur].split("|")[2].split(" ")[0]+"/Sprite").animation = get_parent().dialogue[cur].split("|")[2].split(" ")[1]
				for i in range(get_parent().get_node("Characters").get_child_count()):
					get_parent().get_node("Characters").get_children()[i].hide()
				get_parent().get_node("Characters/"+get_parent().dialogue[cur].split("|")[2].split(" ")[0]).show()
			if get_parent().dialogue[cur].split("|").size() > 3:
				if get_parent().dialogue[cur].split("|")[3].split(" ")[0] == "PLAY":
					$BGM.set_stream(load("res://music/"+get_parent().dialogue[cur].split("|")[3].split(" ")[1]+".ogg"))
					$BGM.play()
				else:
					$BGM.stop()
				
func _on_NextButton_pressed():
	cur+=1
	parser()
	


func _on_FirstParse_timeout():
	parser()
