extends Node2D

@export var color: Color = Color(1, 1, 1, 1)
@export var ring_duration: float = 0.2

var append_x: int
var append_y: int

func create_expanding_ring(_position: Vector2, max_radius: float = 100, duration: float = 1.0):
	# 创建圆环
	var ring = Line2D.new()
	ring.width = 10  # 初始宽度
	ring.default_color = color
	ring.antialiased = true
	
	# 绘制圆形（使用32个点）
	var points = []
	var segments = 32
	for i in range(segments + 1):
		var angle = i * 2 * PI / segments
		var radius = max_radius
		var x = cos(angle) * radius
		var y = sin(angle) * radius
		points.append(Vector2(x, y))
	
	ring.points = points
	ring.position = _position
	add_child(ring)
	
	# 动画化圆环
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(ring, "scale", Vector2(3, 3), duration)
	tween.tween_property(ring, "width", 0, duration)
	tween.tween_property(ring, "modulate:a", 0, duration)
	tween.tween_callback(ring.queue_free).set_delay(duration)


func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	var screen_width = screen_size.x
	
	# 向上偏移一个值，confirmed.gd也偏移了20像素
	append_y = screen_size.y - 20
	append_x = screen_width / 2


func _on_progress_bar_stretch_finished() -> void:
	var progress_bar = %ProgressBar
	create_expanding_ring(Vector2(append_x, append_y - progress_bar.bottom_margin), 50, ring_duration)
