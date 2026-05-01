extends CanvasLayer

@export var slide_speed : float
@export var wait_time : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var width = get_viewport().get_visible_rect().size.x
	offset = Vector2(width,0)
	
	await get_tree().create_timer(wait_time).timeout
	
	slide_in()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func slide_in() -> void:
	var tween = create_tween()
	tween.tween_property(self,"offset",Vector2(0,0),slide_speed)
