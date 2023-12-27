extends Node
class_name StateMachine

signal transitioned(state_name: String)

@export_node_path("State") var initial_state := NodePath()

@onready var state: State = get_node(initial_state) 

func _ready():
	await owner.ready
	for state: State in get_children():
		state.state_machine = self
	state.enter()

func _process(delta):
	if state:
		state.update(delta)
		
func _physics_process(delta):
	if state:
		state.update_physics(delta)

func transition_to(target_state_name: String, msg := {}):
	if not has_node(target_state_name):
		return
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	transitioned.emit(state.name)
