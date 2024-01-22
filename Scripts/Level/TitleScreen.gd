extends Control


func _on_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/level_selector.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
