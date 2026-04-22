extends Sprite2D

# 和corners.gd没什么区别，都是用来控制光标的显示和移动的

@onready var speed = get_parent().follow_speed
@onready var cursor_color = get_parent().cursor_color
@onready var showing = get_parent().showing_cursor

# 染色函数
func apply_color():
	modulate = cursor_color


func _ready() -> void:
	apply_color()


func _process(delta: float) -> void:
	var target_pos: Vector2 = get_global_mouse_position()
	global_position = global_position.lerp(target_pos, speed * delta)
