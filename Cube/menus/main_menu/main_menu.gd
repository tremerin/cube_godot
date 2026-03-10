extends Control
var manager : GameManager

func _ready() -> void:
	pass # Replace with function body.


func _on_btn_start_pressed() -> void:
	manager.start_game()


func _on_btn_settings_pressed() -> void:
	manager.change_menu("settings_menu")


func _on_btn_quit_pressed() -> void:
	manager.quit_game()
