extends Sprite2D


func _ready() -> void:
	var progress_bar = %ProgressBar
	visible = false

	var bottom_margin = progress_bar.bottom_margin
	var screen_size = get_viewport().get_visible_rect().size
	var screen_width = screen_size.x
	var screen_height = screen_size.y

	self.position = Vector2(screen_width / 2, screen_height - bottom_margin - 20)


func _on_progress_bar_stretch_finished() -> void:
	visible = true

func _on_invert_layer_slide_in_finished() -> void:
	# 缓动
	var target_pos = position + Vector2(0, 50)
	var duration = 0.8

	# 缓动曲线
	var curve = Curve.new()
	curve.add_point(Vector2(0, 0))
	curve.add_point(Vector2(0.3, 0.8))
	curve.add_point(Vector2(1, 1))  

	var tween = create_tween().set_parallel(true)
	
	# 缓动
	var property_tween = tween.tween_property(self, "position", target_pos, duration)
	property_tween.set_ease(Tween.EASE_IN_OUT)
	property_tween.set_trans(Tween.TRANS_CUBIC)

	# 淡出
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
	await tween.finished
	self.queue_free()
