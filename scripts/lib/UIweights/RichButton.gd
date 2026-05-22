@tool
extends Button
class_name RichButton

@export var normal_color : Color
@export var corner_radius : int = 5
@export var bg_texture : Texture2D = preload("uid://bbyv0730txqe6")
@export var picture : Texture2D = preload("uid://bbyv0730txqe6")

var border_size : int = (self.size.y / 200) * 8

var bg = TextureRect.new()
var pic = TextureRect.new()
var label = Label.new()

func _ready() -> void:
	bg_init()
	pic_init()
	pass

#本体初始化	
func binit(style_name:String,setcolor:Color):
	var origin_style = self.get_theme_stylebox(style_name)
	var style:StyleBoxFlat = origin_style.duplicate()
	style.bg_color = normal_color
	
	style.border_width_left = border_size
	style.border_width_top = border_size
	style.border_width_right = border_size
	style.border_width_bottom = border_size
	
	style.border_color = setcolor.lerp(Color.WHITE,0.4)
	style.corner_radius_top_left = corner_radius
	style.corner_radius_top_right = corner_radius
	style.corner_radius_bottom_left = corner_radius
	style.corner_radius_bottom_right = corner_radius
	style.corner_detail = int(self.size.y) / 10
	
	self.add_theme_stylebox_override(style_name,style)

func bg_init() -> void:
	#bg.position = self.position
	bg.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	
	bg.size.x = self.size.x
	bg.size.y = self.size.y
	bg.texture = bg_texture
	add_child(bg)

func pic_init() -> void:
	pic.expand_mode
	pic.texture = picture
	
	add_child(pic)
