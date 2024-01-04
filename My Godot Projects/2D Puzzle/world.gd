extends Node2D

var enemy_scene = preload("res://Enemy/enemy.tscn")
# Called when the node enters the scene tree for the first time.

func _on_timer_timeout():
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(randf_range(20,1000), 20)
	add_child(enemy)
