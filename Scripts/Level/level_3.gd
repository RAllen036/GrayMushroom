extends Node2D

@onready var note = preload("res://Scenes/LevelUtil/Note.tscn")
@onready var end_screen = preload("res://Scenes/LevelUtil/End.tscn")
@onready var note_holder = $Notes
@onready var label = $Panel/Label
@onready var combo_label = $Panel/Combo
@onready var conductor = $Conductor
@onready var start_timer = $StartWait
@onready var end_timer = $EndWait
@onready var back = $SizedBackground

@export var beat_file_name = "Game"

var measures = []
var lane_pos = []

var score = 0
var combo = 0

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

@export var bpm = 240

var spawn_beat = [1, 1, 1, 1]

var lane = 0
var rand = 0

var finished: bool = false

var played_notes: float = 0
var total_notes: float = 0

func _ready():
	back.size = get_viewport_rect().size
	$GraySquare.re_size(get_viewport_rect().size)
	get_beat_layout()
	randomize()
	conductor.play_with_beat_offset(2)

func _process(delta):
	$GraySquare.set_mixer(1 - ((played_notes-missed)/total_notes))
	if get_viewport().size_changed:
		back.size = get_viewport_rect().size
		$GraySquare.re_size(get_viewport_rect().size)

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		song_finished()

func song_finished():
	if conductor.playing == true:
		conductor.stop()
	Score.combo = max_combo
	Score.great = great
	Score.good = good
	Score.okay = okay
	Score.missed = missed
	Score.total_notes = played_notes
	Score.eval_grade()
	var end = end_screen.instantiate()
	add_child(end)

func spawn_notes(pos):
	
	if pos < lane_pos.size():
		for i in range(0, lane_pos[pos].size()):
			if lane_pos[pos][i]:
				played_notes += 1
				var ins = note.instantiate()
				note_holder.add_child(ins)
				ins.init(i, (bpm / 2))
				ins.add_to_group("note", true)
	

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
	label.text = "Score: " + str(score)
	if combo > 0:
		combo_label.text = str(combo) + " combo!"
		if combo > max_combo:
			max_combo = combo
	else:
		combo_label.text = "combo!"

func _on_conductor_beat(pos):
	spawn_notes(pos)
	if $Friends/Birdo.frame == 0:
		$Friends/Birdo.frame = 1
	else:
		$Friends/Birdo.frame = 0
	if $Friends/Player.frame == 0:
		$Friends/Player.frame = 1
	else:
		$Friends/Player.frame = 0
	if $Friends/Flute.frame == 0:
		$Friends/Flute.frame = 1
	else:
		$Friends/Flute.frame = 0
	if $Friends/Cymbal.frame == 0:
		$Friends/Cymbal.frame = 1
	else:
		$Friends/Cymbal.frame = 0

func get_beat_layout():
	# Read file
	# Gets the file as an object
	var file = FileAccess.open("res://Assets/BeatLayout/" + beat_file_name + ".txt", FileAccess.READ)
	
	# Gets the contents of the file
	var content = file.get_as_text()
	# Good practice so that corruption is less likely
	file.close()
	# Remove \n
	var content_list = content.split("\n", false)
	# Get the Values as boolean based on instruments playing
	var new_content_list = []
	var last_set = ["00000"]
	
	# Add comment on the absurdity below when able
	
	for i in range(0, content_list.size() - 1):
		
		if content_list[i] == "^":
			content_list[i] = last_set
		else:
			last_set = content_list[i]
		
		var temp_bool_list = []
		for char in content_list[i]:
			var temp_int = char.to_int()
			var temp_bool = bool(temp_int)
			temp_bool_list.append(temp_bool)
			if bool(temp_bool):
				total_notes += 1
		
		new_content_list.append(temp_bool_list)
		
	lane_pos = new_content_list
	#print(lane_pos)
	

# Tells us when the song is finished and waits 3 seconds for anything on screen
func _on_conductor_finished():
	end_timer.start()

func _on_end_wait_timeout():
	song_finished()

func _on_start_wait_timeout():
	conductor.play_with_beat_offset(2)

