extends StaticBody3D

var piece_type:int 
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

var colors = [
	Color(1, 0, 0),
	Color(0, 1, 0),
	Color(0, 0, 1),
	Color(1, 1, 0),
	Color(1, 0, 1),
	Color(0, 1, 1)
]

func _ready() -> void:
	randomize()
	var random =  randi_range(0, 5)
	#print(random)
	piece_type = random
	var material = StandardMaterial3D.new()
	material.albedo_color = colors[random]
	mesh_instance_3d.material_override = material
