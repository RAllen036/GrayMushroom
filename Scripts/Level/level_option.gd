# This whole scene allows for level options to be dynamically created without much effort

extends Node2D

signal selected(name: String, body:Node2D)

var level_name: String

func init(lev_name: String):
	level_name = lev_name
	$Label.text = lev_name.split(".",false)[0]

func _on_area_2d_body_entered(body):
	selected.emit(level_name, body)
