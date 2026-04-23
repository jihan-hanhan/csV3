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