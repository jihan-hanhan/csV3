extends Button

@export var normal_color : Color
@export var border_light : float = 0.31

@export_group("childrens")
@export var texts:String

func _ready():
	binit("normal",normal_color)
	binit("hover",normal_color.lerp(Color.WHITE,0.2))
	binit("pressed",normal_color.lerp(Color.BLACK,0.1))

	
func binit(style_name:String,setcolor:Color):
	var origin_style = self.get_theme_stylebox(style_name)
	var style:StyleBoxFlat = origin_style.duplicate()
	style.bg_color = normal_color
	
	var border_size : int = (self.size.y / 200) * 8
	style.border_width_left = border_size
	style.border_width_top = border_size
	style.border_width_right = border_size
	style.border_width_bottom = border_size
	
	style.border_color = setcolor.lerp(Color.WHITE,0.4)
	style.corner_radius_top_left = 1024
	style.corner_radius_top_right = 1024
	style.corner_radius_bottom_left =1024
	style.corner_radius_bottom_right = 1024
	style.corner_detail = int(self.size.y) / 10
	
	self.add_theme_stylebox_override(style_name,style)
	
