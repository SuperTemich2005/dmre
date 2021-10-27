extends Node2D
signal casted

var current_seq : String
var demand


func _ready():
	demand = 0


func cur_seq_len():
	return len(current_seq)


func demand(cost):
	demand = cost


func cast(qseq,targ,succ):
	var reset = false
	match qseq:
		"DEFDEFDE": # Милонга
			if succ:
				print("Casting milonga")
				demand(5)
				targ.health -= 5
			else:
				demand(0)
			reset = true
		"ABCBE": # Перевал
			if succ:
				print("Casting pereval")
				demand(5)
			else:
				demand(0)
			reset = true
		_:
			print("No such ongaku: ",qseq," that is ",len(qseq)," long. Continue casting...")
			demand(0)
			if len(qseq) > 12:
				reset = true
	if reset:
		current_seq = ""
		print("This should be blank: {",current_seq,"}")
		emit_signal("casted")
