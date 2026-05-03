extends Node

var latest_num:int = 0
var latest_weight:Node

func toggle(num:int,path_weight:NodePath) -> void:
	var weight = get_node(path_weight)
	
	if latest_num == 0:
		weight._on_toggler_show()
	elif latest_num == num:
		weight._on_toggler_show()
	elif not latest_num == num:
		latest_weight._on_toggler_hide()
		weight._on_toggler_show()
	
	latest_num = num
	latest_weight = weight
	
