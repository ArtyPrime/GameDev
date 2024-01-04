extends CharacterBody2D

@export var SPEED = 30.0
var JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = get_tree().get_first_node_in_group("player")
var chase = false


func _ready():
	get_node("AnimatedSprite2D").play("Idle")
	
func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	var direction = player.position.normalized()
	direction = (player.position - self.position).normalized()

	if chase == true:
		if get_node("AnimatedSprite2D").animation != "Hit":
			get_node("AnimatedSprite2D").play("Run")
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
			velocity.x = direction.x * SPEED
		elif direction.x < 0:
			get_node("AnimatedSprite2D").flip_h = true
			velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "Hit":
			#print("Checked")
			get_node("AnimatedSprite2D").play("Idle")
			velocity.x = 0
	
	move_and_slide()
	
func _on_detection_body_entered(body):
	if body.name == "Player":
		chase = true


func _on_detection_body_exited(body):
	get_node("AnimatedSprite2D").play("Idle")
	var direction = (player.global_position - self.global_position).normalized()
	if body.name == "Player":
		chase = false
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
		elif direction.x < 0:
			get_node("AnimatedSprite2D").flip_h = true
		velocity.x = 0


#func _on_player_death_body_entered(body):
#	if body.name == "Player":
#		Game.playerHP -= 1
		

func _on_enemy_death_body_entered(body):
	if body.name == "Player":
		death()
		
func death():
		Game.coin += 1
		velocity.x = 0
		get_node("AnimatedSprite2D").play("Hit")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()
		Utility.saveGame()
