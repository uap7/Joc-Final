extends Area2D


func _on_body_entered(body):
	if (body.name == "CharacterBody2D"):
		body.portal_g()
