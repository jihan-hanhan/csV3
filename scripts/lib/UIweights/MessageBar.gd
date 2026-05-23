extends CanvasLayer
class_name MessageBar

@export var height:float = 40
@export var font_size:int = 32
@export var font_type:FontFile = preload("res://assets/fonts/HarmonyOS_Sans_SC_Light.ttf")

var icon = TextureRect.new()
var time_bar = Line2D.new()

var style_info = StyleBoxFlat.new()
var style_warn = StyleBoxFlat.new()
var style_erro = StyleBoxFlat.new()
var label_settings = LabelSettings.new()

func _ready() -> void:
	layer = 100
	style_init()

func bar_create(type:int,text:String) -> void:
	var panel = Panel.new()
	var label = Label.new()
	var bar = Control.new()
	var last = Timer.new()
	
	#style_init
	if type == 0:
		panel.add_theme_stylebox_override("panel",style_info)
	elif type == 1:
		panel.add_theme_stylebox_override("panel",style_warn)
	elif type == 2:
		panel.add_theme_stylebox_override("panel",style_erro)
	label.text = text
	label.label_settings = label_settings
	bar.modulate.a = 0
	
	#size_init
	label.size.y = height
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	panel.size.x = label.size.x + 20
	panel.size.y = height
	
	#positon init
	bar.global_position.x = get_viewport().get_visible_rect().size.x / 2 - panel.size.x / 2
	bar.global_position.y = get_viewport().get_visible_rect().position.y - height - 10
	label.position.x = (panel.size.x - label.size.x) / 2
	
	#timer_init
	last.wait_time = 1
	last.one_shot = true
	
	#get_in
	bar.add_child(panel)
	bar.add_child(label)
	bar.add_child(last)
	self.add_child(bar)
	
	#show
	var t = create_tween()
	t.tween_property(bar,"position",Vector2(bar.global_position.x,get_viewport().get_visible_rect().position.y + 8),1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	t.parallel().tween_property(bar,"modulate:a",1,1)
	t.finished.connect(func finished():##什么玩意这是
		last.start()
		last.timeout.connect(func freed():
			t = create_tween()
			await t.tween_property(bar,"modulate:a",0,0.5).finished
			bar.queue_free()
			)
		)
		
	
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
	
	##font
	label_settings.font = font_type
	label_settings.font_size = font_size
	label_settings.font_color = Color("0f0f0f")
	
