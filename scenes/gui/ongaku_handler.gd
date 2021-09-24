extends Node2D


var current_seq : String
var demand


func cur_seq_len():
	return len(current_seq)


func demand(cost):
	demand = cost


func cast(qseq,targ):
	var reset = false
	match qseq:
		"DEFDEFDE": # Милонга
			print("Casting milonga")
			demand(5)
			targ.health -= 5
			reset = true
		"ABCBE": # Перевал
			print("Casting milonga")
			demand(5)
			reset = true
		_:
			print("No such ongaku: ",qseq," that is ",len(qseq)," long. Continue casting...")
			demand(0)
			if len(qseq) > 12:
				reset = true
	if reset:
		current_seq = ""
		print("This should be blank: {",current_seq,"}")
