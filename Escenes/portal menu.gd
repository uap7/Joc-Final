extends Area2D

@onready var character_body_2d = $"."

func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		body.win()
		print("win")
