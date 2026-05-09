extends Control
class_name textureable_button

@export var backguond_texture : Texture2D

func _draw() -> void:
	print("load")
	if backguond_texture == null:
		print("!No_Bg_Texture")
		return
	
	var button = Button.new()
	button.position = Vector2(0,0)
		
	var bg = TextureRect.new()
	bg.position = Vector2(0,0)
	bg.texture = backguond_texture
	bg.size = backguond_texture.get_size()
	print("!!!!")
