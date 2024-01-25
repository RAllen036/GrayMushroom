extends Node2D

@onready var grayed_area = $GrayGradient
@export var mix: float = 1

# Remove the blue border
func _ready():
	remove_child($Border)
	set_mixer(mix)

func set_mixer(mixer_value: float):
	
	clamp(mixer_value, 0, 1)
	
	# Sets the mixing value of the gray scale allowing for transitions
	grayed_area.material.set("shader_parameter/mixer", mixer_value)
	
