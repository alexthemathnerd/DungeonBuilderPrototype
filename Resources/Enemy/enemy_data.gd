class_name EnemyData
extends Resource

const EnemyType: Dictionary = {
	
}

@export_enum("GOBLIN") var enemy_type: String
@export var animation: SpriteFrames
@export var hitbox: Shape2D
