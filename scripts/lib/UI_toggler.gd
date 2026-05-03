extends Node
class_name UiToggler

var latest_num:int = 0
var latest_weight:Node = new()

func slide(type:bool,pos1:Vector2,pos2:Vector2,speed:float) -> Tween:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	if type:
		tween.tween_property(self,"position",pos1,speed)
	else :
		tween.tween_property(self,"position",pos2,speed)
	
	return tween

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
