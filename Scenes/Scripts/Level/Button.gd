extends Node2D

@onready var sprite = $AnimatedSprite2D
@export var button: String = "a"

var perfect = false
var good = false
var okay = false
var current_note = null

func _input(event):
	if event.is_action_pressed(button,false):
		if current_note != null:
			if perfect:
				get_parent().increment_score(3)
				current_note.destroy(3)
			elif  good:
				get_parent().increment_score(2)
				current_note.destroy(2)
			elif okay:
				get_parent().increment_score(1)
				current_note.destroy(1)
			reset()
		else:
			get_parent().increment_score(0)
	if event.is_action_pressed(button):
		$AnimatedSprite2D.frame = 1
	elif event.is_action_released(button):
		$Push.start()
		
	

func _on_push_timeout():
	$AnimatedSprite2D.frame = 0

func reset():
	current_note = null
	perfect = false
	good = false
	okay = false

func _on_perfect_area_entered(area):
	if area.is_in_group("note"):
		perfect = true

func _on_perfect_area_exited(area):
	if area.is_in_group("note"):
		perfect = false

func _on_good_area_entered(area):
	if area.is_in_group("note"):
		good = true

func _on_good_area_exited(area):
	if area.is_in_group("note"):
		good = false

func _on_okay_area_entered(area):
	if area.is_in_group("note"):
		okay = true
		current_note = area

func _on_okay_area_exited(area):
	if area.is_in_group("note"):
		reset()
