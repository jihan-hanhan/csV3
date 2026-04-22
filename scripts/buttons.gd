extends Control

signal button_hovered(width: float, height: float, button: BaseButton)  # 定义一个信号，表示鼠标悬停在按钮上，并传递按钮的宽度和高度
signal button_exited(button: BaseButton)  # 定义一个信号，表示鼠标离开按钮

func _on_mouse_entered(button: BaseButton):
    var btn_width = button.size.x
    var btn_height = button.size.y
    button_hovered.emit(btn_width, btn_height, button)  # 发出信号
    print("Mouse entered button: ", button.name)  # 调试信息


func _on_mouse_exited(button: BaseButton):
    button_exited.emit(button)
    print("Mouse exited button: ", button.name)  # 调试信息


# 递归遍历所有子节点，给每个Button绑定信号
func _ready():
    setup_buttons(self)


func setup_buttons(node: Node):
    if node is BaseButton:
        node.mouse_entered.connect(_on_mouse_entered.bind(node))
        node.mouse_exited.connect(_on_mouse_exited.bind(node))
    
    for child in node.get_children():
        setup_buttons(child)
