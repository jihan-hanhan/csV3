extends Camera3D

@export var Tspeed : float
var camera_tween : Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func camera_move(target : NodePath) -> void:
	var pos = get_node(target) as Marker3D
	if camera_tween and camera_tween.is_valid() and camera_tween.is_running():
		camera_tween.kill()
	
	camera_tween = create_tween()
	
	camera_tween.set_trans(Tween.TRANS_CUBIC)
	
	camera_tween.tween_property(self,"global_transform",pos.global_transform,Tspeed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
