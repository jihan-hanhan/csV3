extends ColorRect

@export var bottom_margin: float = 150.0			# 到屏幕底部的间距
@export var stretch_duration: float = 1.5			# 拉伸动画持续时间
@export var gap_between: float = 180.0 				# L和R中间的间隙
@export var bar_color: Color = Color(1, 1, 1, 1)	# 进度条颜色
@export var bar_height: float = 16.0				# 进度条高度

@onready var L = $L
@onready var R = $R

signal stretch_finished

func _ready():
	# 纯黑色背景
	color = Color.BLACK
	size = get_viewport().get_visible_rect().size
	position = Vector2(0, 0)
	
	init_children()
	animate()
	
	get_tree().root.connect("size_changed", _on_resize)

func init_children():
	var bar_y = size.y - bottom_margin - bar_height
	
	L.size = Vector2(16, bar_height)
	R.size = Vector2(16, bar_height)
	L.position = Vector2(0, bar_y)
	R.position = Vector2(size.x - R.size.x, bar_y)
	L.color = bar_color
	R.color = bar_color

func animate():
	var center_x = size.x / 2
	var gap_half = gap_between / 2

	# 计算目标宽度和位置
	var left_target_width = max(center_x - gap_half, 0)
	var right_target_width = max(center_x - gap_half, 0)
	var right_target_x = center_x + gap_half

	var tween = create_tween()
	tween.set_parallel(true)
	
	# 添加缓动效果
	tween.tween_property(L, "size:x", left_target_width, stretch_duration)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUINT)
	
	tween.tween_property(R, "position:x", right_target_x, stretch_duration)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUINT)
	
	tween.tween_property(R, "size:x", right_target_width, stretch_duration)\
		.set_ease(Tween.EASE_OUT)\
		.set_trans(Tween.TRANS_QUINT)

	# 动画完成后发出信号
	tween.finished.connect(func(): stretch_finished.emit())

func _on_resize():
	size = get_viewport().get_visible_rect().size
	position = Vector2(0, 0)
	init_children()
	animate()
