@tool
extends Button
class_name FlatButton

@export var normal_color : Color
@export var border_light : float = 0.31
@export var corner_radius : int = 1024

@export_group("Text")
@export var texts : String = "normal"
@export var fontfile : FontFile = preload("uid://btqujsg7ssyuc")

@export_group("Texture")
@export var texture : Texture2D


##编辑器可见
#func _init() -> void:
#	if Engine.is_editor_hint():
#		binit("normal",normal_color)
#		binit("hover",normal_color.lerp(Color.WHITE,0.2))
#		binit("pressed",normal_color.lerp(Color.BLACK,0.1))

func _ready():
	if texture:
		tinit(texts,fontfile)
		pinit(texture)
	else:
		tinit(texts,fontfile,false)
	
	binit("normal",normal_color)
	binit("hover",normal_color.lerp(Color.WHITE,0.2))
	binit("pressed",normal_color.lerp(Color.BLACK,0.1))

#本体初始化	
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
	style.corner_radius_top_left = corner_radius
	style.corner_radius_top_right = corner_radius
	style.corner_radius_bottom_left = corner_radius
	style.corner_radius_bottom_right = corner_radius
	style.corner_detail = int(self.size.y) / 10
	
	self.add_theme_stylebox_override(style_name,style)

##文本初始化
func tinit(text:String,font:FontFile,is_texture:bool=true) -> void:
	var label = Label.new()
	label.label_settings = LabelSettings.new()
	
	var fontset = label.label_settings
	fontset.font = font
	fontset.font_size = int((self.size.x * 0.15) * (1 - len(text)%3 * 0.2) * 0.85)
	
	#label.global_position = self.global_position
	#label.position.y = self.position.y *0.225
	label.vertical_alignment = 1
	label.horizontal_alignment = 1
	if is_texture:
		label.position.x = self.size.x*0.5
		label.size.x = self.size.x * 0.5
	else:
		#label.position.x = self.position.x
		label.size.x = self.size.x
	label.size.y = self.size.y
	label.text = text
	
	add_child(label,true)

##贴图初始化
func pinit(texture:Texture2D) ->void:
	var t = TextureRect.new()
	
	t.texture = texture
	t.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	t.size.y = self.size.y
	t.size.x = self.size.x * 0.5 - (self.size.y / 200) * 8 - self.size.x / 200
	#t.position.y = self.position.y * 0.055
	t.position.x = (self.size.y / 200) * 8 + self.size.x / 200
	
	add_child(t,true)
	
	
