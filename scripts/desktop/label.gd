extends Label

var bottom_margin = 0


func _ready():
	# 获取ProgressBar
	var progress_bar = %ProgressBar
	
	bottom_margin = progress_bar.bottom_margin

	var screen_size = get_viewport().get_visible_rect().size
	var screen_width = screen_size.x
	var screen_height = screen_size.y
	
	self.text = "Connecting..."
	self.position = Vector2(screen_width / 2, screen_height - bottom_margin)


func _on_progress_bar_stretch_finished() -> void:
	self.text = "Connected."
	await blink_twice(true)


# 闪烁两次
func blink_twice(v: bool) -> void:
	for i in range(4):
		visible = !visible
		await get_tree().create_timer(0.05).timeout
	visible = v


func _on_invert_layer_slide_in_finished() -> void:
	await get_tree().create_timer(0.5).timeout
	blink_twice(false)
