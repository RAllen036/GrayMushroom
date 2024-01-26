extends CanvasLayer

func _ready():
	$GradeNumber.text = Score.grade
	$ScoreNumber.text = str(Score.score)
	$ComboNumber.text = str(Score.combo)
	$PerfectNumber.text = str(Score.great)
	$GoodNumber.text = str(Score.good)
	$OkayNumber.text = str(Score.okay)
	$MissedNumber.text = str(Score.missed)

func _on_back_to_menu_pressed():
	Switch.scene(get_parent(), "res://Scenes/Levels/level_selector.tscn")

func _on_play_again_pressed():
	get_tree().reload_current_scene()
