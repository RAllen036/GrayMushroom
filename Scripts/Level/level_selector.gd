extends Node2D

@onready var level_option = preload("res://Scenes/Levels/level_option.tscn")
@onready var option_ref_pos = $LevelOptions

var level_paths = []
var option_buffer: float = 300

# This function is only called once when the scene is initialised / instantiated
func _ready():
	
	#var tween = get_tree().create_tween().set_parallel(true).set_trans(Tween.TRANS_SINE)
	#tween.tween_property($Player, "modulate", Color.RED, 1)
	#tween.tween_property($Player, "scale", Vector2(), 1)
	#tween.chain().tween_property($Player, "scale", Vector2(1, 1), 1)
	#tween.chain().tween_property($Player, "modulate", Color.WHITE, 1)
	
	# Gets all the files in the Levels folder
	# Removes all .gd files
	# Remoevs the level selector
	# Because we only want the scenes that the player can travel to from here
	
	# Gets all the files in the Levels folder
	var files = DirAccess.get_files_at("res://Scenes/Levels") 
	
	# Loops backwards so that you don't miss a file
	# If index 0 is removed then index 1 of the original won't get read
	for i in range(files.size() - 1, -1, -1): 
		var file = files[i]
		if file[-1] == "d" or file == "level_selector.tscn" or file == "level_option.tscn":
			# Actually remove the file
			files.remove_at(i)
	
	# Stores the level files for later
	level_paths = files
	
	# Create instances of level options for how many level paths there are
	for i in range(0, level_paths.size()):
		var option = level_option.instantiate()
		option_ref_pos.add_child(option)
		option.position.x = (option.scale.x + option_buffer) * i
		# Sets up the scene on the inside
		option.init(level_paths[i])
		option.selected.connect(_on_option_selected)
	

# Switches scenes from the option you selected
func _on_option_selected(level_name, body):
	# Checks to see if the body that entered is the player
	if body.is_in_group("player"):
		# Changes the scene using custom scene changer found in res://Globals/switch_scenes.gd
		Switch.scene(self, "res://Scenes/Levels/" + level_name)
	