extends Panel

@export var slide_speed : float
var normal_position : Vector2 = self.position
var is_pressed : bool = false
var latest_Bnum : int = 0 #!!! button_num != 0 -> 0=>first_start

@onready var width = get_viewport().get_visible_rect().size.x
@onready var hide_position = Vector2(width,normal_position.y)

signal slide_done

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = hide_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func slide(type:bool) -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	if type:
		tween.tween_property(self,"position",normal_position,slide_speed)
	else :
		tween.tween_property(self,"position",hide_position,slide_speed)

func _on_button_pressed(button_num : int) -> void:
#	print(is_pressed)
#	print(button_num)
#	print(latest_Bnum)
#	print("+++++++")
	if latest_Bnum == button_num:
		is_pressed = not is_pressed
		await slide(is_pressed)
		slide_done.emit()
	elif latest_Bnum == 0:
		is_pressed = not is_pressed
		await slide(is_pressed)
		slide_done.emit()
		latest_Bnum = button_num
	elif not latest_Bnum == button_num and is_pressed : 
		latest_Bnum = button_num
		is_pressed = not is_pressed
		slide(false)
		await get_tree().create_timer(slide_speed+0.05).timeout
		slide(true)
		is_pressed = true
	elif not latest_Bnum == button_num and not is_pressed:
		is_pressed = not is_pressed
		latest_Bnum = button_num
		await slide(is_pressed)
		slide_done.emit()
#	print(is_pressed)
#	print(button_num)
#	print(latest_Bnum)
#	print("-----------------------------\n")
