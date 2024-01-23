extends Control

func _on_quit_button_pressed():
	get_tree().quit()

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_selector.tscn")

# Start button
func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_selector.tscn")

# Play again button
func _on_texture_button_2_pressed():
	get_tree().quit()

func _ready():
	$Background.size = get_viewport_rect().size

func _process(delta):
	if get_viewport().size_changed:
		var view: Vector2 = get_viewport_rect().size
		$Background.size = view
		
