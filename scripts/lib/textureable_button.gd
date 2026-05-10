@tool
extends Button
class_name TexturealbeButton

@export var bg_texture : Texture2D

var bg = TextureRect.new()

func _ready() -> void:
	bg.visible = true
	bg.texture = bg_texture
