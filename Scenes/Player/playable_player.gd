extends CharacterBody2D

var walk_speed: float = 500

func _physics_process(delta):
	
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	velocity = walk_speed * direction
	
	move_and_slide()
	
