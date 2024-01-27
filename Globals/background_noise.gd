extends Node

const PLAYER_NAME: String = "background_music"

func load_mp3(path):
	var file = load(path)
	return file
	

func play(song_name: String = "Background"):
	# Checks to see if a player exists
	var player = get_node("/root/BackMusic/" + PLAYER_NAME)
	# If the stream player exists continue the song
	if player != null:
		player.stream_paused = false
		return
	# Create a stream player and add song from song name if provided
	
	var new_player = AudioStreamPlayer2D.new()
	add_child(new_player)
	new_player.name = PLAYER_NAME
	var song = load_mp3("res://Assets/Music/" + song_name + ".mp3")
	if song == null: print("Not loaded song")
	new_player.set_stream(song)
	new_player.finished.connect(audio_stop)
	new_player.play()

func stop():
	# Removes the player from the root node
	var player = get_node("/root/BackMusic/" + PLAYER_NAME)
	if player == null: return null
	player.queue_free()

func pause():
	# Pauses the player
	var player = get_node("/root/BackMusic/" + PLAYER_NAME)
	if player == null: return null
	player.stream_paused = true

func audio_stop():
	var player = get_node("/root/BackMusic/" + PLAYER_NAME)
	if player == null: return null
	player.play()
