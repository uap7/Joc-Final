extends Area2D

@onready var character_body_2d = $"."

func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		get_tree().change_scene_to_file("res://felicitaciófons.tscn")
