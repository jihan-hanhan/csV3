extends CanvasLayer
class_name MessageBar

@export var height:float = 40
@export var font_size:int = 1

var panel = Panel.new()
var icon = TextureRect.new()
var label = Label.new()
var time_bar = Line2D.new()

var style_info = StyleBoxFlat.new()
var style_warn = StyleBoxFlat.new()
var style_erro = StyleBoxFlat.new()

func _ready() -> void:
	style_init()

func bar_create(type:int,text:String) -> void:
	var bar = Control.new()
	var last = Timer.new()
	
	if type == 0:
		panel.add_theme_stylebox_override("panel",style_info)
	elif type == 1:
		panel.add_theme_stylebox_override("panel",style_warn)
	elif type == 2:
		panel.add_theme_stylebox_override("panel",style_erro)
	label.text = text
	
func style_init() -> void:
	##info
	style_info.bg_color = Color("#f0f0f0")
	
	style_info.corner_radius_top_left = 7
	style_info.corner_radius_top_right = 7
	style_info.corner_radius_bottom_left = 7
	style_info.corner_radius_bottom_right = 7
	
	##warn
	style_warn.bg_color = Color("e6e639")
	
	style_warn.corner_radius_top_left = 7
	style_warn.corner_radius_top_right = 7
	style_warn.corner_radius_bottom_left = 7
	style_warn.corner_radius_bottom_right = 7
	
	##erro
	
	style_erro.bg_color = Color("e63939ff")
	
	style_erro.corner_radius_top_left = 7
	style_erro.corner_radius_top_right = 7
	style_erro.corner_radius_bottom_left = 7
	style_erro.corner_radius_bottom_right = 7
	
	
	
	
	
