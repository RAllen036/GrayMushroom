extends Node

const PLAYER_NAME: String = "background_music"

func play(song_name: String = "Background"):
	# Checks to see if a player exists
	var player = get_node("/root/" + PLAYER_NAME)
	# If the stream player exists continue the song
	if player != null:
		player.playing = true
	# Create a stream player and add song from song name if provided
	
	var new_player = AudioStreamPlayer2D.new()
	new_player.stream = "res://Assets/Music/" + song_name
	

func _stop():
	# Removes the player from the root node
	pass

func pause():
	# Pauses the player
	pass
