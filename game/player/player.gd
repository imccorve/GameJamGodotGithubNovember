extends KinematicBody2D

var health = 30
var maxhealth = 100

var speed_x = 0
var speed_y = 0
var acceleration = 2500
var deceleration = 5000
const MAX_speed = 500
var velocity = Vector2()
var direction = 0

# smoothing the stops
var direction_sm = 0

var jump_cnt = 0
var MAX_JUMP_CNT = 2
const JUMP_FORCE = 700
const GRAVITY = 2500
const MAX_FALL_SPEED  = 1000
var is_jumping
var is_falling

var sprite_node
var anim
var hitbox 
var attackbox
var is_attacking

var is_attacked 
var DELAY_TIME = 100
var attacked_delay = DELAY_TIME
func _ready():
	set_fixed_process(true)
	set_process_input(true)
	sprite_node = get_node("Sprite")
	hitbox = get_node("hitbox")
	attackbox = get_node("attackbox")
	anim = get_node("AnimationPlayer")
	is_attacking = false
	is_jumping = false
	
	is_attacked = false
	
	
func _input(event):
	if jump_cnt < MAX_JUMP_CNT and event.is_action_pressed("ui_up"):
		speed_y = -JUMP_FORCE
		jump_cnt += 1
		is_jumping = true
		if(not anim.is_playing() or anim.get_current_animation().basename() != 'jump'):
			anim.play("jump")
			
func attack_finished():
	print("attack finished")
	is_attacking = false
	attackbox.disable()
	
func _fixed_process(delta):
	
	
	# input
	if direction:
		direction_sm = direction

	if Input.is_action_pressed("ui_right") and !is_attacking:
		direction = 1
		sprite_node.set_flip_h(false)
		if(not anim.is_playing() or anim.get_current_animation().basename() != 'run') and !is_jumping:
			anim.play("run")
	elif Input.is_action_pressed("ui_left") and !is_attacking:
		direction = -1
		sprite_node.set_flip_h(true)
		if(not anim.is_playing() or anim.get_current_animation().basename() != 'run') and !is_jumping:
			anim.play("run")
	else:
		direction = 0
#	if jump_cnt < MAX_JUMP_CNT and Input.is_action_pressed("ui_up"):
#		speed_y = -JUMP_FORCE
#		jump_cnt += 1
#		is_jumping = true
#		if(not anim.is_playing() or anim.get_current_animation().basename() != 'jump'):
#			anim.play("jump")

	
	if direction:
		speed_x += acceleration * delta
	else:
		speed_x -= deceleration * delta
	if speed_x <= 0 and !is_jumping and !is_attacking:
		if(not anim.is_playing() or anim.get_current_animation().basename() != 'idle'):
			anim.play("idle")

	# attack
	if Input.is_action_pressed("attack"):
		if(not anim.is_playing() or anim.get_current_animation().basename() != 'attack'):
			print("attacking")
			is_attacking = true
			anim.play("attack")
			attackbox.enable()

		
	# movement calc
	if direction - direction_sm:
		speed_x /= 2
	speed_x = clamp(speed_x, 0, MAX_speed)
	
	speed_y += GRAVITY * delta
	if speed_y > MAX_FALL_SPEED:
		speed_y = MAX_FALL_SPEED
	velocity.x = speed_x * delta * direction_sm
	velocity.y = speed_y * delta
	var movement_remainder = move(velocity)
	

	if is_colliding():
		var normal = get_collision_normal()
		var final_movement = normal.slide(movement_remainder)
		speed_y = normal.slide(Vector2(0, speed_y)).y
		move(final_movement)
		
		if normal == Vector2(0, -1):
			is_jumping = false
			jump_cnt = 0
			
	# Being attacked
	if is_attacked:
		print("decre")
		attacked_delay -= 2
	if attacked_delay <= 0:
		print("attack delay time up")
		attacked_delay = DELAY_TIME
		is_attacked = false
	
	if is_colliding():

		var entity = get_collider()
		if entity.is_in_group("enemy") && !is_attacked:
			health -= 2
			print("hit player")
			is_attacked = true
		
	if health <= 0:
		set_pos(Vector2(0,0))
		health = 100

func foot_step():
	get_node("SoundEffects").play("footstep" + str(randi() % 2 + 1))
	

	
func save():
	var save_dict = {
		pos = {
			x = get_pos().x,
			y = get_pos().y
		},
		direction_sm = direction_sm,
		maxhealth = maxhealth,
		health = health
	}
	return save_dict
	
