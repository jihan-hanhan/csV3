extends Sprite2D

# 这个Copilot太牛逼了，会帮我写注释（）

const CORNER_SIZE: int = 16  # 光标四角的原始尺寸，单位像素

# 一些参数
#@export var follow_speed: float = 10.0						# 光标跟随速度，已挂载在父节点
@export var base_width: float = 50.0						# 基础宽度，鼠标悬停在按钮上时会根据按钮大小调整
@export var base_height: float = 50.0						# 基础高度，鼠标悬停在按钮上时会根据按钮大小调整
@export var cursor_scale: float = 0.6						# 光标缩放比例
#@export var showing_cursor: bool = true					# 是否显示系统光标，已挂载在父节点
#@export var cursor_color: Color = Color(1, 1, 1, 1)		# 光标颜色，已挂载在父节点
@export var margin: float = 1.0								# 鼠标悬停时，光标相对于按钮尺寸的边距百分比
@export var tween_duration: float = 0.1     				# 缓动动画时长（秒）
@export var tween_easing: Tween.EaseType = Tween.EASE_OUT  	# 缓动曲线
@export var damping_coefficient: float = 0.1				# 阻尼系数

# 从父节点获取参数
@onready var speed = get_parent().follow_speed
@onready var cursor_color = get_parent().cursor_color
@onready var showing = get_parent().showing_cursor

# 导入四个角以及中心的节点
@onready var top_left = $L1
@onready var top_right = $R1
@onready var bottom_left = $L2
@onready var bottom_right = $R2
@onready var center = get_parent().get_node("Center")

# 默认尺寸，用于鼠标离开按钮时恢复光标大小
var default_size = Vector2(base_width, base_height)

# 缓动相关
var tween: Tween = null
var target_width: float
var target_height: float

# 磁吸相关
var current_button: Node = null


func update_cursor():
	# 计算缩放后的实际尺寸
	var actual_width = base_width * cursor_scale
	var actual_height = base_height * cursor_scale
	var actual_corner_size = CORNER_SIZE * cursor_scale
	
	# 计算半宽半高
	var half_w = actual_width / 2
	var half_h = actual_height / 2
	var corner_offset = actual_corner_size / 2
	
	# 更新四个角的位置
	if top_left:
		top_left.position = Vector2(-half_w + corner_offset, -half_h + corner_offset)
	if top_right:
		top_right.position = Vector2(half_w - corner_offset, -half_h + corner_offset)
	if bottom_left:
		bottom_left.position = Vector2(-half_w + corner_offset, half_h - corner_offset)
	if bottom_right:
		bottom_right.position = Vector2(half_w - corner_offset, half_h - corner_offset)
	
	# 缩放光标四角
	var corner_scale = cursor_scale
	for corner in [top_left, top_right, bottom_left, bottom_right]:
		if corner:
			corner.scale = Vector2(corner_scale, corner_scale)


# 染色函数
func apply_color():
	for corner in [top_left, top_right, bottom_left, bottom_right]:
		if corner:
			corner.modulate = cursor_color


func _ready():
	apply_color()
	# 隐藏系统光标
	if !showing:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _process(delta):
	# 更新光标位置和尺寸信息
	update_cursor()
	var target_pos: Vector2 = get_global_mouse_position()

	if current_button:
		var rect = current_button.get_global_rect()
		var button_center = rect.get_center()
		target_pos = button_center + (target_pos - button_center) * damping_coefficient  # 磁吸效果，越接近按钮中心越慢

	# 线性插值，实现平滑跟随
	global_position = global_position.lerp(target_pos, speed * delta)


func _on_buttons_button_hovered(width: float, height: float, button: BaseButton) -> void:
	current_button = button  # 记录当前悬停的按钮

	# 计算目标尺寸，基于按钮尺寸和边距百分比
	target_width = width + width * margin
	target_height = height + height * margin

	# 创建或更新缓动动画
	tween = create_tween()
	tween.tween_property(self, "base_width", target_width, tween_duration).set_ease(tween_easing)
	tween.tween_property(self, "base_height", target_height, tween_duration).set_ease(tween_easing)


# 这个函数不能删掉参数，否则就没法连接信号了，虽然现在这个参数没用到（）
func _on_buttons_button_exited(button: BaseButton) -> void:  #啊，这一条黄波浪线难受死了
	current_button = null  # 清除当前按钮记录

	# 鼠标离开按钮时恢复默认尺寸
	tween = create_tween()
	tween.tween_property(self, "base_width", default_size.x, tween_duration).set_ease(tween_easing)
	tween.tween_property(self, "base_height", default_size.y, tween_duration).set_ease(tween_easing)
