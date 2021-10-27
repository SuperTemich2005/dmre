extends Node2D
var current_savefile
var passed_enemies
var passed_party
var inventory

func _ready():
	inventory = [
		#"name|description|spritename|restorehp|restoremp|restorepp|specialevent|dispensable",
		"1Хлеб|первый энтри 1Беленький? Нет, серенький, сееееренький!|bread|5|5|1|none|false",
		"2Чёрный хлеб|2Беленький? Нет, казацкий.|bread2|10|10|2|none|false",
		"3Чёрasdasdный хлеб|3Беленький? Нет, казацкий.|bread2|10|10|2|none|false",
		"4Чёрный хлеб|Беленький? Неasdт, казацкий.|bread2|10|10|2|none|false",
		"5Чёрный хлеб|Беленький? Нет, казацкий.|bread2|10|10|2|none|false",
		"6Чёрнasdasdый хлеб|Беленький? Нет, казацкий.|bread2|10|10|2|none|false",
		"7Чёрный хлеб|Беленький?asda Нет, казацкий.|bread2|10|10|2|none|false",
		"8Чёрнasdasdый хлеб|Беленький? Нет, казацкий.|bread2|10|10|2|none|false",
		"9Чёрный хлеб|Беленький? Нет, казацкий.|bread2|10|10|2|none|false",
		"10Чёрasdasdный хлеб|10Беленький? Нет, казацкий.|bread2|10|10|2|none|false",
		"11Чёрный хлеб|Беленький? Нет, казацкий.|bread2|10|10|2|none|false",
		"12Чёрный хasdasdлеб|Беленький? Нет, казацкий.|bread2|10|10|2|none|false",
		"13Чёрный хлеб|13Беленький? Нет, казацкий.|bread2|10|10|2|none|false",
		"14Чёрный asdasdхлеб|14Беленький?asdasd Нет, казацкий.|bread2|10|10|2|none|false",
		"15Чёрный хлеб|Беленький? Нет, казацкий.|bread2|10|10|2|none|false",
	]
	passed_enemies = [
		"dummy",
		"dummy2",
		"dummy",
	]
	passed_party = [
		"dummy",
		"dummy",
	]
