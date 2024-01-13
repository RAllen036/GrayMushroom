extends Node

# move from one scene to another
func scene(from: Node2D, resource_loc: String):
	# Loads the next level
	var resource = load(resource_loc)
	# instanciate creates a copy of the loaded scene for later use
	var next = resource.instantiate()
	# Adds the instanced scene to the root scene
	get_tree().root.add_child(next)
	# Changes the users view
	get_tree().current_scene = next
	# Removes the previous scene from memory
	from.queue_free()
	
