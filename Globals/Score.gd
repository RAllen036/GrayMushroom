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
	var total = great + good + okay
	var percent = total / total_notes
	
	if percent > 0.9:
		grade = "A+"
	elif percent > 0.85:
		grade = "A"
	elif percent > 0.8:
		grade = "A-"
	elif percent > 0.7:
		grade = "B"
	elif percent > 0.6:
		grade = "C"
	elif percent > 0.5:
		grade = "D"
	elif percent > 0.4:
		grade = "E"
	elif percent > 0.3:
		grade = "F"
	else:
		grade = "NA"
	
