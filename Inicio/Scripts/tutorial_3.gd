extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Inicio/Scenes/MDI.tscn")
	pass # Replace with function body.
func _on_flexaizq_pressed() -> void:
	get_tree().change_scene_to_file("res://Inicio/Scenes/tutorial2.tscn")
	pass # Replace with function body.
