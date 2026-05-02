extends Panel

@export var slide_speed : float
var normal_position : Vector2 = self.position
var is_pressed : bool = false
var latest_Bnum : int = 0 #!!! button_num != 0 -> 0=>first_start
var latest_weight : Node

@onready var width = get_viewport().get_visible_rect().size.x
@onready var hide_position = Vector2(width,normal_position.y)

#signal slide_out
#signal slide_in

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = hide_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func slide(type:bool) -> Tween:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	if type:
		tween.tween_property(self,"position",normal_position,slide_speed)
	else :
		tween.tween_property(self,"position",hide_position,slide_speed)
	
	return tween

func _on_button_pressed(button_num : int,path_weight:NodePath) -> void:
#	print(is_pressed)
#	print(button_num)
#	print(latest_Bnum)
#	print("+++++++")
	var weight = get_node(path_weight)

	is_pressed = not is_pressed #切换状态
	if is_pressed:
		weight.self_show()

	if latest_Bnum == button_num:   #正常开关
		await slide(is_pressed).finished
	elif latest_Bnum == 0:          #首次启动
		await slide(is_pressed).finished
		latest_Bnum = button_num
	elif not latest_Bnum == button_num and not is_pressed :  #开启时切换
		latest_Bnum = button_num
		await slide(false).finished
		latest_weight.self_hide()
		
		weight.self_show()
		await slide(true).finished
		is_pressed = true
	elif not latest_Bnum == button_num and is_pressed: #关闭时切换
		latest_Bnum = button_num
		await slide(is_pressed).finished
	
	if not is_pressed:
		weight.self_hide()
		
	latest_weight = weight
		
#	print(is_pressed)
#	print(button_num)
#	print(latest_Bnum)
#	print("-----------------------------\n")
