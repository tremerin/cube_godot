extends Node3D


@onready var area_3d: Area3D = $Area3D
@onready var new_parent: Node3D = $NewParent


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		print("ui_accept")
		for body in $Area3D.get_overlapping_bodies():
			print(body.name)
			body.get_parent().remove_child(body)
			area_3d.add_child(body)



func _process(delta: float) -> void:
	area_3d.rotate(Vector3.UP, 1 * delta)
