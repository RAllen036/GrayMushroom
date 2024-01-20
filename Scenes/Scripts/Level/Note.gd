extends Node2D

# Used to get the sprite
@export var note = "a"

const TARGET_X = -164
const SPAWN_X = 16
const SPAWN_Y = 120
const DIST_TO_TARGET = TARGET_X - SPAWN_X

var speed: float = 100.0
var hit: bool = false

func _physics_process(delta):
	if !hit:
		position.x += speed * delta
		if position.x < -200:
			queue_free()
			get_parent().get_parent().reset_combo()
	else:
		$Node2D.position.y += speed * delta

func init(lane):
	
	if lane >= 0 and lane < 5:
		$AnimatedSprite2D.frame = lane
		position = Vector2(SPAWN_X, SPAWN_Y + 20 * lane)
	
	speed = DIST_TO_TARGET / 2.0

func destroy(score):
	$CPUParticles2D.emitting = true
	$AnimatedSprite.visible = false
	$Timer.start()
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

func _on_Timer_timeout():
	queue_free()
