extends Node2D

var distance_per_beat = -200
var speed: float
var hit: bool = false

func _physics_process(delta):
	if !hit:
		position.x += speed * delta
		if position.x < distance_per_beat * 3:
			get_parent().get_parent().increment_score(0)
			queue_free()
	else:
		$Node2D.position.x += speed * delta
		var tween = get_tree().create_tween()
		tween.tween_property($Node2D, "scale", Vector2(0.15, 0.15), 2)
		if $Node2D.scale <= Vector2(0.2, 0.2):
			queue_free()

func init(lane, bpm):
	$AnimatedSprite2D.frame = lane
	# BPM of 120 and 60 seconds in a min
	var bps: float = 60.0 / bpm
	# Speed required to get from a pos of 0 to x in 1 beat
	speed = distance_per_beat / bps
	
	match lane:
		0:
			position = Vector2(0, 56)
		1:
			position = Vector2(0, 94)
		2:
			position = Vector2(0, 132)
		3:
			position = Vector2(0, 170)
		4:
			position = Vector2(0, 208)
	

func destroy(score):
	$CPUParticles2D.emitting = true
	$AnimatedSprite2D.hide()
	hit = true
	if score == 3:
		$Node2D/Label.text = "GREAT"
		$Node2D/Label.modulate = Color("f6d6bd")
	elif score == 2:
		$Node2D/Label.text = "GOOD"
		$Node2D/Label.modulate = Color("c3a38a")
	elif score == 1:
		$Node2D/Label.text = "OKAY"
		$Node2D/Label.modulate = Color("997577")
