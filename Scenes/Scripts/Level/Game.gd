extends Node2D

@onready var note = preload("res://Scenes/Levels/Note.tscn")
@onready var note_holder = $Notes
@onready var label = $Panel/Label
@onready var combo_label = $Panel/Combo
@onready var conductor = $Conductor

var score = 0
var combo = 0

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

var bpm = 115

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_beat = [1, 1, 1, 1]

var lane = 0
var rand = 0

var finished: bool = false

func _ready():
	randomize()
	conductor.play_with_beat_offset(8)

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		Switch.scene(self, "res://Scenes/Levels/level_selector.tscn")

func song_finished():
	Score.set_score(score)
	Score.combo = max_combo
	Score.great = great
	Score.good = good
	Score.okay = okay
	Score.missed = missed
	Switch.scene(self, "res://Scenes/Levels/End.tscn")

func spawn_notes(to_spawn):
	if to_spawn > 0:
		lane = randi() % 3
		var instance = note.instantiate()
		note_holder.add_child(instance)
		instance.init(lane)
	if to_spawn > 1:
		while rand == lane:
			rand = randi() % 3
		lane = rand
		var instance = note.instantiate()
		note_holder.add_child(instance)
		instance.init(lane)
		

func increment_score(by):
	if by > 0:
		combo += 1
	else:
		combo = 0
	
	if by == 3:
		great += 1
	elif by == 2:
		good += 1
	elif by == 1:
		okay += 1
	else:
		missed += 1
	
	score += by * combo
	label.text = str(score)
	if combo > 0:
		combo_label.text = str(combo) + " combo!"
		if combo > max_combo:
			max_combo = combo
	else:
		combo_label.text = ""

func reset_combo():
	combo = 0
	combo_label.text = ""

func _on_conductor_measurex(pos):
	spawn_notes(spawn_beat[pos - 1])

# This function / signal thing is what controls the amount of buttons on the screen
# This function needs to be editted to look through a 2d or dictionary that's contents ~~
# ~~ are from a text file that someone has put timings in
func _on_conductor_beat(pos):
	song_position_in_beats = pos
	if song_position_in_beats > 36:
		spawn_beat = [1, 1, 1, 1]
	if song_position_in_beats > 98:
		spawn_beat = [2, 0, 1, 0]
	if song_position_in_beats > 132:
		spawn_beat = [0, 2, 0, 2]
	if song_position_in_beats > 162:
		spawn_beat = [2, 2, 1, 1]
	if song_position_in_beats > 194:
		spawn_beat = [2, 2, 1, 2]
	if song_position_in_beats > 228:
		spawn_beat = [0, 2, 1, 2]
	if song_position_in_beats > 258:
		spawn_beat = [1, 2, 1, 2]
	if song_position_in_beats > 288:
		spawn_beat = [0, 2, 0, 2]
	if song_position_in_beats > 322:
		spawn_beat = [3, 2, 2, 1]
	if song_position_in_beats > 388:
		spawn_beat = [1, 0, 0, 0]
	if song_position_in_beats > 396:
		spawn_beat = [0, 0, 0, 0]
	if song_position_in_beats > 404:
		song_finished()
