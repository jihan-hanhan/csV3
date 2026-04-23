extends CanvasLayer

func _ready() -> void:
	var window_width = get_viewport().get_visible_rect().size.y
	offset = Vector2(0, -window_width)


func _on_progress_bar_stretch_finished() -> void:
	slide_in()


func slide_in():
	var tween = create_tween()
	tween.tween_property(self, "offset", Vector2(0, 0), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
