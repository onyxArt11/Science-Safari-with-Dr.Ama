extends Node3D

var state = 1
@onready var timer = $Timer


@onready var animation_player = $AnimationPlayer

@onready var cam = $Camera3D
@onready var player = $Node3D
@onready var task1 = [Vector3(3.53,1.249,3.68),Vector3(16.526,2.739,4.779)]
var switch:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$SpotLight3D.visible = false
	$CSGCylinder3D2.visible = true
	$switches/CSGBox3D2/talk.monitoring = false
	$switches/CSGBox3D2/talk2.monitoring = false
	$switches/CSGBox3D2.position = Vector3(3.026,-0.825,2.764)
	$switches/CSGBox3D.position = Vector3(16.553,2.384,2.764)
	$switches/CSGBox3D3.position = Vector3(8.61,5.346,2.764)
	$switches/CSGBox3D2/talk3.monitoring = false
# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_node_3d_go():
	switch = false
	if player.progress == 0:
		animation_player.play("task1")
		cam.current = true
	if player.progress == 1:
		animation_player.play("task2")
		cam.current = true
		$switches/CSGBox3D.visible = false
		$switches/CSGBox3D/switch.monitoring = false
	if player.progress == 2:
		animation_player.play("task3")
		cam.current = true
		$switches/CSGBox3D.visible = false
		$switches/CSGBox3D3.visible = false
	if player.progress == 3:
		player.switch = true
		timer.start(4)
	
func _on_animation_player_animation_finished(anim_name):
	if player.progress != 4:
		cam.current = false
		player.cam.current = true
		player.cine = false
		player.switch = false
	else:
		player.success.play()


func _on_switch_body_entered(body):
	if body.is_in_group("player"):
		if !switch:
			switch = true
			body.velocity = Vector3.ZERO
			var pos = body.progress
			body.anim_player.play("idle")
			body._asses(pos)

func turn_switch(body):
	if body.progress != 4:
		body.switch = true
		body.velocity = Vector3.ZERO
		body.anim_player.play("Pick")
	else:
		body.switch = true
		animation_player.play("task_4")

func _on_node_3d_task_completed(progress):
	if progress == 0:
		animation_player.play("task1_complet")
		cam.current = true
		player.cam.current = false
	if progress == 1:
		animation_player.play("task2_complete")
		cam.current = true
		player.cam.current = false
		$plant_bowl/GPUParticles3D.visible = true
		$plant_bowl/Sakura/absorb.visible = true
		$plant_bowl/water_absorb.play("absorb")
		$plant_bowl/rain.play()
	if progress == 2:
		animation_player.play("task3_complet")
		cam.current = true
		player.cam.current = false

func _on_talk_body_entered(body):
	if body.is_in_group("player"):
		if body.progress == 0 and switch:
			body.progress = 1
			body._cine(1,0)
			body.velocity = Vector3.ZERO
			body.visuals.rotation = Vector3(0,-90,0)



func _on_talk_2_body_entered(body):
	if body.is_in_group("player"):
		if body.progress == 1 and switch:
			body.progress = 2
			body._cine(2,0)
			body.velocity = Vector3.ZERO
			body.visuals.rotation = Vector3(0,-90,0)
			$switches/CSGBox3D3.position = Vector3(8.61,3.607,2.764)
			


func _on_talk_3_body_entered(body):
	if body.is_in_group("player"):
		if body.progress == 2 and switch:
			body.progress = 3
			body._cine(3,0)
			body.velocity = Vector3.ZERO
			body.visuals.rotation = Vector3(0,-90,0)
			$switches/CSGBox3D3.position = Vector3(8.61,3.607,2.764)


func _on_node_3d_right(body):
	turn_switch(body)


func _on_timer_timeout():
	player.cine = false
	player.anim_player.play("idle")
	player._asses(3)
	player.progress = 4
