extends Node2D

var score = 0
var combo = 0
var great = 0
var good = 0
var okay = 0
var missed: int = 0
var total_notes: int = 0
var grade = "NA"

func eval_grade():
	var miss_per: float = missed / total_notes
	print(miss_per)
	print(missed)
	print(total_notes)
	if miss_per < 0.1:
		grade = "A+"
	elif miss_per < 0.15:
		grade = "A"
	elif miss_per < 0.2:
		grade = "B"
	elif miss_per < 0.3:
		grade = "C"
	elif miss_per < 0.4:
		grade = "D"
	elif miss_per < 0.5:
		grade = "E"
	elif miss_per < 0.6:
		grade = "F"
	
