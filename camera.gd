extends Camera2D

var lerp_target = Vector2(0,0)
var lerp_speed = 1.0

var scenes = {"game" : "res://game.tscn",
"menu" : "res://main_menu/main_menu.tscn",
"win" : "res://win_screen/win_screen.tscn",
"save":"res://save_n_load/save_n_load.tscn",
}
const NORMAL_MSG = 0

func set_scene(cmd):
	if cmd.size() < 2:
		get_node("term").write_res("[x] No scene given", 1)
	if not scenes.has(cmd[1]):
		get_node("term").write_res("[x] No scene with that name", 1)
		return
	print ("Setting scene to: ", cmd[1])
	get_tree().change_scene(scenes[cmd[1]])

func _ready():
	set_process(true)

func _process(delta):
	set_pos(get_pos().linear_interpolate(lerp_target, lerp_speed * delta))

func _on_bg_on_command( cmd ):
	var command = []
	var cmd_f = cmd.split(" ")
	for arg in cmd_f:
		command.append(arg)
	
	if command[0] == "setscn":
		set_scene(command)
	elif command[0] == "dmg":
		set_player_damage(command)

func set_player_damage(cmd):
	if cmd.size() > 1:
		var new_damage = int(cmd[1])
		if new_damage <= 0:
			get_node("term").write_res("[x] Damage not > 1, no change", 1)
		else:
			player.damage = new_damage
			get_node("term").write_res("[v] Damage is now " +str(player.damage), 3)
	else:
		pass

func set_lerp_target(pos, speed=1.0):
	lerp_target = pos
	lerp_speed = speed