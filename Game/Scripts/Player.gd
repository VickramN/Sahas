extends CharacterBody2D

class_name Player
@export var stats : Stats
@export var current_weapon: Weapon
#Player Movement Variable

@export var speed = 150
@export var jump_height = -300

#gravity cannot be changed
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#State variables for player
var isAttacking = false

func _ready() -> void:
	#loads default stats
	var default_stats = load("res://resources/mystats.tres")
	
func _physics_process(delta):
	#Calulate vertical movement speed(i.e Falling)
	velocity.y += gravity * delta
	
	horizontal_movement()
	move_and_slide()
	
	player_animations()
		
	
func horizontal_movement():
	#If left or right movement key is pressed, return 1 for right, return -1 for left, and 0 for staying still
	var horizontal_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	#caclulate player movement
	velocity.x = horizontal_input * speed
	
#Animations
func player_animations():
	if Input.is_action_pressed("ui_left") and is_on_floor() and !isAttacking:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("Run")
		$CollisionShape2D.position.x = -3
	
	if Input.is_action_pressed("ui_right") and is_on_floor() and !isAttacking:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Run")
	
	if !Input.is_anything_pressed() and is_on_floor() and !isAttacking:
		$AnimatedSprite2D.play("Idle")
	

func _input(event):
	if Input.is_action_pressed("ui_attack"):
		isAttacking = true
		velocity.x = 0
		$AnimatedSprite2D.play("Attack")
		
	
	if Input.is_action_pressed("ui_jump") and is_on_floor():
		velocity.y = jump_height
		$AnimatedSprite2D.play("Jump")
		
	


func equip_weapon():
	if current_weapon:
		current_weapon.equip(self)
		
func unequip_weapon():
	if current_weapon:
		current_weapon.unequip(self)
		current_weapon = null


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "Attack":
		isAttacking = false
