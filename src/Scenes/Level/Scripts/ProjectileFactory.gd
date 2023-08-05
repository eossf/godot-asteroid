extends Node2D

func spawn_projectile(projectile):
	add_child(projectile)

func _on_player_projectile_fired(projectile):
	spawn_projectile(projectile)
