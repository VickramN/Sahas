extends CharacterBody2D

var speed = 75

var gravity  = ProjectSettings.get_setting("physics/2d/default_gravity")
var player

var isAttacking = false
var chase = false

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if chase == true and !isAttacking:
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			velocity.x = direction.x * speed
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("Walk")
		elif direction.x < 0:
			velocity.x = direction.x * speed
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("Walk")
	else:
		velocity.x = 0
		$AnimatedSprite2D.play("Idle")
	
	
	move_and_slide()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true
	

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		chase = false


func _on_attack_collison_body_entered(body: Node2D) -> void:
	if body.name =="Player":
		isAttacking = true
		print("Player hit")
		$AnimatedSprite2D.play("Attack")
