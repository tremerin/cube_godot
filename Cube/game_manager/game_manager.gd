class_name GameManager
extends Node

@onready var game: Node3D = $Game
@onready var gui: Control = $Gui

## Specify the file system path where the levels are stored.
@export var level_path:String = "res://levels/"
var level_scene
var level_instance

## Specify the file system path where the menus are stored.
@export var menu_path:String = "res://menus/"
var menu_scene
var menu_instance


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		print("escape")

func _ready() -> void:
	_instantiate_menu("main_menu")

func _instantiate_level(level_name: String):
	level_scene = load(level_path +  level_name + "/" + level_name + ".tscn")
	level_instance = level_scene.instantiate()
	game.add_child(level_instance)

func start_game():
	_delete_menu()
	_instantiate_level("test_level")

func _delete_menu():
	if menu_instance:
		menu_instance.queue_free()

func _instantiate_menu(menu_name: String):
	menu_scene = load(menu_path + menu_name  + "/" + menu_name + ".tscn")
	menu_instance = menu_scene.instantiate()
	menu_instance.manager = self
	gui.add_child(menu_instance)

func change_menu(menu_name: String):
	_delete_menu()
	_instantiate_menu(menu_name)

func quit_game():
	get_tree().quit()

func pause_game():
	game.get_tree().paused != game.get_tree().paused
