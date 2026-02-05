extends Node3D

@onready var animation_tree: AnimationTree = %AnimationTree

func hurt():
	%AnimationTree.set("parameters/OneShot/request" , AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
