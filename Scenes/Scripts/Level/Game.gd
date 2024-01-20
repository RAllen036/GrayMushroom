extends Node2D

@onready var note = preload("res://Scenes/Levels/Note.tscn")
@onready var note_holder = $Notes
@onready var label = $Panel/Label
@onready var combo_label = $Panel/Combo
@onready var conductor = $Conductor
@onready var start_timer = $StartWait
@onready var end_timer = $EndWait

var measures = []
var lane_pos = []

var score = 0
var combo = 0

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

var bpm = 100

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 60.0 / bpm

var spawn_beat = [1, 1, 1, 1]

var lane = 0
var rand = 0

var finished: bool = false

func _ready():
	get_beat_layout()
	randomize()
	conductor.play_with_beat_offset(8)

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		song_finished()

func song_finished():
	Score.set_score(score)
	Score.combo = max_combo
	Score.great = great
	Score.good = good
	Score.okay = okay
	Score.missed = missed
	Switch.scene(self, "res://Scenes/Levels/End.tscn")

func spawn_notes(to_spawn):
	
	#for item in lane_pos[to_spawn]
	pass

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
	for item in measures:
		if song_position_in_beats > item[0]:
			spawn_beat = item[1]

# x = song_pos_in_beats % 4 #### This will be when the pattern should start
# x = song_pos_in_measure
# Format = x:note_pattern
func get_beat_layout():
	# Read file
	# Gets the file as an object
	var file = FileAccess.open("res://BeatLayout/Game.txt", FileAccess.READ)
	# Gets the contents of the file
	var content = file.get_as_text()
	# Good practice so that corruption is less likely
	file.close()
	# Remove \n
	var content_list = content.split("\n", false)
	# Get the Values as boolean and add to measure based on instruments playing
	var new_content_list = []
	var last_set = ["00000"]
	var measure = []
	
	# Add comment on the absurdity below when able
	
	for i in range(0, content_list.size() - 1):
		
		if content_list[i] == "^":
			content_list[i] = last_set
		else:
			last_set = content_list[i]
		
		var temp_bool_list = []
		var total: int = 0
		for char in content_list[i]:
			var temp_int = char.to_int()
			total += temp_int
			temp_bool_list.append(bool(temp_int))
		
		measure.append(total)
		
		new_content_list.append(temp_bool_list)
		
		if measure.size() == 4:
			measures.append([i, measure])
			measure = []
	lane_pos = new_content_list
	#print(new_content_list)
	#print(measures)
	

# Tells us when the song is finished and waits 3 seconds for anything on screen
func _on_conductor_finished():
	end_timer.start()

func _on_end_wait_timeout():
	song_finished()


func _on_start_wait_timeout():
	conductor.play_with_beat_offset(8)
