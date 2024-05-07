extends Node
@onready var attempts_label = $".."

var points = 0
func add_points():
	points += 1
	print(points)
	attempts_label.text = "Punts = " + str(points)
