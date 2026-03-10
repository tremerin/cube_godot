extends Control
var manager : GameManager

func _ready() -> void:
	pass # Replace with function body.


func _on_btn_back_pressed() -> void:
	manager.change_menu("main_menu")
