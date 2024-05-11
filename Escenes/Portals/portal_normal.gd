extends Node


func _on_body_entered(body):
	if body.name == "TileMap":
		pass
	
	else:
		body.portal_normal()
