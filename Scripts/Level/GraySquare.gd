extends Node2D

@export var mix: float = 1

func _ready():
	set_mixer(mix)

func re_size(back: Vector2):
	$ColorRect.global_position = Vector2.ZERO
	$ColorRect.size = back

func set_mixer(mixer_value: float):
	
	clamp(mixer_value, 0, 1)
	mix = mixer_value
	# Sets the mixing value of the gray scale allowing for transitions
	$ColorRect.material.set("shader_parameter/mixer", mixer_value)
