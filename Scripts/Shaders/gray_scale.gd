extends Node2D

@onready var grayed_area = $GrayGradient

# Remove the blue border
func _ready():
	remove_child($Border)

func set_mixer(mixer_value: float):
	
	if mixer_value > 1:
		mixer_value = 1
	if mixer_value < 0:
		mixer_value = 0
	
	# Sets the mixing value of the gray scale allowing for transitions
	grayed_area.material.set("shader_parameter/mixer", mixer_value)
	
