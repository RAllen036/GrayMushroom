extends Node2D

# Remove the blue border
func _ready():
	remove_child($Border)
