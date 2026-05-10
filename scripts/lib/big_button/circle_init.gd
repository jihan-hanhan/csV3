extends Panel

func _ready() -> void:
	var b = get_parent() as Button
	if b:
		self.global_position.x = b.global_position.x + b.size.x*0.025
		self.global_position.y = b.global_position.y + b.size.y*0.1
		self.scale.y = b.size.y / 200
		self.scale.x = self.scale.y
