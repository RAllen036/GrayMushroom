extends Control

@onready var gray = $Background/GrayScale

var fade: bool = false

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
	
	# Start background music
	BackMusic.play()
	
	# Splash screen stuff
	var view = get_viewport_rect().size
	gray.scale = view
	gray.position = Vector2(view.x / 2, view.y / 2)
	$Background.size = view
	$Background.hide()
	$FadeInImage.size = view
	$FadeIn.start()

func _process(delta):
	
	if fade:
		# IDK, do some fade in animation
		pass
	
	if get_viewport().size_changed:
		var view: Vector2 = get_viewport_rect().size
		gray.scale = view
		gray.position = Vector2(view.x / 2, view.y / 2)
		$Background.size = view
		$FadeInImage.size = view
		

func _on_fade_in_timeout():
	# Replace line below with fade = true when fade animation is in place
	$FadeInImage.hide()
	$Background.show()


