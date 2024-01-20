extends AudioStreamPlayer

var bpm: int = 100
var measures: int = 4

# Tracking the beat and song position
var song_position: float = 0.0
var song_position_in_beats: int = 1
var sec_per_beat: float = 60.0 / bpm
var last_reported_beat: int = 0
var beats_before_start: int = 0
var measure: int = 1

# Determining how close to the beat an event is
# Un sure how use full this is rn
var closest = 0
var time_off_beat = 0.0

signal beat(pos)
signal measurex(pos)

func _ready():
	sec_per_beat = 60.0 / bpm

func _physics_process(delta):
	if is_playing():
		song_position = get_playback_position() + AudioServer.get_time_since_last_mix()
		song_position -= AudioServer.get_output_latency()
		song_position_in_beats = int(floor(song_position / sec_per_beat)) + beats_before_start
		report_beat()

func report_beat():
	if last_reported_beat < song_position_in_beats:
		if measure > measures:
			measure = 1
		emit_signal("measurex", measure)
		emit_signal("beat", song_position_in_beats)
		last_reported_beat = song_position_in_beats
		measure += 1

func play_song():
	play()

func play_with_beat_offset(num):
	beats_before_start = num
	$StartTimer.wait_time = sec_per_beat
	$StartTimer.start()

func play_from_beat(beat, offset):
	play()
	seek(beat * sec_per_beat)
	beats_before_start = offset
	measure = beat % measures

func _on_start_timer_timeout():
	beats_before_start -= 1
	if beats_before_start > 1:
		report_beat()
		$StartTimer.start()
	else:
		play_song()

func closest_beat(nth):
	closest = int(round((song_position / sec_per_beat) / nth) * nth)
	time_off_beat = abs(closest * sec_per_beat - song_position)
	return Vector2(closest, time_off_beat)
