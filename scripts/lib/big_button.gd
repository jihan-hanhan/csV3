extends Button

@export var normal_color : Color
@export var border_light : float = 0.25

func _ready():
	binit("normal",normal_color)
	binit("hover",normal_color.darkened(-0.1))
	binit("pressed",normal_color.darkened(0.1))
	
func binit(style_name:String,setcolor:Color):
	var origin_style = self.get_theme_stylebox(style_name)
	var style:StyleBoxFlat = origin_style.duplicate()
	style.bg_color = normal_color
	style.border_width_left = 8
	style.border_width_top = 8
	style.border_width_right = 8
	style.border_width_bottom = 8 
	style.border_color = setcolor.lightened(border_light)
	style.corner_radius_top_left = 1024
	style.corner_radius_top_right = 1024
	style.corner_radius_bottom_left =1024
	style.corner_radius_bottom_right = 1024
	style.corner_detail = int(self.size.y) / 10
	
	self.add_theme_stylebox_override(style_name,style)
