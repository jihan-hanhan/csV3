## qwen ##
extends Node3D

@export var orbit_radius: float = 12.0      # 公转半径（单位：米）
@export var orbit_speed: float = 0.3        # 公转角速度（弧度/秒）
@export var start_angle: float = 0.0        # 初始相位角度
@export var target_planet: Node3D           # 绑定的行星节点（留空则绕原点转）
@export var inclination_deg: float = 0.0

var _current_angle: float = 0.0

func _ready() -> void:
	_current_angle = start_angle

func _process(delta: float) -> void:
	# 累积角度
	_current_angle += orbit_speed * delta
	
	# 获取公转中心
	var center: Vector3 = target_planet.global_position if target_planet else Vector3.ZERO
	
	# 三角函数计算 XZ 平面坐标（Godot 默认 Y 轴向上）
	var x: float = cos(_current_angle) * orbit_radius
	var z: float = sin(_current_angle) * orbit_radius
	var f_pos : Vector3 = Vector3(x , 0.0 , z)

	var tlit_rad : float = rad_to_deg(inclination_deg)
	var tlited_pos : Vector3 = f_pos.rotated(Vector3.RIGHT,tlit_rad)
	
	# 设置全局位置（保持 Y 轴高度不变）
	global_position = center + tlited_pos
	look_at(center)
